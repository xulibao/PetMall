//
//  PMGoodsItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMGoodSaleItem : STCommonBaseTableRowItem

@property(nonatomic, copy) NSString *goodId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *package_stock;//库存
@property(nonatomic, copy) NSString *package_sale;//收货数量
@property(nonatomic, copy) NSString *package_pl;//评论数量
@property(nonatomic, copy) NSString *package_ok; //好评率
@property(nonatomic, copy) NSString *list_id; //价格id
@property(nonatomic, copy) NSString *active_time_b; //价格id
@property(nonatomic, copy) NSString *active_time_d; //价格id
@property(nonatomic, copy) NSString *active_cc; //价格id
@property(nonatomic, copy) NSString *goods_pir; //
@property(nonatomic, copy) NSString *btime; //


@end
