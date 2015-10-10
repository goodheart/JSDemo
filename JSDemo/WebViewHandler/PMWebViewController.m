//
//  PMWebViewController.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMWebViewController.h"
@interface PMWebViewController ()
@property (nonatomic,strong,readwrite) PMWebView * webView;
@property (nonatomic,copy) NSURL * destinationURL;
@end

@interface PMWebViewController ()

@end

@implementation PMWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[PMWebView alloc] initWithFrame:self.view.bounds];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.webView.configurationDelegate = self;
    [self.view addSubview:self.webView];
    if (nil != self.destinationURL) {
        [self.webView loadFromURL:self.destinationURL];
    }
}

#pragma mark - Public Method
+ (id)webViewControllerWithDestinationURL:(NSURL *)destinationURL {
    PMWebViewController * webViewController = [[[self class] alloc] init];
    webViewController.destinationURL = destinationURL;
    return webViewController;
}

#pragma mark - PMWebViewConfigurationDelegate
- (NSString *)contextKeyForWebView:(PMWebView *)webView {
    return nil;
}

- (id<JSExport>)contextHandlerForWebView:(PMWebView *)webView {
    return nil;
}

- (void)webView:(PMWebView *)webView failWithType:(PMWebViewFailType)failType {
    
}







@end






