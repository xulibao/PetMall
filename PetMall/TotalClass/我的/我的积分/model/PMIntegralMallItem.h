//
//  PMIntegralMallItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/27.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface PMIntegralMallItem : STCommonBaseTableRowItem

@property(nonatomic, copy) NSString *integralMallId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *goods_stock;
@property(nonatomic, copy) NSString *list_id;

@end
