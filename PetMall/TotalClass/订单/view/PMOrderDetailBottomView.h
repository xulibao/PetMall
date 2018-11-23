//
//  PMOrderDetailBottomView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMOrderDetailItem.h"
@interface PMOrderDetailBottomView : UIView
@property(nonatomic, strong) PMOrderDetailInfoModel *infoModel;
@property(nonatomic, copy) void (^copyBlcok)(void);
@property(nonatomic, copy) void (^commentBlcok)(void);
@end
