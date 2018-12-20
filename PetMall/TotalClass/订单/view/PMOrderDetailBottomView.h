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
@property(nonatomic, strong) UIButton *tagBtn;
@property(nonatomic, strong) UIButton *tagBtn1;
@property(nonatomic, copy) void (^copyBlcok)(void);
@property(nonatomic, copy) void (^tagBtnBlcok)(void);
@property(nonatomic, copy) void (^tagBtn1Blcok)(void);
@end
