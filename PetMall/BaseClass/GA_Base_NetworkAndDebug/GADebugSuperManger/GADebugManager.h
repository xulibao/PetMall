//
//  GADebugManager.h
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "GADebugManager.h"
#import "GADebugNetwork.h"
#import "GADebugServer.h"
#import "GADebugPerformance.h"
#import "GADebugStorage.h"
#import "GADebugUILineView.h"
#import "GADebugAdsView.h"
#import "GADebugCrash.h"
#ifdef DEBUG

@interface GADebugManager : NSObject
/**
 *  1网络模块
 *
 *  @return GADebugNetwork对象
 */
+ (GADebugNetwork *)networkInstance;
/**
 *  2服务器模块
 *
 *  @return GADebugServer对象
 */
+ (GADebugServer *)serverInstance;
/**
 *  3性能模块
 *
 *  @return GADebugPerformance对象
 */
+ (GADebugPerformance *)performanceInstance;
/**
 *  4存储模块
 *
 *  @return GADebugStorage对象
 */
+ (GADebugStorage *)storageInstance;
/**
 *  5业务模块
 *
 *  @return GADebugUILineView对象
 */
+ (GADebugUILineView *)UILineInstance;
/**
 *  6广告模块
 *
 *  @return GADebugAdsView对象
 */
+ (GADebugAdsView *)adsInstance;

/**
 *  7crash模块
 *
 *  @return GADebugCrash对象
 */
+ (GADebugCrash *)crashInstance;
@end
#endif
