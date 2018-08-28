//
//  SAAddressPickerView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/2.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAProvinceItemModel.h"

@protocol SAAddressPickerViewDelegate <NSObject>

/** 取消按钮点击事件*/
- (void)cancelBtnClick;

/**
 *  完成按钮点击事件
 *
 *  @param province 当前选中的省份
 *  @param city     当前选中的市
 *  @param area     当前选中的区
 */
- (void)sureBtnClickReturnProvince:(SAProvinceItemModel *)province
                              City:(SACityItemModel *)city
                              Area:(SADistrictItemModel *)area;

@end

@interface SAAddressPickerView : UIView

@property(nonatomic, copy) UIColor *backMaskColor;
@property(nonatomic, copy) UIColor *titleViewColor;
@property(nonatomic, copy) UIColor *titleColor;
@property(nonatomic, copy) UIColor *pickerViewColor;
@property(nonatomic, assign) CGFloat backMaskAlpha;
@property (nonatomic ,strong) NSMutableArray * pArr;/**< 地址选择器数据源,装省份模型,每个省份模型内包含城市模型*/
- (void)setTitleHeight:(CGFloat)titleHeight pickerViewHeight:(CGFloat)pickerHeight;

/**
 是否自动打开上次结果，默认为YES。
 */
@property (nonatomic, assign) BOOL isAutoOpenLast;

/** 实现点击按钮代理*/
@property (nonatomic ,weak) id<SAAddressPickerViewDelegate> delegate;

- (void)show;
- (void)show:(BOOL)animation;
- (void)hide;
- (void)hide:(BOOL)animation;

@end
