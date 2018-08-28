//
//  GADebugMemoryModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  free是空闲内存;
 *  active是已使用，但可被分页的(在iOS中，只有在磁盘上静态存在的才能被分页，例如文件的内存映射，而动态分配的内存是不能被分页的);
 *  inactive是不活跃的，实际上内存不足时，你的应用就可以抢占这部分内存，因此也可看作空闲内存;
 *  wire就是已使用，且不可被分页的。
 */
typedef struct GA_debug_memory{
    double free;
    double active;
    double inactive;
    double wire;
    double zero_fill;
    double reactivations;
    double pageins;
    double pageouts;
    double faults;
    double cow_faults;
    double lookups;
    double hits;
}GA_debug_memory;

@interface GADebugMemoryModel : NSObject
/**
 *  可使用内存
 */
@property (nonatomic,assign) double availableMemory;
/**
 *  已用内存
 */
@property (nonatomic,assign) double usedMemory;
/**
 *  内存详情
 */
@property (nonatomic,assign) GA_debug_memory memory;
@end
