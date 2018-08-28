//
//  GADebugWindow.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
#ifdef DEBUG
#define K_DebugView_UI_Screen_W  [[UIScreen mainScreen] bounds].size.width
#define K_DebugView_UI_Screen_H  [[UIScreen mainScreen] bounds].size.height
#import "GADebugWindow.h"
#import "GADebugViewController.h"
@implementation GADebugWindow
static UIWindow *window_;
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, K_DebugView_UI_Screen_W, 25);
    window_.windowLevel = UIWindowLevelAlert;
    window_.hidden = NO;
    window_.alpha = 0.5;
    window_.rootViewController = [GADebugViewController sharedInstance];
    window_.backgroundColor = [UIColor clearColor];
}

@end
#endif
