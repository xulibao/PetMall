//
//  PMTimeLimitItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/12/18.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMTimeLimitItem.h"
#import "PMTimeLimitCell.h"

@implementation PMTimeLimitNavItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"timeLimitNavId":@"id"};
}

@end

@implementation PMTimeLimitItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMTimeLimitCell class];
    }
    return _cellClass;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"timeLimitId":@"id"};
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}
@end
