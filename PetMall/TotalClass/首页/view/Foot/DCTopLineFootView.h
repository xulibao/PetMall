//
//  DCTopLineFootView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMHomeModel.h"
@interface DCTopLineFootView : UICollectionReusableView
@property(nonatomic, strong) PMHomeCouponModel *couponModel;

@property(nonatomic, copy) void (^DCTopLineFootViewCallBack)();
@end
