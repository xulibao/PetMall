//
//  PMVoucherCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/11.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMVoucherCell.h"
@interface PMVoucherCell()
@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UIButton *selectBtn;
@property(nonatomic, strong) UILabel *priceLabel;
@end

@implementation PMVoucherCell
- (void)initViews{
    UIImageView * bgView = [[UIImageView alloc] init];
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    
    UILabel * priceLabel = [[UILabel alloc] init];
    self.priceLabel = priceLabel;
    priceLabel.font = [UIFont systemFontOfSize:30];
    priceLabel.textColor = [UIColor whiteColor];
    [self.bgView addSubview:priceLabel];
    
    UILabel * conditionsLabel = [[UILabel alloc] init];
    conditionsLabel.text = @"满100元可用";
    conditionsLabel.textColor = [UIColor whiteColor];
    conditionsLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:conditionsLabel];
    
    UILabel * voucherTitleLabel = [[UILabel alloc] init];
    voucherTitleLabel.text = @"全品类满减券";
    voucherTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.bgView addSubview:voucherTitleLabel];
    
    UILabel * voucherTimeLabel = [[UILabel alloc] init];
    voucherTimeLabel.text = @"2018-07-21至2018-07-30";
    voucherTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:voucherTimeLabel];
    
    UIButton * selectBtn = [[UIButton alloc] init];
    self.selectBtn =selectBtn;
    [selectBtn setImage:IMAGE(@"cart_yuanquan") forState:UIControlStateNormal];
    [selectBtn setImage:IMAGE(@"cart_yuanquan_selected") forState:UIControlStateSelected];
    [self.bgView addSubview:selectBtn];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(105);
    }];

    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(kMainBoundsWidth - 20 - 130) * 0.5);
        make.top.mas_equalTo(20);
    }];
    
    
    [conditionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(priceLabel);
        make.bottom.mas_equalTo(-15);
    }];

    [voucherTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(145);
        make.top.mas_equalTo(15);
    }];
    
    [voucherTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(voucherTitleLabel);
        make.bottom.mas_equalTo(-20);
    }];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.right.mas_equalTo(-15);
    }];

    
}

- (void)setModel:(PMVoucherModel *)model{
    _model = model;
    if (_model.isEnable) {
        self.bgView.image = IMAGE(@"oder_voucherBg");
        self.selectBtn.hidden = NO;
        self.selectBtn.selected = model.isSelect;
    }else{
        self.selectBtn.hidden = YES;
        self.bgView.image = IMAGE(@"oder_voucherBg_disable");
    }
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", model.price];
}
@end
