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
@property(nonatomic, copy) NSString *couponId;
@property(nonatomic, copy) NSString *user_id;
@property(nonatomic, copy) NSString *coupon_id;
@property(nonatomic, copy) NSString *coupon_zt;

@property(nonatomic, copy) NSString *coupon_jiazhi;
@property(nonatomic, copy) NSString *coupon_mj;
@property(nonatomic, copy) NSString *begin_time;
@property(nonatomic, copy) NSString *last_time;
@property(nonatomic, assign) PMMyCouponType leixing;
@property(nonatomic, assign) BOOL isSelect;
@end
