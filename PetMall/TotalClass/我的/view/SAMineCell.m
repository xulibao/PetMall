//
//  SAMineCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAMineCell.h"

@interface SAMineCell()

@property (nonatomic,strong) UIImageView *imageView0;

@property (nonatomic,strong) UILabel *label0;

@property (nonatomic,strong) UILabel * label1;

@property (nonatomic,strong) UIImageView *imageView1;


@end

@implementation SAMineCell

- (void)initViews{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView * imageView0 = [[UIImageView alloc] init];
    self.imageView0 = imageView0;
    [self.contentView addSubview:imageView0];
    
    UILabel * label0 = [[UILabel alloc] init];
    self.label0 = label0;
    label0.textColor = [UIColor colorWithHexStr:@"#333333"];
    label0.font = [UIFont systemFontOfSize:13];
    [self.contentView  addSubview:label0];
    
    UILabel * label1 = [[UILabel alloc] init];
    self.label1 = label1;
    label1.font = [UIFont systemFontOfSize:14];
    label1.textColor = kColor878787;
    [self.contentView  addSubview:label1];
    
    UIImageView * imageView1 = [[UIImageView alloc] init];
    self.imageView1 = imageView1;
    [self.contentView  addSubview:imageView1];
        
    [imageView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(15);
    }];
    
    
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView0.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(imageView0);
    }];
    
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(imageView0);
//        make.right.mas_equalTo(self.contentView ).mas_offset(-10);
//    }];
    
//    [imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.contentView);
//        make.centerY.mas_equalTo(imageView0);
//
//    }];
    
    [self sp_addBottomLineWithLeftMargin:0 rightMargin:0];
}

- (void)setModel:(SAMineModel *)model{
    _model = model;
    self.imageView0.image = IMAGE(model.iconImage);
    self.label0.text = model.titleName;
//    self.label1.text = model.descTitle;
    
}

@end
