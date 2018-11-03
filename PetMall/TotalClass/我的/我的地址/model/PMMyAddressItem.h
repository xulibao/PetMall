//
//  PMMyAddressItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
#import "PMMyAddressCell.h"

@interface PMMyAddressItem : STCommonBaseTableRowItem

@property (nonatomic, copy) NSString * address_id;            // 电话

@property (nonatomic, copy) NSString * user_id;            // 电话

@property (nonatomic, copy) NSString * user_phone;            // 电话
@property (nonatomic, copy) NSString * user_name;             // 姓名
@property (nonatomic, copy) NSString * user_address;         // 地区（四川省成都市武侯区）
@property (nonatomic, copy) NSString * user_add;       // 详细地址（如：红牌楼街道下一站都市B座406）
@property (nonatomic, assign) BOOL  zt;    // 是否是默认地址
@end
