//
//  SAMineHeadView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/6.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAMineHeadView.h"
#import "STTabBarController.h"
#import "STNavigationController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation SAMineHeadModel

@end

@interface SAMineHeadView()

@property (nonatomic, strong) UIImageView * avatar;//头像
@property (nonatomic, strong) UILabel * userName;//名字
@property (nonatomic, strong) UILabel * userLevel; //买家等级
@property (nonatomic, strong) UIButton * youhuiBtn; //
@property (nonatomic, strong) UIButton * jifengBtn; //折扣

@property(nonatomic, strong) UIButton * voucherBtn;

@end

@implementation SAMineHeadView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.headImageBg = [[UIImageView alloc] init];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        gradientLayer.frame = CGRectMake(0, 0, kMainBoundsWidth, 190);
        [self.headImageBg.layer addSublayer:gradientLayer];
        self.headImageBg.contentMode = UIViewContentModeScaleAspectFill;
        self.headImageBg.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        [self addSubview:self.headImageBg];
        [self.headImageBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
            make.height.mas_equalTo(190);
        }];
        //自定义登录状态
        [self initLoginViews];
    }
    return self;
}

- (void)initLoginViews
{
    //头像
    self.avatar = [[UIImageView alloc] init];
    self.avatar.image = [UIImage imageNamed:@"mine_morenzhaopian"];
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSignButton)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    self.avatar.userInteractionEnabled = YES;
    //给self.view添加一个手势监测；
    [self.avatar addGestureRecognizer:singleRecognizer];
    self.avatar.size = CGSizeMake(50,50);
    self.avatar.layer.cornerRadius = 25;
    self.avatar.clipsToBounds = YES;
    [self addSubview:self.avatar];
    
    //用户名
    self.userName = [[UILabel alloc] init];
    self.userName.textColor = [UIColor whiteColor];
    self.userName.font =[UIFont systemFontOfSize:18];
    [self addSubview:self.userName];
    
//    if ([SAAccount isLog]) {
//        self.userName.text = [SAAccount shareAccount].loginName;
//    }else{
//        self.userName.text = @"点击登录";
//    }
    
    UILabel *userLevel = [[UILabel alloc] init];
    userLevel.font =[UIFont systemFontOfSize:14];
    self.userLevel = userLevel;
    [self addSubview:userLevel];
    userLevel.backgroundColor = kColorFFB191;
    userLevel.textColor = [UIColor whiteColor];
    
    UIButton *youhuiBtn = [[UIButton alloc] init];
    youhuiBtn.titleLabel.numberOfLines = 0;
    youhuiBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
      youhuiBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.youhuiBtn = youhuiBtn;
    [self addSubview:youhuiBtn];
    [youhuiBtn addTarget:self action:@selector(youhuiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [youhuiBtn setTitle:@"3\n优惠券" forState:UIControlStateNormal];
    
    UIButton *jifengBtn = [[UIButton alloc] init];
    jifengBtn.titleLabel.numberOfLines = 0;
    jifengBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    jifengBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    self.jifengBtn = jifengBtn;
    [self addSubview:jifengBtn];
    [jifengBtn addTarget:self action:@selector(jifengBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [jifengBtn setTitle:@"417\n积分" forState:UIControlStateNormal];    self.jifengBtn = jifengBtn;
    [self addSubview:jifengBtn];
    
    UIButton *voucherBtn = [[UIButton alloc] init];
    [voucherBtn setImage:IMAGE(@"home_newUser") forState:UIControlStateNormal];
    [self addSubview:voucherBtn];
    [voucherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageBg.mas_bottom).mas_offset(-15);
        make.centerX.mas_equalTo(self);
    }];
    
}
- (void)youhuiBtnClick{
    if ([self.delegate respondsToSelector:@selector(mineHeadViewClickYouhui)]) {
        [self.delegate mineHeadViewClickYouhui];
    }
}
- (void)jifengBtnClick{
    if ([self.delegate respondsToSelector:@selector(mineHeadViewClickJifeng)]) {
        [self.delegate mineHeadViewClickJifeng];
    }
}

//点击登陆/注册按钮
- (void)didClickSignButton
{
//    if (![SAAccount isLog]) {
//        if ([self.delegate respondsToSelector:@selector(mineHeadViewClickSignButton)]) {
//            [self.delegate mineHeadViewClickSignButton];
//        }
//    }
//    else
//    {
//        if ([self.delegate respondsToSelector:@selector(mineHeadViewClickUserInfo)]) {
//            [self.delegate mineHeadViewClickUserInfo];
//        }
//    }
    
}

//是否为登录状态
- (void)setIsLogin:(BOOL)isLogin{
    _isLogin = isLogin;
    if (isLogin) {
//        self.userName.text = [SAAccount shareAccount].nickName;
        self.avatar.image = IMAGE(@"me_photo");
//        [self.avatar :[NSURL URLWithString:[SAAccount  shareAccount].photo] placeholderImage:IMAGE(@"mine_user_login")];
    }else{
        self.userName.text = @"点击登录";
        self.avatar.image = [UIImage imageNamed:@"mine_morenzhaopian"];
    }
    
    self.userName.text = @"括弧犬";
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:@"https://pic1.zhimg.com/50/fc86c5f7e8ac973d90f991eb4c8dc9c5_xs.jpg"] placeholderImage:[UIImage imageNamed:@"mine_morenzhaopian"]];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(20);
        make.top.mas_equalTo(self).mas_offset(60);
        make.size.mas_equalTo(self.avatar.size);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.avatar.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.avatar);
    }];
    
    [self.userLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userName);
        make.top.mas_equalTo(self.userName.mas_bottom).mas_offset(25);
    }];
    
    [self.youhuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(-kMainBoundsWidth * 0.25);
    make.top.mas_equalTo(self.avatar.mas_bottom).mas_offset(15);
    }];
    
    [self.jifengBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(kMainBoundsWidth * 0.25);
        make.top.mas_equalTo(self.avatar.mas_bottom).mas_offset(15);
    }];
}


//跳转目标控制器
- (void)pushToTargetController:(UIViewController *)viewController{
//    STNavigationController * nav = [STTabBarController sharedSTTabBarController].childViewControllers.lastObject;
//    [nav pushViewController:viewController animated:YES];
}

- (void)setModel:(SAPersonCenterModel *)model{
    _model = model;
    self.userName.text = model.carDealer;
   
}



@end
