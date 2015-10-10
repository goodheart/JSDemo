//
//  PMWebView.h
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef NS_ENUM(NSUInteger,PMWebViewFailType) {
    PMWebViewFailTypeNoContextKey,
    PMWebViewFailTypeNoContextHandler,
    PMWebViewFailTypeWebViewLoadFailed
};

@class PMWebView;
@protocol PMWebViewConfigurationDelegate <NSObject>
@required
- (NSString *)contextKeyForWebView:(PMWebView *)webView;
- (id<JSExport>)contextHandlerForWebView:(PMWebView *)webView;

@optional
- (void)webView:(PMWebView *)webView
             failWithType:(PMWebViewFailType)failType;
@end
@interface PMWebView : UIView

//用来进行配置的代理
@property (nonatomic, weak) id<PMWebViewConfigurationDelegate> configurationDelegate;

- (void)loadFromURL:(NSURL *)url;
- (void)stopLoading;
- (void)evaluateJavaScriptScript:(NSString *)script;
@end
