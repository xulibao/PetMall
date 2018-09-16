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
@property (nonatomic, copy) NSString * phoneStr;            // 电话
@property (nonatomic, copy) NSString * nameStr;             // 姓名
@property (nonatomic, copy) NSString * areaAddress;         // 地区（四川省成都市武侯区）
@property (nonatomic, copy) NSString * detailAddress;       // 详细地址（如：红牌楼街道下一站都市B座406）
@property (nonatomic, assign) BOOL     isDefaultAddress;    // 是否是默认地址
@end
