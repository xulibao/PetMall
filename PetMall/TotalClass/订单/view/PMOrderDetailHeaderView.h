//
//  PMOrderDetailHeaderView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMOrderDetailItem.h"
@interface PMOrderDetailHeaderView : UIView
@property(nonatomic, strong) PMOrderDetailModel *detailModel;
@property(nonatomic, copy) void (^logisticsInformationBlcok)();
@end
