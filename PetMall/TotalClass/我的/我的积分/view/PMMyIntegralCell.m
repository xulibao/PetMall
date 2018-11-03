//
//  PMMyIntegralCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyIntegralCell.h"
@interface PMMyIntegralCell()
@property(nonatomic, strong) UILabel *label0;//支付成功//视频看车服务费;
@property(nonatomic, strong) UILabel *label1;//支付方式：支付宝//申请时间：2017年6月23日 12:15:44//拍品编号：2018023034234
@property(nonatomic, strong) UILabel *label2;//时间：2017年6月23日 12:15:44//处理时间：2017年6月23日 12:15:44
@property(nonatomic, strong) UILabel *priceLabel;//1000元

@end
@implementation PMMyIntegralCell

- (void)initViews{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *label;
    label = [[UILabel alloc] init];
    label.text = @"分享商品";
    label.font = UIFontMake(15);
    label.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(16);
//        make.height.mas_greaterThanOrEqualTo(20);
    }];
    _label0 = label;
    
    label = [[UILabel alloc] init];
    label.text = @"2018-05-27 10:48:34";
    label.font = UIFontMake(12);
    label.textColor = kColor999999;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_label0.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(_label0);
//        make.height.mas_greaterThanOrEqualTo(15);
    }];
    _label1 = label;
    
    label = [[UILabel alloc] init];
    label.text = @"+100";
    label.font = UIFontMake(18);
    label.textColor = kColorFF5554;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    _priceLabel = label;
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = kColorBG;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.left.bottom.right.mas_equalTo(0);
    }];
}

- (void)setModel:(PMMyIntegralModel *)model{
    _model = model;
    _label0.text = model.source;
    _label1.text = model.time;
    _priceLabel.text = [NSString stringWithFormat:@"+%@",model.number];
}

@end
