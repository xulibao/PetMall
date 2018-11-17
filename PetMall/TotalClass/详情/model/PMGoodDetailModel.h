//
//  PMGoodDetailModel.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/11/2.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PMGoodDetailSpecificationModel : NSObject
@property(nonatomic, copy) NSString *sign;
@property(nonatomic, copy) NSString *last;
@property(nonatomic, assign) BOOL isSelect;

@end
@interface PMGoodDetailChoiceModel : NSObject
@property(nonatomic, copy) NSString *classification;
@property(nonatomic, strong) NSArray *specifications;

@end

@interface PMGoodDetailPriceModel : NSObject

@property(nonatomic, copy) NSString *number;
@property(nonatomic, copy) NSString *goods_sale;
@property(nonatomic, copy) NSString *list_id;
@property(nonatomic, copy) NSString *martket_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *list_fen;
@property(nonatomic, copy) NSString *goods_spec;
@property(nonatomic, copy) NSString *shul;
@property(nonatomic, copy) NSString *Tag;


@end

@interface PMGoodDetailModel : NSObject

@property(nonatomic, copy) NSString *goodId;
@property(nonatomic, copy) NSString *list_id;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_image;
@property(nonatomic, strong) NSMutableArray *goodsImageArray;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *package_sale;
@property(nonatomic, copy) NSString *package_pl;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *package_ok;
@property(nonatomic, copy) NSString *goods_content;
@property(nonatomic, copy) NSString *active_id;
@property(nonatomic, copy) NSString *active_lx;
@property(nonatomic, copy) NSString *zt;
@property(nonatomic, copy) NSString *goods_shul;
@property(nonatomic, copy) NSString *groupa;
@property(nonatomic, copy) NSString *goods_deposit;
@property(nonatomic, copy) NSString *active_time_b;
@property(nonatomic, copy) NSString *active_time_d;
@property(nonatomic, strong) NSArray *price;
@property(nonatomic, strong) NSArray *choice;
@property(nonatomic, assign) BOOL collection;

@property(nonatomic, strong) NSArray *comment;
@property(nonatomic, strong) NSArray *store_goods_list;


@end
