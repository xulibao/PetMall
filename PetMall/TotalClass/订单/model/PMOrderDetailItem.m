//
//  PMOrderDetailItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailItem.h"
#import "PMOrderDetailCell.h"
#import "NSAttributedString+STAttributedString.h"

@implementation PMOrderDetailAdressItem

@end

@implementation PMOrderDetailModel

- (NSString *)statusText{
    PMOrderDetailGoodsItem *goodsItem = [self.goods firstObject];
    switch ([goodsItem.status integerValue]) {
        case 1:{
            _statusText = @"等待付款";
        }
            break;
        case 2:{
            _statusText = @"买家已付款";
        }
            break;
        case 4:{
            
        }
            break;
        case 8:{
            _statusText = @"已申请退款";
        }
            break;
            
        default:
            break;
    }
    return _statusText;
}

+(NSDictionary *)mj_objectClassInArray{
    
    return @{ @"address" : @"PMOrderDetailAdressItem",
              @"goods" : @"PMOrderDetailGoodsItem"
              };
}
@end

@implementation PMOrderDetailInfoModel

@end

@implementation PMOrderDetailGoodsItem

@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMOrderDetailCell class];
    }
    return _cellClass;
}
//标签
- (NSArray<NSAttributedString*> *)tagsText {
    NSMutableArray *aTags = [NSMutableArray array];
    [aTags addObject:[@"退款" attributedStingWithAttributes:SADefaultNormalAttributes(13)]];
    return aTags;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"goods_id":@"id"};
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}

@end
