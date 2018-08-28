//
//  GACrashRequestModel.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GACrashRequestModel.h"

@implementation GACrashRequestModel
- (NSString *)requestBusiness{
    return @"GA/saveCrash";
}

- (NSDictionary *) requestParams{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:self.pageName forKey:@"PageName"];
    [param setValue:self.exceptionName forKey:@"ExceptionName"];
    [param setValue:[NSNumber numberWithInteger:self.exceptionType] forKey:@"ExceptionType"];
    [param setValue:self.exceptionsStackDetail forKey:@"ExceptionsStackDetail"];
    [param setValue:self.appVersion forKey:@"AppVersion"];
    [param setValue:self.osVersion forKey:@"OsVersion"];
    [param setValue:self.deviceModel forKey:@"DeviceModel"];
    [param setValue:self.netWorkType forKey:@"NetWorkType"];
    [param setValue:self.deviceStatus forKey:@"DeviceStatus"];
    [param setValue:self.channelId forKey:@"ChannelId"];
    [param setValue:[NSNumber numberWithInteger:self.clientType] forKey:@"ClientType"];
    [param setValue:self.netWorkCarrier forKey:@"NetWorkCarrier"];
    [param setValue:self.crashTime forKey:@"CrashTime"];
    [param setValue:self.appName forKey:@"AppName"];
    [param setValue:self.GAAccount forKey:@"GAAccount"];
    [param setValue:self.phoneNumber forKey:@"PhoneNumber"];
    [param setValue:self.deviceId forKey:@"DeviceId"];
    
    return param;
}

@end
