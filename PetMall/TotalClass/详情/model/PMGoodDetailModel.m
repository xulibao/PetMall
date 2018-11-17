//
//  PMGoodDetailModel.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/11/2.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMGoodDetailModel.h"
#import "PMMyCommentItem.h"

@implementation PMGoodDetailSpecificationModel

@end

@implementation PMGoodDetailChoiceModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"specifications" : @"PMGoodDetailSpecificationModel",
              };
}
@end

@implementation PMGoodDetailPriceModel
@end

@implementation PMGoodDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"goodId":@"id"};
}
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comment" : @"PMMyCommentItem",
             @"choice" : @"PMGoodDetailChoiceModel",
             @"price" : @"PMGoodDetailPriceModel",
              };
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}

- (NSMutableArray *)goodsImageArray{
    if (_goodsImageArray == nil) {
        NSArray *picArray = [self.goods_image componentsSeparatedBySthString:@"|"];
        _goodsImageArray = [NSMutableArray array];
        for (NSString * imageStr in picArray) {
            if (![imageStr hasPrefix:[STNetworking host]]) {
                [_goodsImageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host],imageStr]];
            }
        }
    }
    return _goodsImageArray;
}
@end
