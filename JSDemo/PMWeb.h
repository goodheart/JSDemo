//
//  PMWeb.h
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
@protocol PMWebExport <JSExport>

- (NSString *)getUserNickName;

@end

@interface PMWeb : NSObject<PMWebExport>

@end
