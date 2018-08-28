//
//  GARequestBaseModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GARequestBaseModel : NSObject
// 单例
+ (instancetype)sharedInstance;
/**
 *  整合请求参数
 *
 *  @return 请求参数字典
 */
- (NSDictionary *)requestParams;
/**
 *  网络请求的业务地址：myGA/getHotelFavorites... etc.
 *
 *  @return 网络请求业务地址
 */
- (NSString *)requestBusiness;

@end
