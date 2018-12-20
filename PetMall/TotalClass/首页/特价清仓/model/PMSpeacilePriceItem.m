//
//  PMSpeacilePriceItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/12/19.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMSpeacilePriceItem.h"
#import "PMSpeacilePriceCell.h"

@implementation PMSpeacilePriceItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMSpeacilePriceCell class];
    }
    return _cellClass;
}
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
