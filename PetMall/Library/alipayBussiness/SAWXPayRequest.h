//
//  SAWXPayRequest.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SARequest.h"

@interface SAWXPayRequest : SARequest

@property(nonatomic, copy) NSString *userId;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *payType;
@property(nonatomic, copy) NSString *rechargeType;
@property(nonatomic, copy) NSString *targetId;

@end
