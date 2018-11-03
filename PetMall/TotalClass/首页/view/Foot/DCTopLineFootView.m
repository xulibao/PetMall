//
//  DCTopLineFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCTopLineFootView.h"

// Controllers

// Models

// Views
#import "DCTitleRolling.h"
// Vendors

// Categories
#import <UIImageView+WebCache.h>
// Others

@interface DCTopLineFootView ()<UIScrollViewDelegate,CDDRollingDelegate>

/* 滚动 */
@property (strong , nonatomic)DCTitleRolling *numericalScrollView;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
/* 顶部广告宣传图片 */
@property (strong , nonatomic)UIImageView *topAdImageView;

@property(nonatomic, strong) UILabel *addLabel;
@property(nonatomic, strong) UILabel *addLabel1;

@end

@implementation DCTopLineFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
        [self setUpBase];
        
    }
    return self;
}

- (void)setUpUI{
    _topAdImageView = [[UIImageView alloc] init];
    [_topAdImageView handleTapActionWithBlock:^(UIView *sender) {
        if (self.DCTopLineFootViewCallBack) {
            self.DCTopLineFootViewCallBack();
        }
    }];
//    _topAdImageView.image = IMAGE(@"home_ad_conpou");
    _topAdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_topAdImageView];
    
    UILabel * addLabel = [[UILabel alloc] init];
    self.addLabel = addLabel;
    addLabel.textColor = [UIColor whiteColor];
    addLabel.font = [UIFont boldSystemFontOfSize:15];
    [_topAdImageView addSubview:addLabel];
    
    UILabel * addLabel1 = [[UILabel alloc] init];
    self.addLabel1 = addLabel1;
    addLabel1.textColor = [UIColor whiteColor];
    addLabel1.font = [UIFont systemFontOfSize:10];
    [_topAdImageView addSubview:addLabel1];
    
    
    [_topAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-12);
        [make.bottom.mas_equalTo(self)setOffset:-10];
    }];
    
    [addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topAdImageView);
        make.top.mas_equalTo(16);
    }];
    [addLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(addLabel);
        make.top.mas_equalTo(addLabel.mas_bottom).mas_offset(8);
    }];
}

- (void)setCouponModel:(PMHomeCouponModel *)couponModel{
    _couponModel = couponModel;
    [_topAdImageView sd_setImageWithURL:[NSURL URLWithString:couponModel.img]];
//    self.addLabel.text = [NSString stringWithFormat:@"%@元优惠券",couponModel.face];
//    self.addLabel1.text = [NSString stringWithFormat:@"全场宠物用品满%@元可用",couponModel.subtraction];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setUpBase
{
    self.backgroundColor = [UIColor colorWithRed:250 green:250 blue:250 alpha:1];
    
}

#pragma mark - Setter Getter Methods

#pragma mark - 滚动条点击事件

- (void)dc_RollingViewSelectWithActionAtIndex:(NSInteger)index
{
    NSLog(@"点击了第%zd头条滚动条",index);
}

@end
