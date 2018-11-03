//
//  DCRecommendItem.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    PMCellLocationTypeSingle , // 单独一个
    PMCellLocationTypeTop, // 顶部
    PMCellLocationTypeMiddle, // 顶部
    PMCellLocationTypeBottom, // 顶部
} PMCellLocationType;
@interface PMCartItem : NSObject

@property(nonatomic, strong) NSMutableArray *order_list;


@end

@interface DCRecommendItem : NSObject

@property (nonatomic, copy ) NSString *goodId;

@property (nonatomic, copy ) NSString *cart_id;

/** 图片URL */
@property (nonatomic, copy ) NSString *goods_logo;
/** 商品小标题 */
@property (nonatomic, copy ) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ) NSString *market_price;
/** cantuanrenshy */
@property(nonatomic, strong) NSString *goods_shul;
/** 描述 */
@property(nonatomic, strong) NSString *goods_spec;

@property(nonatomic, strong) NSString *list_id;

@property(nonatomic, assign) BOOL isSelect;

@property(nonatomic, assign) PMCellLocationType cellLocationType;
@end
