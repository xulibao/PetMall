//
//  PMOrderSelectCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/11.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderSelectCell.h"

@interface PMOrderSelectCell ()

@property(nonatomic, strong) UILabel *orderTitleLabel;

@property(nonatomic, strong) UILabel *orderCountLabel;

@property(nonatomic, strong) UILabel *orderContentLabel;


@end

@implementation PMOrderSelectCell

- (void)initViews{
    UILabel * orderTitleLabel = [[UILabel alloc] init];
    orderTitleLabel.font =[UIFont systemFontOfSize:16];
    self.orderTitleLabel = orderTitleLabel;
    [self.contentView addSubview:orderTitleLabel];
    
    UILabel *orderCountLabel = [[UILabel alloc] init];
    orderCountLabel.textAlignment =NSTextAlignmentCenter;
    orderCountLabel.font =[UIFont systemFontOfSize:12];
    orderCountLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    orderCountLabel.layer.cornerRadius = 7.5;
    orderCountLabel.layer.borderColor = [UIColor colorWithHexStr:@"#FF3945"].CGColor;
    orderCountLabel.layer.borderWidth = 0.5;
    orderCountLabel.clipsToBounds = YES;
    self.orderCountLabel = orderCountLabel;
    [self.contentView addSubview:orderCountLabel];
    
    UILabel *orderContentLabel = [[UILabel alloc] init];
    orderContentLabel.font =[UIFont systemFontOfSize:16];
    self.orderContentLabel = orderContentLabel;
    [self.contentView addSubview:orderContentLabel];
    
    UIImageView * accImage = [[UIImageView alloc] init];
    accImage.image = IMAGE(@"home_youjiantou");
    [self.contentView addSubview:accImage];
    
    [orderTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(self.contentView);
    }];

    
    [orderCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderTitleLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(56, 15));
    }];
    
    [orderContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(accImage.mas_left).mas_offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [accImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.contentView sp_addBottomLineWithLeftMargin:10 rightMargin:0];
}

- (void)setModel:(PMOrderSelectModel *)model{
    _model = model;
    self.orderTitleLabel.text = model.title;
    if (model.count) {
        self.orderCountLabel.hidden = NO;
        self.orderCountLabel.text = model.count;
    }else{
        self.orderCountLabel.hidden = YES;
    }
    self.orderContentLabel.text = model.content;
    
}

@end
