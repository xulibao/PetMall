//
//  PMPayResultViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/12.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMPayResultViewController.h"
#import "PMOrderDetailViewController.h"
#import "PMHomeViewController.h"
#import "STTabBarController.h"
@interface PMPayResultViewController ()

@end

@implementation PMPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值结果";
    [self fectchSubViews];
    
}
- (void)setupNavgationBar {
    [super setupNavgationBar];
    UIColor *tintColor = [UIColor whiteColor];
    [self.navgationBar.leftBarButton setTintColor:tintColor];
    self.navgationBar.navigationBarBg.alpha = 0;
    self.navgationBar.titleLabel.alpha = 0;
    self.statusBarView.alpha = 0;
}

- (void)initSubviews {
    [super initSubviews];
}
- (BOOL)shouldInitSTNavgationBar {
    return YES;
}
- (void)fectchSubViews{
    UIImageView * bgView = [[UIImageView alloc] init];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    if (kMainBoundsHeight == 480) {
        bgView.image = IMAGE(@"640x960");
    }else if (kMainBoundsHeight == 568){
        bgView.image = IMAGE(@"640x1136");
    }else if (kMainBoundsHeight == 667){
        bgView.image = IMAGE(@"750x1334");
    }else if (kMainBoundsHeight == 736){
        bgView.image = IMAGE(@"1242x2208");
    }else if (kMainBoundsHeight == 812){
        bgView.image = IMAGE(@"1125x2436");
    }
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled  = YES;
    imageView.image = IMAGE(@"order_pay_succuss");
    [bgView addSubview:imageView];
    UILabel * label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"支付成功!";
    
    UIButton * bidBtn = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [bidBtn.layer addSublayer:gradientLayer];
    [bgView addSubview:bidBtn];
    bidBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bidBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [bidBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bidBtn addTarget:self action:@selector(bidClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * balanceBtn = [[UIButton alloc] init];
    [bgView addSubview:balanceBtn];
    balanceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [balanceBtn setTitle:@"返回首页" forState:UIControlStateNormal];
    [balanceBtn setTitleColor:[UIColor colorWithHexStr:@"#FF3945"] forState:UIControlStateNormal];
    [balanceBtn addTarget:self action:@selector(backHome) forControlEvents:UIControlEventTouchUpInside];
    balanceBtn.layer.borderColor = [UIColor colorWithHexStr:@"#FF3945"].CGColor;
    balanceBtn.layer.borderWidth = 0.5;
    balanceBtn.layer.cornerRadius = 22;
    balanceBtn.clipsToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(88);
    }];

    [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
        make.centerY.mas_equalTo(70);
    }];
    [bidBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(balanceBtn.mas_bottom).mas_offset(25);
    }];
    
   
    
}
//返回首页
- (void)backHome{
        [self.navigationController popToRootViewControllerAnimated:YES];
        [[SAApplication sharedApplication].mainTabBarController setSelectedIndex:0];
}
//查看订单
- (void)bidClick{
    PMOrderDetailViewController * vc = [[PMOrderDetailViewController alloc] init];
    [self pushViewController:vc];
}

@end
