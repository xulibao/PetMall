//
//  PMExpressModel.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/12.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMExpressModel.h"

@implementation PMExpressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"express_id":@"id"};
}

- (NSString *)express_price{
    if (_express_price == nil) {
        _express_price = @"5.00";
    }
    return _express_price;
}
@end
