//
//  PMHomeModel.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/24.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCommonTableViewBaseItem.h"



@interface PMHomeCouponModel : NSObject

@property(nonatomic, copy) NSString *couponId;
@property(nonatomic, copy) NSString *face;
@property(nonatomic, copy) NSString *subtraction;

@end
@interface PMHomeTimelimitModel : NSObject

@property(nonatomic, copy) NSString *timelimitId;
@property(nonatomic, copy) NSString *active_time_b;
@property(nonatomic, copy) NSString *active_time_d;
@property(nonatomic, copy) NSString *active_cc;

@end

@interface PMSecondkillModel : NSObject

@property(nonatomic, copy) NSString *secondkillId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;

@end


@interface PMBroadCastModel : NSObject

@property(nonatomic, copy) NSString *broadCastId;
@property(nonatomic, copy) NSString *img;

@end

@interface PMPresaleModel : NSObject

@property(nonatomic, copy) NSString *presaleId;
@property(nonatomic, copy) NSString *active_img;
@property(nonatomic, copy) NSString *active_time_b;

@end

@interface PMHomeGrouplimitModel : NSObject

@property(nonatomic, copy) NSString *grouplimitId;
@property(nonatomic, copy) NSString *active_lx;

@end
@interface PMGroupModel : STCommonBaseTableRowItem

@property(nonatomic, copy) NSString *groupId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *sum;

@end
@interface PMHomeBargainModel : NSObject

@property(nonatomic, copy) NSString *bargainId;
@property(nonatomic, copy) NSString *active_lx;
@property(nonatomic, copy) NSString *active_time_b;
@property(nonatomic, copy) NSString *active_time_d;
@property(nonatomic, copy) NSString *active_cc;

@end

@interface PMClearingModel : NSObject

@property(nonatomic, copy) NSString *clearingId;
@property(nonatomic, copy) NSString *goods_logo;
@property(nonatomic, copy) NSString *goods_title;
@property(nonatomic, copy) NSString *market_price;
@property(nonatomic, copy) NSString *selling_price;
@property(nonatomic, copy) NSString *goods_pir;

@end


@interface PMHomeModel : NSObject
// 轮播
@property(nonatomic, strong) NSArray *Broadcast;
//优惠券
@property(nonatomic, strong) PMHomeCouponModel *coupon;
//限时秒杀
@property(nonatomic, strong) PMHomeTimelimitModel *timelimit;
//限时秒杀列表
@property(nonatomic, strong) NSArray *secondkill;
//商品预售
@property(nonatomic, strong) NSArray *presale;
//团购活动
@property(nonatomic, strong) PMHomeGrouplimitModel *grouplimit;
//团购活动列表
@property(nonatomic, strong) NSArray *group;
//特价清仓
@property(nonatomic, strong) PMHomeBargainModel *bargain;
//特价清仓列表
@property(nonatomic, strong) NSArray *clearing;


@end

