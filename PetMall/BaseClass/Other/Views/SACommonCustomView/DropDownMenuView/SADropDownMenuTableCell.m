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

@property(nonatomic, strong) UIImageView *selectImageView;

@end
@implementation SADropDownMenuTableCell

- (void)initViews{
    
    UILabel * label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:16];
    self.nameLabel = label;
    [self.contentView addSubview:label];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = IMAGE(@"buy_model_select");
    self.selectImageView = imageView;
    [self.contentView addSubview:imageView];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-20);
    }];
    
}

- (void)setModel:(SAMenuRecordModel *)model{
    self.nameLabel.text = model.name;
    self.nameLabel.textColor = model.isSelect ? kColorFF5554 : kColorTextBlack;
    self.selectImageView.hidden = !model.isSelect;
}

@end
