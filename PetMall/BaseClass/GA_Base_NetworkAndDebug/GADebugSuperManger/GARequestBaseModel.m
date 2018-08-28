//
//  GARequestBaseModel.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GARequestBaseModel.h"

@implementation GARequestBaseModel
// 添加单例模式
+ (instancetype)sharedInstance{
    static dispatch_once_t once;
    static id singleton;
    dispatch_once(&once, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}
- (NSDictionary *) requestParams{
    return nil;
}

- (NSString *)requestBusiness{
    return  nil;
}
@end
