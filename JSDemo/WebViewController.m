//
//  WebViewController.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "WebViewController.h"
#import "PMWeb.h"
@interface WebViewController ()<PMWebDelegate>
@property (nonatomic,strong) PMWeb * web;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.webView loadFromURL
    self.web = [[PMWeb alloc] init];
    self.web.delegate = self;
}

#pragma mark - PMWebDelegate
- (void)goBack {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlert {
    [self.webView evaluateJavaScriptScript:[NSString stringWithFormat:@"showName(%@)",@(arc4random() % 100000)]];
}

#pragma mark - PMWebViewConfigurationDelegate
- (id<JSExport>)contextHandlerForWebView:(PMWebView *)webView {
    return self.web;
}

- (NSString *)contextKeyForWebView:(PMWebView *)webView {
    return @"web";
}

- (void)webView:(PMWebView *)webView failWithType:(PMWebViewFailType)failType {
    switch (failType) {
        case PMWebViewFailTypeWebViewLoadFailed:
            NSLog(@"Load Failed");
            break;
            case PMWebViewFailTypeNoContextHandler:
            NSLog(@"No Context Handler");
            break;
            case PMWebViewFailTypeNoContextKey:
            NSLog(@"No Context Key");
            break;
        default:
            break;
    }
}

@end
