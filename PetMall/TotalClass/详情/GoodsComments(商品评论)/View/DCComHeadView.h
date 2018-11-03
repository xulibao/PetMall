//
//  DCComHeadView.h
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCComHeadView : UIView

/* 提示label */
@property (strong , nonatomic)UILabel *tipLabel;

/* 百分比label */
@property (strong , nonatomic)UILabel *percentageLabel;

/** 点击回调 */
@property (nonatomic, copy) void(^comTypeBlock)(NSInteger index);

@end
