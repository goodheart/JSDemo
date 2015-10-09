//
//  PMWebViewController.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface PMWebViewController ()<UIWebViewDelegate>
/* Private Property */
@property (nonatomic,copy) NSURL * destinationURL;
@property (nonatomic,strong) UIWebView * webView;
@property (nonatomic,strong) JSContext * context;
@property (nonatomic,copy) NSString * contextKey;
@property (nonatomic,strong) id<JSExport> contextHandler;
@end

@interface PMWebViewController ()

@end

@implementation PMWebViewController
#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:self.destinationURL];
    [self.webView loadRequest:request];
}

- (void)dealloc {
    [self.webView stopLoading];
}

#pragma mark - Public Method
+ (id)webViewControllerWithDestinationURL:(NSURL *)destinationURL {
    PMWebViewController * webViewController = [[[self class] alloc] init];
    
    webViewController.destinationURL = destinationURL;
    
    return webViewController;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.context[self.contextKey] = self.contextHandler;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if ([self.configurationDelegate respondsToSelector:@selector(webViewController:failWithType:)]) {
        [self.configurationDelegate webViewController:self
                                         failWithType:PMWebViewControllerFailTypeWebViewLoadFailed];
    }
}

#pragma mark - Lazy Initlization
- (UIWebView *)webView {
    if (_webView) {
        return _webView;
    }
    _webView = [[UIWebView alloc] init];
    
    CGRect webViewFrame = self.view.bounds;//默认View页面大小
    
    if ([self.configurationDelegate respondsToSelector:@selector(webViewContoller:frameForWebView:)]) {
       CGRect frame = [self.configurationDelegate webViewContoller:self
                                     frameForWebView:_webView];
        if (!CGRectIsEmpty(frame)) {//如果不是CGRectZero,则进行设置
            webViewFrame = frame;
        }
    }
    
    _webView.frame = webViewFrame;
    _webView.delegate = self;
    
    return _webView;
}

- (NSString *)contextKey {
    if (_contextKey) {
        return _contextKey;
    }
    
    if ([self.configurationDelegate respondsToSelector:@selector(webViewController:contextKeyForWebView:)]) {
        _contextKey = [self.configurationDelegate webViewController:self
                                 contextKeyForWebView:self.webView];
    }

    if (nil == _contextKey) {
        if ([self.configurationDelegate respondsToSelector:@selector(webViewController:failWithType:)]) {
            [self.configurationDelegate webViewController:self
                                             failWithType:PMWebViewControllerFailTypeNoContextKey];
        }
    }
    
    return _contextKey;
}

- (id<JSExport>)contextHandler {
    if (_contextHandler) {
        return _contextHandler;
    }
    
    if ([self.configurationDelegate respondsToSelector:@selector(webViewController:contextHandlerForWebView:)]) {
        _contextHandler = [self.configurationDelegate webViewController:self
                             contextHandlerForWebView:self.webView];
    }
    
    if (nil == _contextHandler) {
        if ([self.configurationDelegate respondsToSelector:@selector(webViewController:failWithType:)]) {
            [self.configurationDelegate webViewController:self
                                             failWithType:PMWebViewControllerFailTypeNoContextHandler];
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
        NSLog(@"faild");
    }];
    
    return _context;
}

@end






