//
//  DCGoodBaseViewController.h
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "STBaseNonSystemNavViewController.h"
#import "PMConfirmOrderViewController.h"
#import "PMGoodDetailModel.h"
#import "DCCommentsItem.h"

@interface DCGoodBaseViewController : STBaseNonSystemNavViewController

@property(nonatomic, copy) NSString *goods_id;

@property(nonatomic, copy) NSString *list_id;

@property(nonatomic, strong) NSArray *commentsItem;

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);
@property (strong , nonatomic)NSString *goodTip;

@property(nonatomic, strong) PMGoodDetailModel *detailModel;
- (void)initViewData;
- (void)setUpRightTwoButton;

- (void)bottomButtonClick:(UIButton *)button;
@end
