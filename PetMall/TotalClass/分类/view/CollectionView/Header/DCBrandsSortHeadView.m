//
//  DCBrandsSortHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/8.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCBrandsSortHeadView.h"

#import "DCZuoWenRightButton.h"

// Models
#import "DCClassMianItem.h"
// Views

// Vendors

// Categories

// Others

@interface DCBrandsSortHeadView ()

/* 头部标题Label */
@property (strong , nonatomic)UILabel *titleLabel;

@property(nonatomic, strong) DCZuoWenRightButton * moreBtn;

@end

@implementation DCBrandsSortHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
#pragma mark - UI
- (void)setUpUI{

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:20];
    _titleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    [self addSubview:_titleLabel];
    
    DCZuoWenRightButton * moreBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn = moreBtn;
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [moreBtn setImage:[UIImage imageNamed:@"home_youjiantou"] forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] forState:UIControlStateNormal];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [moreBtn addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moreBtn];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    
    //    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_equalTo(self);
    //        make.right.mas_equalTo(-15);
    //    }];
    
    moreBtn.frame =  CGRectMake(self.width - 55, 0, 55, self.height);
}

- (void)moreClick{
    if (self.callBack) {
        self.callBack(self.headTitle.cate_title);
    }
}

#pragma mark - Setter Getter Methods
- (void)setHeadTitle:(DCClassMianItem *)headTitle{
    _headTitle = headTitle;
    _titleLabel.text = headTitle.cate_title;
}

@end
