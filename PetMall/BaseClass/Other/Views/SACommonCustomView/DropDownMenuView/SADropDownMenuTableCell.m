//
//  SADropDownMenuTableCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/3/15.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SADropDownMenuTableCell.h"

@interface SADropDownMenuTableCell()

@property(nonatomic, strong) UILabel *nameLabel;

@property(nonatomic, strong) UILabel *valueLabel;

@property(nonatomic, strong) UIImageView *selectImageView;

@property(nonatomic, strong) UIImageView *rightImageView;


@end
@implementation SADropDownMenuTableCell

- (void)initViews{
    
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    self.nameLabel = label;
    [self.contentView addSubview:label];
    
    label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = kColor999999;
    self.valueLabel = label;
    [self.contentView addSubview:label];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = IMAGE(@"buy_model_select");
    self.selectImageView = imageView;
    [self.contentView addSubview:imageView];
    
    imageView = [[UIImageView alloc] init];
    imageView.image = IMAGE(@"home_arrow");
    self.rightImageView = imageView;
    [self.contentView addSubview:imageView];

    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rightImageView.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView);

    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.selectImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setModel:(SAMenuRecordModel *)model{
    if (model.isShowArrow) {
        self.rightImageView.hidden = NO;
        self.valueLabel.hidden = NO;
        self.selectImageView.hidden = YES;
        self.valueLabel.text = model.serveValue ? model.serveValue : @"不限";
    }else{
        self.rightImageView.hidden = YES;
        self.valueLabel.hidden = YES;
        self.selectImageView.hidden = NO;
    }
    self.nameLabel.text = model.name;
    self.nameLabel.textColor = model.isSelect ? kColorFF5554 : kColorTextBlack;
    self.selectImageView.hidden = !model.isSelect;

}

@end
