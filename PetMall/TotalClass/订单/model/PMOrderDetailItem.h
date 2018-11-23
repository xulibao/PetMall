//
//  PMOrderDetailItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
@interface PMOrderDetailAdressItem : NSObject

@property(nonatomic, copy) NSString *user_add;
@property(nonatomic, copy) NSString *user_address;
@property(nonatomic, copy) NSString *user_phone;
@property(nonatomic, copy) NSString *user_name;

@end

@interface PMOrderDetailInfoModel : NSObject

@property(nonatomic, copy) NSString *order_no;
@property(nonatomic, copy) NSString *logistics;
@property(nonatomic, copy) NSString *pay_no;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *pay_price;
@property(nonatomic, copy) NSString *timeb;
@property(nonatomic, copy) NSString *goods_shul;
@property(nonatomic, copy) NSString *timea;
@property(nonatomic, copy) NSString *express_title;

@end

@interface PMOrderDetailGoodsItem : STCommonBaseTableRowItem

@property(nonatomic, copy) NSString *status;
@property(nonatomic, copy) NSString *order_id;
@property(nonatomic, copy) NSString *goods_id;
@property(nonatomic, copy) NSString *pay_price;
@property(nonatomic, copy) NSString *goods_spec;
@property(nonatomic, copy) NSString *postage;
@property(nonatomic, copy) NSString *jifen;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;

@end

@interface PMOrderDetailModel : NSObject
@property(nonatomic, strong) NSArray *address;
@property(nonatomic, strong) NSArray *goods;
@property(nonatomic, strong) PMOrderDetailInfoModel *order;
@property(nonatomic, strong) NSString *statusText;
@property(nonatomic, strong) NSArray<NSAttributedString*> *tagsText;
@end
