//
//  PMWebViewController.h
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMWebView.h"
@interface PMWebViewController : UIViewController<PMWebViewConfigurationDelegate>

@property (nonatomic,strong,readonly) PMWebView * webView;

+ (id)webViewControllerWithDestinationURL:(NSURL *)destinationURL;



@end
