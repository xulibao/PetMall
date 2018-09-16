//
//  PMMyCouponItem.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
typedef enum : NSUInteger {
    PMMyCouponType_notUsed, // 倒计时
    PMMyCouponType_Used, // 已使用
    PMMyCouponType_Expired
} PMMyCouponType;
@interface PMMyCouponItem : STCommonBaseTableRowItem
@property(nonatomic, assign) BOOL isEnable;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, assign) PMMyCouponType type;
@end
