//
//  GADebugNetworkModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface GADebugNetworkModel : NSManagedObject
/**
 *  网络请求开始时间
 */
@property (nonatomic, retain) NSDate *begindate;
/**
 *  网络请求下行数据
 */
@property (nonatomic, retain) NSString *data;
/**
 *  网络请求结束时间
 */
@property (nonatomic, retain) NSDate *enddate;
/**
 *  网络请求方法
 */
@property (nonatomic, retain) NSString *method;
/**
 *  网络请求地址
 */
@property (nonatomic, retain) NSString *path;
/**
 *  回传数据大小，未压缩之前
 */
@property (nonatomic, retain) NSNumber *size;
/**
 *  网络请求数据类型
 */
@property (nonatomic, retain) NSString *type;
/**
 *  网络请求状态
 */
@property (nonatomic, retain) NSNumber *statuscode;
/**
 *  post请求的body数据
 */
@property (nonatomic, retain) NSString *body;
/**
 *  网络请求header
 */
@property (nonatomic, retain) NSString *header;
@end
