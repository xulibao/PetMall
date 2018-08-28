//
//  GAURLSessionConfiguration.h
//  GA_Base_NetworkAndDebug
//
//  Created by GhGh on 2017/6/9.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAURLSessionConfiguration : NSObject
@property (nonatomic,assign) BOOL isSwizzle;
+ (instancetype)defaultConfiguration;
/**
   转换
 */
- (void)load;

/**
   取消
 */
- (void)unload;
@end
