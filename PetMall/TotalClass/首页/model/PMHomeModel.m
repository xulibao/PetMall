//
//  PMHomeModel.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/24.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMHomeModel.h"
#import "PMCommonGoodsCell.h"

@implementation PMHomeModel

+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"Broadcast" : @"PMBroadCastModel",
              @"secondkill" : @"PMSecondkillModel",
              @"presale" : @"PMPresaleModel",
              @"group" : @"PMGroupModel",
              @"clearing" : @"PMClearingModel"
              };
}


@end

@implementation PMHomeCouponModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"couponId":@"id"};
}
@end

@implementation PMHomeTimelimitModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"timelimitId":@"id"};
}
@end

@implementation PMSecondkillModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"secondkillId":@"id"};
}
@end

@implementation PMPresaleModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"presaleId":@"id"};
}
@end

@implementation PMHomeGrouplimitModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"grouplimitId":@"id"};
}
@end

@implementation PMGroupModel
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMCommonGoodsCell class];
    }
    return _cellClass;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"groupId":@"id"};
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}
@end

@implementation PMHomeBargainModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"bargainId":@"id"};
}
@end

@implementation PMClearingModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"clearingId":@"id"};
}
@end

@implementation PMBroadCastModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"broadCastId":@"id"};
}
@end


