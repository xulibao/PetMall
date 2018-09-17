//
//  PMMessageDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageDetailViewController.h"

@interface PMMessageDetailViewController ()

@end

@implementation PMMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
}

- (void)initSubviews {
    [super initSubviews];
    
    UILabel * timeLabel = [UILabel new];
    timeLabel.text = @"8月28日 09:26";
    timeLabel.textColor = kColor999999;
    timeLabel.font = [UIFont systemFontOfSize:10];

    [self.view addSubview:timeLabel];
    
    
    UIView * bgView =[UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UILabel * statusLabel = [UILabel new];
    statusLabel.font = [UIFont systemFontOfSize:15];
    statusLabel.text = @"交易完成";
    [bgView addSubview:statusLabel];
    
    UILabel * messageContentLabel = [UILabel new];
    messageContentLabel.numberOfLines = 0;
    messageContentLabel.textColor = kColor999999;
    messageContentLabel.font = [UIFont systemFontOfSize:12];
    messageContentLabel.text = @"您的订单【GO狗粮 抗敏美毛系列全 犬配方 25磅】已完成";
    [bgView addSubview:messageContentLabel];
    
    UIButton * commentBtn = [UIButton new];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [commentBtn setTitle:@"点击去评论>" forState:UIControlStateNormal];
    [commentBtn setTitleColor:kColorFF3945 forState:UIControlStateNormal];
    [bgView addSubview:commentBtn];
    
    
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(17);

    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(timeLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(105);
    }];
    
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(18);
        make.top.mas_equalTo(12);
    }];
    
    [messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(statusLabel);
        make.right.mas_equalTo(-18);
        make.top.mas_equalTo(statusLabel.mas_bottom).mas_offset(15);
    }];
    
    [commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-18);
        make.bottom.mas_equalTo(-10);
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
