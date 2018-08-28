//
//  STGroupSectionView.m
//  SnailTruck
//
//  Created by imeng on 8/16/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STGroupSectionView.h"

@implementation STGroupSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _iconView = [[UIView alloc] init];
        [self addSubview:_iconView];
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self);
            make.top.mas_equalTo(self);
            make.width.mas_equalTo(3);
        }];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.top.mas_equalTo(10);
        }];
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [self addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            //make.top.mas_equalTo(10);
            make.bottom.mas_equalTo(self.titleLabel);
        }];
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0xd3d3d3);
        [self addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(self.iconView.mas_bottom);
            make.top.mas_greaterThanOrEqualTo(self.titleLabel.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(self);
            make.height.mas_equalTo(1.0/[UIScreen mainScreen].scale);
            make.bottom.mas_equalTo(self);
        }];
        
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
}

- (void)setIconColor:(UIColor *)color {
    self.iconView.backgroundColor = color;
}

- (void)setDesc:(NSAttributedString *)desc {
    self.descLabel.attributedText = desc;
}

@end
