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

@property(nonatomic, strong) NSMutableArray *recommendList;

@end

@interface DCRecommendItem : NSObject

/** 图片URL */
@property (nonatomic, copy ) NSString *image_url;
/** 商品标题 */
@property (nonatomic, copy ) NSString *main_title;
/** 商品小标题 */
@property (nonatomic, copy ) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ) NSString *price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 属性 */
@property (nonatomic, copy ) NSString *nature;
/** cantuanrenshy */
@property(nonatomic, strong) NSString *people_count;
/** 折扣 */
@property(nonatomic, strong) NSString *discount;
/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;

@property(nonatomic, assign) BOOL isSelect;

@property(nonatomic, assign) PMCellLocationType cellLocationType;
@end
