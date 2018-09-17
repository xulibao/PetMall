//
//  SAMenuRecordModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/14.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMenuRecordModel : NSObject

@property(nonatomic, copy) NSString * name;
// 给服务器的id
@property(nonatomic, copy) NSString * serveID;

@property(nonatomic, copy) NSString * serveValue;

@property(nonatomic, copy) NSString * serveSubID; //针对年份和公里范围

@property(nonatomic, copy) NSString * serveKey;

@property(nonatomic, copy) NSString * serveSubKey;

@property(nonatomic, copy) NSString * tbName;

@property(nonatomic, copy) NSString * tbId;

@property(nonatomic, copy) NSString * tmName;

@property(nonatomic, copy) NSString * tmId;

@property(nonatomic, assign) BOOL isSelect;
@property(nonatomic, assign) BOOL isShowArrow;

@end
