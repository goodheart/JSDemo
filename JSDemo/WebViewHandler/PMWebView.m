//
//  PMWebView.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMWebView.h"

@interface PMWebView ()<UIWebViewDelegate>
@property (nonatomic,copy) NSURL * destinationURL;
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) JSContext * context;
@property (nonatomic,copy) NSString * contextKey;
@property (nonatomic,strong) id<JSExport> contextHandler;

#pragma mark - Private Method
- (void)initUIWithFrame:(CGRect)frame;
@end

@implementation PMWebView
#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUIWithFrame:frame];
    }
    return self;
}

- (void)awakeFromNib {
    [self initUIWithFrame:self.frame];
}

- (void)dealloc {
    [self.webView stopLoading];
}

#pragma mark - Public Method
- (void)loadFromURL:(NSURL *)url {
    self.destinationURL = url;
    //UIWebView开始加载网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)stopLoading {
    [self.webView stopLoading];
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context[self.contextKey] = self.contextHandler;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([self.configurationDelegate respondsToSelector:@selector(webView:failWithType:)]) {
        [self.configurationDelegate webView:self
                               failWithType:PMWebViewFailTypeWebViewLoadFailed];
    }
}

#pragma mark - Private Method
- (void)initUIWithFrame:(CGRect)frame {
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    self.webView.delegate = self;
    
    [self addSubview:self.webView];
}

#pragma mark - Lazy Initialization
- (NSString *)contextKey {
    if (_contextKey) {
        return _contextKey;
    }
    
    if ([self.configurationDelegate respondsToSelector:@selector(contextKeyForWebView:)]) {
        _contextKey = [self.configurationDelegate contextKeyForWebView:self];
    }
    
    if (nil == _contextKey) {
        if ([self.configurationDelegate respondsToSelector:@selector(webView:failWithType:)]) {
            [self.configurationDelegate webView:self
                                   failWithType:PMWebViewFailTypeNoContextKey];
        }
    }
    
    return _contextKey;
}

- (id<JSExport>)contextHandler {
    if (_contextHandler) {
        return _contextHandler;
    }
    
    if ([self.configurationDelegate respondsToSelector:@selector(contextHandlerForWebView:)]) {
        _contextHandler = [self.configurationDelegate contextHandlerForWebView:self];
    }
    
    if (nil == _contextHandler) {
        if ([self.configurationDelegate respondsToSelector:@selector(webView:failWithType:)]) {
            [self.configurationDelegate webView:self
                                   failWithType:PMWebViewFailTypeNoContextHandler];
        }
    }
    
    return _contextHandler;
}

- (JSContext *)context {
    if (_context) {
        return _context;
    }
    
    _context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [_context setExceptionHandler:^(JSContext * context, JSValue * value) {
       
    }];
    
    return _context;
}
@end






