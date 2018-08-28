//
//  NetworkAndDebug_Header.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/10/28.
//  Copyright © 2015年 GhGh. All rights reserved.
//
// 方法
#import "GA_Log_Anything.h"
// 网络请求
#import "GARequest.h"

#ifndef GA_Base_FrameWorkHeader_h
#define GA_Base_FrameWorkHeader_h
//判断是否是iPhoneX的设备
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2800), [[UIScreen mainScreen] currentMode].size)) : NO)
//判断是否是iPhone6Plus的设备
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone7Plus iPhone6Plus  //判断是否是iPhone7Plus的尺寸
// 1334*750分辨率；iPhone6 Plus采用5.5寸屏，1920*1080分辨率
//判断是否是iPhone6的设备  375.000000    667.000000 - 在放大模式下不准确
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone7 iPhone6   //判断是否是iPhone7的尺寸
//判断是否是iphone5的设备
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是iphone4s的设备
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

// 判断系统版本
#define FlostRepair(floatNum) (floatNum - 0.01)
#define IOS9 [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(9.0) && [[UIDevice currentDevice].systemVersion floatValue] < 10.0
#define IOS9_OVER [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(9.0)
#define IOS10 [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(10.0) && [[UIDevice currentDevice].systemVersion floatValue] < 11.0
#define IOS10_OVER [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(10.0)
#define IOS11 [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(11.0) && [[UIDevice currentDevice].systemVersion floatValue] < 12.0
#define IOS11_OVER [[UIDevice currentDevice].systemVersion floatValue] >= FlostRepair(11.0)

#define  GAScrollViewInsets_NO(scrollView,vc)\
if(IOS11_OVER)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0);

////打印输出
//#ifdef DEBUG
//
//#define GALOG(...) NSLog(__VA_ARGS__)
//#define GALOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd))
//
//#else
//
//#define GALOG(...) ;
//#define GALOG_CURRENT_METHOD ;
//
//#endif

/*
 打印日志信息
 */
#ifndef __OPTIMIZE__
# define NSLog(...) NSLog(@"\n%s 第%d行📍\n%@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__]);
# define NSLOG_CURRENT_METHOD NSLog(@"%@-%@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
#else
#    define NSLog(...) {};
#endif

/*
 block - weak - strong
 */
#define STWeakSelf(type)  __weak typeof(type) weak##type = type;
#define STStrongSelf(type)  __strong typeof(type) type = weak##type;

/*********
 宏作用:单例生成宏
 **********/
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)shared##className;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

#define marginPadding5 5
#define marginPadding10 10
#define marginPadding20 20
#define marginPadding14 14
#define marginPadding15 15
#define marginPadding1 1.0


#define UI_SCREEN_WIDTH                 ([[UIScreen mainScreen] bounds].size.width)
#define UI_SCREEN_HEIGHT                ([[UIScreen mainScreen] bounds].size.height)
#define UI_SCREEN_SCALE                    (1.0f/[UIScreen mainScreen].scale)
//RBG color
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
//读取图片两种方式
#define LOADIMAGE(file) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:@"png"]]
#define IMAGE(name) [UIImage imageNamed:name]

#define CIMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
// 颜色
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]






#endif /* NetworkAndDebug_Header_h */

