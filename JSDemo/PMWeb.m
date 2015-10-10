//
//  PMWeb.m
//  JSDemo
//
//  Created by majian on 15/10/10.
//  Copyright © 2015年 majian. All rights reserved.
//

#import "PMWeb.h"

@implementation PMWeb

- (NSString *)getLoginUserNickName {
    return @"呵呵";
}

- (void)backHome {
    if ([self.delegate respondsToSelector:@selector(goBack)]) {
        [self.delegate goBack];
    }
}

@end
