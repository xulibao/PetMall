//
//  GADebugServerModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface GADebugServerModel : NSManagedObject
/**
 *  服务器名称
 */
@property (nonatomic, retain) NSString *name;
/**
 *  服务器地址
 */
@property (nonatomic, retain) NSString *url;
/**
 *  是否为当前可用服务器
 */
@property (nonatomic, retain) NSNumber *enabled;
@end
