//
//  SAMineOrderCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAMineOrderCell.h"

@interface SAMineOrderCell()

@property (nonatomic,strong) UIView *bottomView;

@end

@implementation SAMineOrderCell

- (void)initViews{
    UIView * topView = [[UIView alloc] init];
    topView.userInteractionEnabled = YES;
    [self.contentView addSubview:topView];
    
    UIImageView * imageView0 = [[UIImageView alloc] init];
    imageView0.image = IMAGE(@"mine_wodedingdan");
    [topView addSubview:imageView0];
    
    UILabel * label0 = [[UILabel alloc] init];
    label0.text = @"我的订单";
    label0.font = [UIFont systemFontOfSize:15];
    label0.textColor = kColorTextBlack;
    [topView addSubview:label0];
    
//    UILabel * label1 = [[UILabel alloc] init];
//    label1.text = @"全部订单";
//    label1.font = [UIFont systemFontOfSize:14];
//    label1.textColor = kColor878787;
//    [topView addSubview:label1];
//    [label1 handleTapActionWithBlock:^(UIView *sender) {
//        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
//            [self.delegate mineOrderClickWithType:SAMineOrderTypeAll];
//        }
//    }];

    
    UIImageView * imageView1 = [[UIImageView alloc] init];
    [topView addSubview:imageView1];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(45);
    }];
    
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(topView);
        make.left.mas_equalTo(15);
    }];
    
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView0.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(imageView0);
    }];
    
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(imageView0);
//        make.right.mas_equalTo(topView).mas_offset(-22);
//    }];
    
    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView).mas_offset(-15);
        make.centerY.mas_equalTo(imageView0);

    }];
    
//    [topView sp_addBottomLineWithLeftMargin:15 rightMargin:0];
    
    UIView * bottomView = [[UIView alloc] init];
    self.bottomView = bottomView;
    [self.contentView addSubview:bottomView];
    
    // 待付款
    UIView * bottomView0 = [self bottomViewTopImage:@"mine_daifukuan" bottomText:@"待付款"];
    [bottomView0 handleTapActionWithBlock:^(UIView *sender) {
        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
            [self.delegate mineOrderClickWithType:PMOrderOrderTypePayment];
        }
    }];
    // 待发货
    UIView * bottomView1 = [self bottomViewTopImage:@"mine_daifahuo" bottomText:@"待发货"];
    [bottomView1 handleTapActionWithBlock:^(UIView *sender) {
        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
            [self.delegate mineOrderClickWithType:PMOrderOrderTypeTransfer];
        }
    }];
    
    // 待收货
    UIView * bottomView2 = [self bottomViewTopImage:@"mine_daishouhuo" bottomText:@"待收货"];
    [bottomView2 handleTapActionWithBlock:^(UIView *sender) {
        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
            [self.delegate mineOrderClickWithType:PMOrderOrderTypeTransfer];
        }

    }];
    // 已完成
    UIView * bottomView3 = [self bottomViewTopImage:@"mine_daipinlun" bottomText:@"待评价"];
    [bottomView3 handleTapActionWithBlock:^(UIView *sender) {
        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
            [self.delegate mineOrderClickWithType:PMOrderOrderTypeComment];
        }
    }];
    
    // 已失败
    UIView * bottomView4 = [self bottomViewTopImage:@"mine_tuikuan" bottomText:@"退款/售后"];
    [bottomView4 handleTapActionWithBlock:^(UIView *sender) {
        if ([self.delegate respondsToSelector:@selector(mineOrderClickWithType:)]) {
            [self.delegate mineOrderClickWithType:PMOrderOrderTypeFail];
        }
    }];

    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(80);
    }];
    
    [bottomView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(bottomView);
        make.width.mas_equalTo(kMainBoundsWidth * 0.2);
    }];
    [bottomView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView0.mas_right);
        make.width.mas_equalTo(kMainBoundsWidth * 0.2);
    }];
    [bottomView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView1.mas_right);
        make.width.mas_equalTo(kMainBoundsWidth * 0.2);
    }];
    [bottomView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView2.mas_right);
        make.width.mas_equalTo(kMainBoundsWidth * 0.2);
    }];
    [bottomView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.left.mas_equalTo(bottomView3.mas_right);
        make.width.mas_equalTo(kMainBoundsWidth * 0.2);
    }];
    
}

- (UIView *)bottomViewTopImage:(NSString *)imageStr bottomText:(NSString *)bottomStr{
    UIView * view = [[UIView alloc] init];
    [self.bottomView addSubview:view];
    
    UIImageView * topImageView = [[UIImageView alloc] init];
    topImageView.image = IMAGE(imageStr);
    [view addSubview:topImageView];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    bottomLabel.font = [UIFont systemFontOfSize:13];
    bottomLabel.textColor = kColor878787;
    bottomLabel.text = bottomStr;
    [view addSubview:bottomLabel];
    
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(15);
        make.centerX.mas_equalTo(view);
    }];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.bottom.mas_equalTo(view).mas_offset(-20);
    }];
    return view;
}
- (void)setModel:(SAPersonCenterModel *)model{
    _model = model;
}

@end
