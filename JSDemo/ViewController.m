//
//  ViewController.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "ViewController.h"
#import "PMWebViewController.h"
#import "PMWeb.h"

@interface ViewController ()<PMWebViewControllerConfigurationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL * url = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    PMWebViewController * webViewController = [PMWebViewController webViewControllerWithDestinationURL:url];
    webViewController.configurationDelegate = self;
    [self.navigationController pushViewController:webViewController
                                         animated:YES];
}

#pragma mark - PMWebViewControllerConfigurationDelegate
- (CGRect)webViewContoller:(PMWebViewController *)webViewController frameForWebView:(UIWebView *)webView {
    return CGRectZero;
}

- (NSString *)webViewController:(PMWebViewController *)webViewController contextKeyForWebView:(UIWebView *)webView {
    return @"web";
}

- (void)webViewController:(PMWebViewController *)webViewController failWithType:(PMWebViewControllerFailType)failType {
    NSLog(@"%ld",failType);
}

- (id<JSExport>)webViewController:(PMWebViewController *)webViewController contextHandlerForWebView:(UIWebView *)webView {
    return [[PMWeb alloc] init];
}

@end







