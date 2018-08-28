//
//  GADebugCrashModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GADebugCrashModel : NSObject
/**
 *  crash所在页面
 */
@property (nonatomic, copy) NSString *page;
/**
 *  crash名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  App版本号
 */
@property (nonatomic, copy) NSString *version;
/**
 *  操作系统版本
 */
@property (nonatomic, copy) NSString *osversion;
/**
 *  设备类型
 */
@property (nonatomic, copy) NSString *device;
/**
 *  网络类型
 */
@property (nonatomic, copy) NSString *network;
/**
 *  name_iphone
 */
@property (nonatomic, copy) NSString *name_iphone;
/**
 *  ip地址
 */
@property (nonatomic, copy) NSString *ip;
/**
 *  渠道号
 */
@property (nonatomic, copy) NSString *channel;
/**
 *  crash时间
 */
@property (nonatomic, copy) NSDate *date;
/**
 *  设备状态
 */
@property (nonatomic, copy) NSString *mark;
/**
 *  崩溃的堆栈信息
 */
@property (nonatomic, copy) NSString *stack;

@end
