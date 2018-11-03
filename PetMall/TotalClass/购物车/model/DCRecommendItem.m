//
//  DCRecommendItem.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCRecommendItem.h"

@implementation DCRecommendItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"goodId":@"id"};
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}

@end

@implementation PMCartItem
+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"order_list" : @"DCRecommendItem"
              };
}

@end
