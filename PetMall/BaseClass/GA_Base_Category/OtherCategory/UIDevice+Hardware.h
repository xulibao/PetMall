//
//  UIDevice+Hardware.h
//  ClientTest
//
//  Created by GhGh on 16/7/22.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Hardware)

/**
 电池电量
 */
- (NSString *)batteryLevel_iphone;

/**
    iPhone名称
 */
- (NSString *)name_iphone;
/**
   当前用户使用的什么网络
 */
- (NSString *)currentNetState;

/**
 当前系统版名称  例如iPhone OS
 */
- (NSString *)system_Name;

/**
   当前系统版本号码 例如9.3.2
 */
- (NSString *)system_Version;
/**
    获取ip
 */
- (NSString *)getDeviceIPAddresses;
/**
 *  return 平台信息
 */
- (NSString *)platformString;

/**
 *  return cpu型号
 */
- (NSString *)cpuType;

/**
 *  return cpu频率
 */
- (NSString *)cpuFrequency;

/**
 *  return cpu核数
 */
- (NSUInteger)cpuCount;

/**
 *  return cpu利用率
 */
- (NSArray *)cpuUsage;

/**
 *  return 手机内存总量,返回的是字节数
 */
- (NSUInteger)totalMemoryBytes;

/**
 *  return 手机可用内存,返回的是字节数
 */
- (NSUInteger)freeMemoryBytes;

/**
 *  return 手机硬盘空闲空间,返回的是字节数
 */
- (long long)freeDiskSpaceBytes;

/**
 *  return 手机硬盘总空间,返回的是字节数
 */
- (long long)totalDiskSpaceBytes;

/**
 *  return 是否越狱
 */
- (BOOL)isJailBreak;

/**
 *  return 是否支持蓝牙
 */
- (BOOL)bluetoothCheck;
@end
