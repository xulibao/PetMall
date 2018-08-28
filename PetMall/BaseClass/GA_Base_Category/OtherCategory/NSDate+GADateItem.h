//
//  NSDate+GADateItem.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 16/7/3.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface GADateItem : NSObject
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger hour;
@property (nonatomic, assign) NSInteger minute;
@property (nonatomic, assign) NSInteger second;
@end

@interface NSDate (GAExtension)
- (GADateItem *)ga_timeIntervalSinceDate:(NSDate *)anotherDate;
- (BOOL)ga_isToday;
- (BOOL)ga_isYesterday;
- (BOOL)ga_isTomorrow;
- (BOOL)ga_isThisYear;
//获取今天周几
- (NSInteger)getNowWeekday;

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
