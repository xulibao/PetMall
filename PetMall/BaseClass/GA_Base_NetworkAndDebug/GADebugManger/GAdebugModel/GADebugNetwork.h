//
//  GADebugNetwork.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugObject.h"
#import "GADebugNetworkModel.h"
@interface GADebugNetwork : GADebugObject

+ (GADebugNetwork *)sharedInstance;

/**
 *  开始网络请求
 *
 *  @return 请求Model
 */
- (GADebugNetworkModel *)beginRequest;
/**
 *  结束网络请求
 *
 *  @param networkModel 请求Model
 */
- (void)endRequest:(GADebugNetworkModel *)networkModel;
/**
 *  清空过期的数据
 */
- (void)cleanRequest;
/**
 *  清空所有数据
 */
- (void)clearRequest;
/**
 *  所有的网络请求
 *
 *  @return 所有的请求Model
 */
- (NSArray *)requests;
/**
 *  时间限定范围内的网络请求
 *
 *  @param beginDate 开始时间
 *  @param endDate   结束时间
 *
 *  @return 所有符合条件的请求Model
 */
- (NSArray *)requestsBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;
@end
