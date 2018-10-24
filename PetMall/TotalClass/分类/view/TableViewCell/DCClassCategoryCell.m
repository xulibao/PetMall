//
//  DCClassCategoryCell.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCClassCategoryCell.h"

// Controllers

// Models
#import "DCClassMianItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCClassCategoryCell ()

/* 标题 */
@property (strong , nonatomic)UILabel *titleLabel;

@end

@implementation DCClassCategoryCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_titleLabel];
    
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
    }];
    
}

#pragma mark - cell点击
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        _titleLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
        self.backgroundColor = [UIColor colorWithHexStr:@"#FAFAFA"];
    }else{
        _titleLabel.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - Setter Getter Methods
- (void)setTitleItem:(DCClassMianItem *)titleItem
{
    _titleItem = titleItem;
    self.titleLabel.text = titleItem.cate_title;
}

@end
