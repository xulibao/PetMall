//
//  DCCountDownHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCountDownHeadView.h"
#import "NSAttributedString+STAttributedString.h"

// Controllers

// Models

// Views
#import "DCZuoWenRightButton.h"
#import "SACountdownEpisode.h"

@interface DCCountDownHeadView ()<SACountdownEpisodeDelegate>
@property(nonatomic, strong) SACountdownEpisode *countdownEpisode;/* 时间 */
@property (strong , nonatomic)UILabel *timeLabel;
/* 倒计时 */
@property (strong , nonatomic)UILabel *unitLabel0;
@property (strong , nonatomic)UILabel *unitLabel1;

@property (strong , nonatomic)UILabel *hoursLabel;
@property (strong , nonatomic)UILabel *minsLabel;
@property (strong , nonatomic)UILabel *secsLabel;
/* 好货秒抢 */
@property (strong , nonatomic)UIButton *quickButton;
@end

@implementation DCCountDownHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        _countdownEpisode = [[[SACountdownEpisode alloc] initWithDelegate:self] start];
        _countdownEpisode.countDown = 2.44*60*60*1000;
        _countdownEpisode.countDownInterval = 1;
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.text = @"12点场";
    _timeLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    [self addSubview:_timeLabel];
    
    UILabel * unitLabel0 = [[UILabel alloc] init];
    unitLabel0.text = @":";
    self.unitLabel0 = unitLabel0;
    unitLabel0.textAlignment = NSTextAlignmentCenter;
    unitLabel0.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:unitLabel0];
    
    UILabel * unitLabel1 = [[UILabel alloc] init];
    unitLabel1.textAlignment = NSTextAlignmentCenter;
    unitLabel1.text = @":";
    self.unitLabel1 = unitLabel1;
    unitLabel1.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:unitLabel1];
    
    UILabel * hoursLabel = [[UILabel alloc] init];
    hoursLabel.textAlignment = NSTextAlignmentCenter;
    hoursLabel.backgroundColor = [UIColor blackColor];
    hoursLabel.textColor = [UIColor whiteColor];
    hoursLabel.layer.cornerRadius = 10;
    hoursLabel.clipsToBounds = YES;
    self.hoursLabel = hoursLabel;
    hoursLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:hoursLabel];
    
    UILabel * minsLabel = [[UILabel alloc] init];
    minsLabel.textAlignment = NSTextAlignmentCenter;
    minsLabel.backgroundColor = [UIColor blackColor];
    minsLabel.textColor = [UIColor whiteColor];
    minsLabel.layer.cornerRadius = 10;
    minsLabel.clipsToBounds = YES;
    self.minsLabel = minsLabel;
    minsLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:minsLabel];
    
    UILabel * secsLabel = [[UILabel alloc] init];
    secsLabel.textAlignment = NSTextAlignmentCenter;
    secsLabel.backgroundColor = [UIColor blackColor];
    secsLabel.textColor = [UIColor whiteColor];
    secsLabel.layer.cornerRadius = 10;
    secsLabel.clipsToBounds = YES;
    self.secsLabel = secsLabel;
    secsLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
    [self addSubview:secsLabel];
    
    
    
    
    _quickButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _quickButton.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Heavy" size:19];
    [_quickButton setTitleColor:[UIColor colorWithRed:255/255.0 green:57/255.0 blue:69/255.0 alpha:1] forState:UIControlStateNormal];
    [_quickButton setTitle:@"限时秒杀" forState:UIControlStateNormal];
    [self addSubview:_quickButton];
    
    [hoursLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [unitLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(hoursLabel.mas_right).mas_offset(2);
        make.centerY.mas_equalTo(self);
    }];
    
    [minsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(unitLabel0.mas_right).mas_offset(2);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [unitLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(minsLabel.mas_right).mas_offset(2);
        make.centerY.mas_equalTo(self);
    }];
    
    [secsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(unitLabel1.mas_right).mas_offset(2);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(secsLabel.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(secsLabel);
    }];
    
    [_quickButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.timeLabel.mas_right).mas_offset(30);
        make.centerY.mas_equalTo(self.timeLabel);
    }];
}


#pragma mark - SACountdownEpisodeDelegate

- (void)episodeCountdownEvent:(SACountdownEpisode *)episode {
      long long seconds = self.countdownEpisode.countDownSecond;
    long long secs = seconds % 60;
    long long mins = seconds % (60 * 60) / 60;
    long long hours = seconds / (60 * 60) % 24;
    long long days = seconds / (60 * 60) / 24;
    NSString * hoursStr = [NSString stringWithFormat:@"%02lld",hours];
    NSString * secsStr = [NSString stringWithFormat:@"%02lld",secs];
    NSString * minsStr = [NSString stringWithFormat:@"%02lld",mins];
//    NSAttributedString *text = [NSAttributedString stringWithStrings:@[
//                                                                       [NSAttributedString countDownTextWithSecond:seconds fontSize:15]]];
    @weakify(self)
    dispatch_main_async_safe(^{
        @strongify(self)
        self.hoursLabel.text = hoursStr;
        self.minsLabel.text = minsStr;
        self.secsLabel.text = secsStr;

    })
}

- (void)setModel:(PMHomeTimelimitModel *)model{
    
    _model = model;
    _timeLabel.text = [NSString stringWithFormat:@"%@点场",model.active_cc];
    NSDate *nowDate = [NSDate date]; // 当前日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [formatter dateFromString:model.active_time_d];
    NSTimeInterval delta = [creat timeIntervalSinceDate:nowDate]; // 计算出相差多少秒

    _countdownEpisode.countDown = delta * 1000;
    _countdownEpisode.countDownInterval = 1;
}

- (void)episodeExpiredEvent:(SACountdownEpisode *)episode {
    
}

@end
