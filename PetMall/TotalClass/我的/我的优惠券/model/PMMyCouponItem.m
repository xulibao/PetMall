//
//  PMMyCouponItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCouponItem.h"
#import "PMMyCouponCell.h"
@implementation PMMyCouponItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMMyCouponCell class];
    }
    return _cellClass;
}
@end
