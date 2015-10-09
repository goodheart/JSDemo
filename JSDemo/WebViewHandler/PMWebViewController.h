//
//  PMWebViewController.h
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef NS_ENUM(NSUInteger,PMWebViewControllerFailType) {
    PMWebViewControllerFailTypeNoContextKey,
    PMWebViewControllerFailTypeNoContextHandler,
    PMWebViewControllerFailTypeWebViewLoadFailed
};

@class PMWebViewController;
@protocol PMWebViewControllerConfigurationDelegate <NSObject>
@required
- (NSString *)webViewController:(PMWebViewController *)webViewController
           contextKeyForWebView:(UIWebView *)webView;
- (id<JSExport>)webViewController:(PMWebViewController *)webViewController
         contextHandlerForWebView:(UIWebView *)webView;

@optional
- (CGRect)webViewContoller:(PMWebViewController *)webViewController
           frameForWebView:(UIWebView *)webView;
- (void)webViewController:(PMWebViewController *)webViewController
             failWithType:(PMWebViewControllerFailType)failType;
@end

@interface PMWebViewController : UIViewController
//用来进行配置的代理
@property (nonatomic, weak) id<PMWebViewControllerConfigurationDelegate> configurationDelegate;

+ (id)webViewControllerWithDestinationURL:(NSURL *)destinationURL;

@end
