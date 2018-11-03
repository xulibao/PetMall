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

@interface DCGoodBaseViewController : STBaseNonSystemNavViewController

@property(nonatomic, copy) NSString *goods_id;

@property(nonatomic, copy) NSString *list_id;

/** 更改标题 */
@property (nonatomic , copy) void(^changeTitleBlock)(BOOL isChange);

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;
/* 商品图片 */
@property (strong , nonatomic)NSString *goodImageView;

@property (strong , nonatomic)NSString *goodTip;
/* 商品轮播图 */
@property (strong , nonatomic)NSArray *goodsImageArray;

@property(nonatomic, strong) PMGoodDetailModel *detailModel;

- (void)setUpRightTwoButton;

- (void)bottomButtonClick:(UIButton *)button;
@end
