//
//  PMMyCouponViewController.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SAIndicatorSegmentViewController.h"
#import "SAInfoListViewController.h"
#import "PMMyCouponItem.h"

@interface PMMyCouponViewController : SAIndicatorSegmentViewController

@end
@interface PMMyCouponListViewController : SAInfoListViewController
@property(nonatomic, assign) PMMyCouponType type;
@end
