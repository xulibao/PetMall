//
//  SAAlipayToolModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAAlipayToolModel : NSObject

@property (nonatomic, copy) NSString *orderNo; // 订单号码，交易号码，订单repayId
@property (nonatomic, copy) NSString *productDescription; // 商品描述
@property (nonatomic, copy) NSString *price; // 金额
@property (nonatomic, copy) NSString *alipayCallBackUrl; // 金额
@property(nonatomic, copy) NSString *secretStr; // MD5校验

@end
