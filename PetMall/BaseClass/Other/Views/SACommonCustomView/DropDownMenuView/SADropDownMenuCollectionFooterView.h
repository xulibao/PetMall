//
//  SADropDownMenuCollectionFooterView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/27.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STValueSlider.h"

@interface SADropDownMenuCollectionFooterView : UICollectionReusableView

@property(nonatomic, assign) BOOL isYearValue;

@property(nonatomic, assign) BOOL isMileageValue;

@property(nonatomic, strong) STValueSlider *yearSlider;
@property(nonatomic, strong) STValueSlider *mileageSlider;

@property(nonatomic, copy) void (^resetCallBack)();
@property(nonatomic, copy) void (^confiremCallBack)(NSArray * recordArray);

@end
