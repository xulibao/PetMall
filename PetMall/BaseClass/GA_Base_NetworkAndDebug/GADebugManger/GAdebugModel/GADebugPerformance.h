//
//  GADebugPerformance.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugObject.h"
#import "GADebugMemoryModel.h"
@interface GADebugPerformance : GADebugObject

+ (GADebugPerformance *)sharedInstance;

/**
 *  获取当前系统的内存情况
 *
 *  @return 内存Model
 */
- (GADebugMemoryModel *)memery;
@end
