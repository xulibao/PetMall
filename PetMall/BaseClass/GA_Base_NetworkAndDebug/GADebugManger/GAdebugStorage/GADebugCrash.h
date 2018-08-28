//
//  GADebugCrash.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugObject.h"
#import "GADebugCrashModel.h"
@interface GADebugCrash : GADebugObject

+ (GADebugCrash *)sharedInstance;
    
/**
 *  开始记录crash
 *
 *  @return crashModel
 */
- (GADebugCrashModel *)beginCrash;
/**
 *  结束并存储crash数据
 */
- (void)endCrash;
/**
 *  所有的crash数据
 *
 *  @return 所有的crash数据
 */
- (NSArray *)crashes;
/**
 *  清空所有的crash数据
 */
- (void)clearCrash;
@end
