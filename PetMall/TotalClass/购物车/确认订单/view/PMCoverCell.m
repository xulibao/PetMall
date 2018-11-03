//
//  PMCoverCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/11.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMCoverCell.h"
@interface PMCoverCell()
@property(nonatomic, strong) UIImageView *selectImage;
@end

@implementation PMCoverCell

- (void)initViews{
    UILabel *coverTitleLabel = [[UILabel alloc] init];
    coverTitleLabel.font = [UIFont systemFontOfSize:13];
    self.coverTitleLabel =coverTitleLabel;
    [self.contentView addSubview:coverTitleLabel];
    
    UIImageView * selectImage = [[UIImageView alloc] init];
    self.selectImage =selectImage;
    selectImage.image = IMAGE(@"order_expressSelect");
    [self.contentView addSubview:selectImage];

    [coverTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.right.mas_equalTo(-20);
    }];
}

- (void)setModel:(PMExpressModel *)model{
    _model = model;
    self.coverTitleLabel.text = model.express_title;
    self.selectImage.hidden = !model.isSelect;
    
}

@end
