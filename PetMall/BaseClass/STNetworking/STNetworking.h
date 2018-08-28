//
//  GANetworking.h
//  GA_Base_NetworkAndDebug
//
//  Created by imeng on 12/13/16.
//  Copyright © 2016 GhGh. All rights reserved.
//
// header头部字段数据

#import <Foundation/Foundation.h>

@interface STNetworking : NSObject

+ (void)initNetworking;
+ (NSString *)host;//https://www.woniuhuoche.com/truck
+ (NSString *)stHost;
+ (NSString *)imageHost;//http://7xoaj5.com1.z0.glb.clouddn.com/

// headerUrl 处理
+ (NSDictionary<NSString *, NSString *> *)defaultRequestHeaderFieldValueDictionary;

@end

@class QNUploadManager;
@interface STNetworkingBusiness : NSObject
DEFINE_SINGLETON_FOR_HEADER(STNetworkingBusiness)
// 如果修改url header直接修改这个字典
@property (nonatomic, strong)NSMutableDictionary *defaultRequestHeaderCacheDictM;

@property (nonatomic, strong) QNUploadManager *imageUploadManager;

@end
