//
//  NSTimer+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (GHExtension)
// 间隔调用
+ (NSTimer*)timeScheduleTimerWithTimerInternal:(NSTimeInterval)interval  block:(void(^)())block
    repeats:(BOOL)repeats;

// 返回 1970 时间戳
+ (NSString *)displayDateWithJsonDate:(NSString *)jsondate formatter:(NSString *)formatter;
// 给日期，直接返回字符串
+ (NSString *)displayDateWithNSDate:(NSDate *)date formatter:(NSString *)formatter;
@end
