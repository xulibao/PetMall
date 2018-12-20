//
//  PMTimeLimitItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/12/18.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMTimeLimitNavItem : NSObject
@property(nonatomic, copy) NSString *timeLimitNavId;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *zt;
@end

@interface PMTimeLimitItem : STCommonBaseTableRowItem
@property(nonatomic, copy) NSString *timeLimitId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *goods_stock;
@property(nonatomic, copy) NSString *list_id;
@end
