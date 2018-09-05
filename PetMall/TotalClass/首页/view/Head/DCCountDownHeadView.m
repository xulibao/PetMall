//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
// Vendors

// Categories

// Others

@interface DCCountDownHeadView ()

/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *countDownLabel;

/* 好货秒抢 */
@property (strong , nonatomic)UIButton *quickButton;
@end

@implementation DCCountDownHeadView

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
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"12点场";
    _timeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:15];
    [self addSubview:_timeLabel];
    
    _countDownLabel = [[UILabel alloc] init];
    _countDownLabel.textColor = [UIColor redColor];
    _countDownLabel.text = @"05 : 58 : 33";
    _countDownLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
    [self addSubview:_countDownLabel];
    
    _quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:19];
    [_quickButton setTitleColor:[UIColor colorWithRed:255/255.0 green:57/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
    [_quickButton setTitle:@"限时秒杀" forState:UIControlStateNormal];
    [self addSubview:_quickButton];
    
    [_countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.countDownLabel.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(self.countDownLabel);
    }];
    
    [_quickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_right).mas_offset(30);
        make.centerY.mas_equalTo(self.timeLabel);
    }];
}


#pragma mark - Setter Getter Methods


@end
