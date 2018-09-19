//
//  PMCommonGoodsItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMCommonGoodsItem : STCommonBaseTableRowItem
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

@property (copy , nonatomic , readonly)NSArray *images;

@end
