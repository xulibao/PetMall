//
//  SAWXPayRequest.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SARequest.h"

@interface SAWXPayRequest : SARequest

@property(nonatomic, copy) NSString *body;
@property(nonatomic, copy) NSString *totalFee;
@property(nonatomic, copy) NSString *orderId;

@end
