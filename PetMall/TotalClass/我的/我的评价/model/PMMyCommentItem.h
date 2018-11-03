//
//  PMMyCommentItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMMyCommentItem : STCommonBaseTableRowItem

@property (nonatomic, copy ) NSString *goodId;

@property (nonatomic, copy ) NSString *comment_id;
/** 用户图片 */
@property (nonatomic, copy ) NSString *img;
/** 图片URL */
@property (nonatomic, copy ) NSString *goods_logo;
/** 商品小标题 */
@property (nonatomic, copy ) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ) NSString *market_price;

@property (nonatomic, copy ) NSString *selling_price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *goods_stock;
/** 属性 */
@property (nonatomic, copy ) NSString *list_id;
/** cantuanrenshy */
@property(nonatomic, strong) NSString *goods_shul;
/** 评论 */
@property(nonatomic, strong) NSString *user_comment;
/** 用户名*/
@property(nonatomic, strong) NSString *user_name;
/** 时间*/
@property(nonatomic, strong) NSString *user_time;
/** 评论图片 */
@property(nonatomic, strong) NSString *user_images;
/** 商品说明 */
@property(nonatomic, strong) NSString *goods_spec;

@property(nonatomic, strong) NSMutableArray *goodsImageArray;


@property(nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect imagesFrames;;

@end
