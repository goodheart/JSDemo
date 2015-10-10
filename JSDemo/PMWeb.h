//
//  PMWeb.h
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol PMWebDelegate <NSObject>

- (void)goBack;
- (void)showAlert;

@end

@protocol PMWebExport <JSExport>

- (void)backHome; //返回应用的上一个页面
- (NSString *)getLoginUserId; //获取用户唯一标示符,如果未登录，返回空字符串
- (NSString *)getLoginUserNickName; //获取用户昵称,获取用户昵称
- (UIImage *)getLoginUserPic; //获取用户头像,如果未登录，返回空字符
- (NSString *)getPhoneNum; //获取用户手机号,如果绑定手机返回手机号，没有返回空字符串
- (void)showLoginPhoneAlert; //弹出登录框, 如需要登录调用此函数
- (NSString *)getPhoneIMEI; //获取手机imei,android返回imei，ios返回唯一标示符UID
- (void)scanCode; //扫描条形码,调起摄像头扫描条形码
- (void)openUserInfo:(NSString *)userID; //跳到用户主页
- (void)gotoLogin; //跳到登陆页面

@end

@interface PMWeb : NSObject<PMWebExport>

@property (nonatomic,weak) id<PMWebDelegate> delegate;


@end




