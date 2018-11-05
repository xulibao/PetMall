//
//  PMGoodsItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleItem.h"
#import "PMGoodSaleCell.h"
@implementation PMGoodSaleItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMGoodSaleCell class];
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
