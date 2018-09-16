//
//  PMLoginViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMLoginViewController.h"
#import "SABaseInputValidTextField.h"
#import "SPForgotPasswordViewController.h"
#import "SPRegisterViewController.h"
@interface PMLoginViewController ()

@end

@implementation PMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fectchSubViews];
    
}
- (void)setupNavgationBar {
    [super setupNavgationBar];
//    UIColor *tintColor = [UIColor whiteColor];
//    [self.navgationBar.leftBarButton setTintColor:tintColor];
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
        bgView.image = IMAGE(@"login_640x960");
    }else if (kMainBoundsHeight == 568){
        bgView.image = IMAGE(@"login_640x1136");
    }else if (kMainBoundsHeight == 667){
        bgView.image = IMAGE(@"login_750x1334");
    }else if (kMainBoundsHeight == 736){
        bgView.image = IMAGE(@"login_1242x2208");
    }else if (kMainBoundsHeight == 812){
        bgView.image = IMAGE(@"login_1125x2436");
    }
    
    SABaseInputValidTextField * loginField = [[SABaseInputValidTextField alloc] init];
    [loginField addTarget:self action:@selector(baseFieldDidEditWithText:) forControlEvents:UIControlEventEditingChanged];
    loginField.backgroundColor = [UIColor whiteColor];
    loginField.textAlignment = NSTextAlignmentLeft;
    loginField.font = [UIFont systemFontOfSize:16];
    loginField.textColor = kColor999999;
    loginField.placeholder = @"手机号";
    SAPhoneNumberInputHandle * handle = [[SAPhoneNumberInputHandle alloc] init];
    handle.maxLength = 11;
    loginField.inputHandle = handle;
    [bgView addSubview:loginField];
    
    SABaseInputValidTextField * passwordField = [[SABaseInputValidTextField alloc] init];
    [passwordField addTarget:self action:@selector(baseFieldDidEditWithText:) forControlEvents:UIControlEventEditingChanged];
    passwordField.backgroundColor = [UIColor whiteColor];
    passwordField.textAlignment = NSTextAlignmentLeft;
    passwordField.font = [UIFont systemFontOfSize:16];
    passwordField.textColor = kColor999999;
    passwordField.placeholder = @"登录密码";
    [bgView addSubview:passwordField];
    
    [loginField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(290, 44));
        make.centerX.mas_equalTo(bgView);
        make.centerY.mas_equalTo(-30);
    }];

    [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(290, 44));
        make.centerX.mas_equalTo(bgView);
        make.top.mas_equalTo(loginField.mas_bottom).mas_offset(20);
    }];

    UIButton * loginBtn = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [loginBtn.layer addSublayer:gradientLayer];
    [bgView addSubview:loginBtn];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];

    UIButton * registBtn = [[UIButton alloc] init];
    [bgView addSubview:registBtn];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor colorWithHexStr:@"#FF3945"] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registBtn.layer.borderColor = [UIColor colorWithHexStr:@"#FF3945"].CGColor;
    registBtn.layer.borderWidth = 0.5;
    registBtn.layer.cornerRadius = 22;
    registBtn.clipsToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];

    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(passwordField.mas_bottom).mas_offset(20);
    }];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
        
        make.top.mas_equalTo(loginBtn.mas_bottom).mas_offset(12);
    }];
    
    UIButton * fogotPasswordBtn = [[UIButton alloc] init];
    [fogotPasswordBtn addTarget:self action:@selector(fogotPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [fogotPasswordBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [fogotPasswordBtn setTitleColor:kColorFF3945 forState:UIControlStateNormal];
    fogotPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [bgView addSubview:fogotPasswordBtn];
    

    [fogotPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(registBtn.mas_right);
        make.top.mas_equalTo(registBtn.mas_bottom).mas_offset(17);
        
    }];
    
    UIButton * qqBtn = [[UIButton alloc] init];
    [bgView addSubview:qqBtn];
    [qqBtn setImage:IMAGE(@"share_qq") forState:UIControlStateNormal];
    
    UIButton * wechatBtn = [[UIButton alloc] init];
    [bgView addSubview:wechatBtn];
    [wechatBtn setImage:IMAGE(@"share_wechat") forState:UIControlStateNormal];
    UIButton * taobaoBtn = [[UIButton alloc] init];
    [bgView addSubview:taobaoBtn];
    [taobaoBtn setImage:IMAGE(@"login_taobao") forState:UIControlStateNormal];
    
    [qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
        make.centerX.mas_equalTo(bgView);
    }];
    
    CGFloat margin = (kMainBoundsWidth - 3 * 45)/6;
    
    [wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(qqBtn.mas_left).mas_offset(-margin);
        make.centerY.mas_equalTo(qqBtn);
    }];
    
    [taobaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(qqBtn.mas_right).mas_offset(margin);
        make.centerY.mas_equalTo(qqBtn);
    }];
    
}
//登录
- (void)loginBtnClick{

    self.callBack ? self.callBack(self) : nil;
}
//注册
- (void)registBtnClick{
    SPRegisterViewController * vc = [[SPRegisterViewController alloc] init];
    [self pushViewController:vc];
}

//忘记密码
- (void)fogotPasswordBtnClick{
    SPForgotPasswordViewController * vc = [SPForgotPasswordViewController new];
    [self pushViewController:vc];
}

@end
