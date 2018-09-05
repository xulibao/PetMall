//
//  DCScrollAdFootView.m
//  CDDMall
//
//  Created by apple on 2017/6/7.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCScrollAdFootView.h"

#import <SDCycleScrollView.h>

@interface DCScrollAdFootView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation DCScrollAdFootView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainBoundsWidth, self.height) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.imageURLStringsGroup = @[@"http://gfs5.gomein.net.cn/T1vpK_BCZT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1cGK_BCZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1Kod_BCxT1RCvBVdK.jpg"];
    
    [self addSubview:_cycleScrollView];
}

#pragma mark - 点击广告跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd广告图",index);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods

@end
