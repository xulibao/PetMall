//
//  GADeviceUtil.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/11/2.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GADeviceUtil : NSObject
// 返回mac地址
+ (NSString *)macaddress;

// 设备类型
+ (NSString *)device;

// 显示当前还有多少内存可用
+ (void)showAvailableMemory;

// 获取一个GUID字符串
+ (NSString *)GUIDString;
@end
