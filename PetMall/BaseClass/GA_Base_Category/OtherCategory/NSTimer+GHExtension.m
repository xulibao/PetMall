//
//  NSTimer+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "NSTimer+GHExtension.h"

@implementation NSTimer (GHExtension)
+ (NSTimer*)timeScheduleTimerWithTimerInternal:(NSTimeInterval)interval
                                       block:(void(^)())block
                                     repeats:(BOOL)repeats
{
    NSTimer* timer = [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(timeTimerBlockInvoke:) userInfo:[block copy] repeats:repeats];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //保留NSTimer类对象，可忽略
    return timer;
}
+ (void)timeTimerBlockInvoke:(NSTimer*)timer
{
    void(^block)() = timer.userInfo;
    if(block){
        block();
    }
}

+ (NSString *)displayDateWithJsonDate:(NSString *)jsondate formatter:(NSString *)formatter{
    if (jsondate.length == 10) {
        jsondate = [NSString stringWithFormat:@"%@000",jsondate];
    }
    return [self displayDateWithNSDate:[self parseJsonDate:jsondate] formatter:formatter];
    
}

+ (NSString *)displayDateWithNSDate:(NSDate *)date formatter:(NSString *)formatter{
    
    NSTimeZone *tz=[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSDateFormatter* f = [[NSDateFormatter alloc] init];
    [f setTimeZone:tz];
    [f setDateFormat:formatter];
    NSString* s=[f stringFromDate:date];
    return s;
    
}
+ (NSDate *)parseJsonDate:(NSString *)jsondate{
    NSTimeInterval interval;
    NSRange range1 = [jsondate rangeOfString:@"/Date("];
    NSRange range2 = [jsondate rangeOfString:@")/"];
    if (range1.length ==0 && range2.length == 0) {
        interval = [jsondate longLongValue]/1000;
    }else{
        NSInteger start = range1.location + range1.length;
        NSInteger end = range2.location;
        
        NSCharacterSet* timezoneDelimiter = [NSCharacterSet characterSetWithCharactersInString:@"+-"];
        NSRange rangeOfTimezoneSymbol = [jsondate rangeOfCharacterFromSet:timezoneDelimiter];
        if (rangeOfTimezoneSymbol.length!=0) {
            NSInteger firstend = rangeOfTimezoneSymbol.location;
            
            NSRange secondrange=NSMakeRange(start, firstend-start);
            NSString* timeIntervalString = [jsondate substringWithRange:secondrange];
            
            unsigned long long s = [timeIntervalString longLongValue];
            interval = s/1000;
        }
        else {
            NSRange timerange=NSMakeRange(start, end-start);
            NSString* timestring =[jsondate substringWithRange:timerange];
            unsigned long long t = [timestring longLongValue];
            interval = t/1000;
        }
    }
    return [NSDate dateWithTimeIntervalSince1970:interval];
}

@end
