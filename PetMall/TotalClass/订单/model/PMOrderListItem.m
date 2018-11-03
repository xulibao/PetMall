//
//  SAOrderListItem.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//
#import "PMOrderListCell.h"
#import "NSAttributedString+STAttributedString.h"

#import "PMOrderListItem.h"
@implementation PMOrderItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMOrderListCell class];
    }
    return _cellClass;
}

+(NSDictionary *)mj_objectClassInArray
{
    return @{ @"order_list" : @"PMOrderListItem"
              };
}

//标签
- (NSArray<NSAttributedString*> *)tagsText {
    PMOrderListItem * firstItem = [self.order_list firstObject];
    NSMutableArray *aTags = [NSMutableArray array];
    switch ([firstItem.status integerValue]) {
        case 1:{
            NSString *string = [NSString stringWithFormat:@"取消订单"];
            [aTags addObject:[string attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
            [aTags addObject:[@"付款" attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
        }
            break;
        case 2:{
        }
            break;
        case 4:{
            NSString *string = [NSString stringWithFormat:@"确认收货"];
            [aTags addObject:[string attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
            [aTags addObject:[@"评价" attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
        }
            break;
            
        default:
            break;
    }
  
    return aTags;
}
@end

@implementation PMOrderListItem

- (NSString *)pay_price{
    if (_pay_price == nil) {
        _pay_price = _market_price;
    }
    return _pay_price;
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}

@end
