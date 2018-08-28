//
//  STWebViewEntity.h
//  SnailTruck
//
//  Created by imeng on 2018/2/1.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STShareProtocol.h"

@interface STH5ViewConfig : NSObject

@property(nonatomic, copy) NSString *navigationBarTitleText;
@property(nonatomic, copy) NSString *rightButtonTitleText;
@property(nonatomic, copy) NSString *rightButtonIconURL;
@property(nonatomic, copy) NSString *rightButtonAction;
@property(nonatomic, assign) BOOL hasRightButton;

@end

@interface STH5PayEntity : NSObject

@property(nonatomic, copy) NSString *orderID;// 订单号码，交易号码
@property(nonatomic, copy) NSString *price;// 金额
@property(nonatomic, copy) NSString *orderName;// 商品名字
@property(nonatomic, copy) NSString *orderDesc;// 商品描述

@end
@interface STH5ShareEntity : NSObject<STShareProtocol>

@property(nonatomic, copy) NSString *title;// 标题
@property(nonatomic, copy) NSString *content;// 内容
@property(nonatomic, copy) NSString *shareURL;// 分享的页面URL
@property(nonatomic, copy) NSString *shareImageURL;// 分享的图片URL

@end
