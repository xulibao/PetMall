//
//  SAMineModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAMineModel : NSObject

@property (nonatomic, copy) NSString *titleName;//标题
@property (nonatomic, assign) Class className;//类名

@property (nonatomic, copy) NSString *infoCountText; // 消息个数
@property (nonatomic, copy) NSString *descCount;//标签个数
@property (nonatomic, copy) NSString *descTitle;//简介

@property (nonatomic, strong) NSString *iconImage; //图标
@property (nonatomic, assign) BOOL isNeedLogin;//是否需要登录

@property (nonatomic, assign) NSInteger badgeNumber;//数字角标

@property (nonatomic, assign) Class cellClass; //cell类型

@property (nonatomic, copy) void(^cellAction)(SAMineModel *model);

@end
