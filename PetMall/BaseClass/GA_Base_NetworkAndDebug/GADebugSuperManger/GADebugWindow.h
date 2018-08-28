//
//  GADebugWindow.h
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
#ifdef DEBUG
#import <UIKit/UIKit.h>
//#define GA_DEBUG_NOTI_SERVERCHANGED   @"GA_EBUG_NOTI_SERVERCHANGED"    // 服务器地址变更
#import "GADebugManager.h"
@interface GADebugWindow : UIWindow
+ (void)show;
@end
#endif
