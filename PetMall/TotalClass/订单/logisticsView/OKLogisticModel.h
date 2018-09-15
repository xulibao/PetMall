//
//  OKLogisticModel.h
//  OKLogisticsInformation
//
//  Created by Oragekk on 16/7/9.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    PMLogisticStatue_start , // 开始
    PMLogisticStatue_xiadan, // 配货
    PMLogisticStatue_chuku, // 配货
    PMLogisticStatue_fahuo, // 配货
    PMLogisticStatue_lanjian, // 配货
    PMLogisticStatue_tuzhong, // 途中
    PMLogisticStatue_dangqianweizhi, // 当前位置
    PMLogisticStatue_shouhuodi // 收货地
} PMLogisticStatue;
@interface OKLogisticModel : NSObject
@property (copy, nonatomic)NSString *dsc;
@property (copy, nonatomic)NSString *date;
@property(nonatomic, assign) PMLogisticStatue statue;
@property (assign, nonatomic, readonly)CGFloat height;
@end
