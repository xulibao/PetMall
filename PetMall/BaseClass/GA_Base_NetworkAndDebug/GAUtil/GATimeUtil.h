//
//  GATimeUtil.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/11/2.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GATimeUtil : NSObject
// 获取今天以后（之前）x月的日期
+ (NSDate *)getPreviousDateWithMonth:(NSInteger)month;

// 获取今天还是明天的日期
+ (NSString *)descriptionFromDate:(NSDate *)date;

// 计算时间差
+ (NSString *)intervalSinceNow: (NSString *) theDate;

// 判断是否同一天
+ (BOOL)twoDateIsSameDay:(NSDate *)fistDate
                  second:(NSDate *)secondDate;

// 按照秒数获取x天x小时x分x秒的时间，format使用"DD-HH-mm-ss"决定输出哪些单位的时间
+ (NSString *)getNormalTimeWithSeconds:(NSInteger)currentTime Format:(NSString *)format;

//C2C 时间
+(NSString *)makeJsonDateWithNSTimeInterval_C2C:(NSTimeInterval)seconds;
/**
 *  获取星期x字符串
 *
 *  @param jsondate jsonDate
 *
 *  @return 获取星期x的Str
 */
+(NSString *)getWeekStrWithJson:(NSString *)jsondate;

// ===================== 原TimeUtil ==========================================

// 得到星期几
+ (NSString *)getShortWeekend:(NSDate *)newDate;


// ===================== 原TimeUtil ==========================================
+(void)setDefaultTimeZoneWithUTC;
+(NSDate *)NSStringToNSDate:(NSString *)string  formatter:(NSString *)formatter;
+(NSString *)dPCalendarDateToString:(NSDate *)date;
+(NSDate *)gmtNSDateToGMT8NSDate:(NSDate *)date formatter:(NSString *)formatter;
+(NSString *)displayDateWithNSDate:(NSDate *)date formatter:(NSString *)formatter;
+(NSString *)displayDateWithNSTimeInterval:(NSTimeInterval)seconds formatter:(NSString *)formatter;
+(NSString *)displayDateWithJsonDate:(NSString *)jsondate formatter:(NSString *)formatter;
+(NSDate *)parseJsonDate:(NSString *)jsondate;
+(NSString *)makeJsonDateWithNSTimeInterval:(NSTimeInterval)seconds;
+(NSString *)makeJsonDateWithUTCDate:(NSDate *)utcDate;
+(NSString *)makeJsonDateWithDisplayNSStringFormatter:(NSString *)string formatter:(NSString *)formatter;
+(NSDate *)gmtNSDateToGMT8NSDate:(NSDate *)date;
+(NSDate *)displayNSStringToGMT8NSDate:(NSString *)s;
+(NSDate *)resetNSDate:(NSDate *)date  formatter:(NSString *)formatter;
+(NSDate *)displayNSStringToGMT8CNNSDate:(NSString *)s;
+ (NSString *)displayNoTimeZoneJsonDate:(NSString *)jsonDate formatter:(NSString *)formatter;

@end
