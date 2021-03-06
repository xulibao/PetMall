//
//  PMRegisterViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMAdorViewController.h"
#import "PMBindingPhoneViewController.h"
#import "SAUserInfoEntity.h"
@interface PMAdorViewController()

@end

@implementation PMAdorViewController
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
        bgView.image = IMAGE(@"login_mao_640x960");
    }else if (kMainBoundsHeight == 568){
        bgView.image = IMAGE(@"login_mao_640x1136");
    }else if (kMainBoundsHeight == 667){
        bgView.image = IMAGE(@"login_mao_750x1334");
    }else if (kMainBoundsHeight == 736){
        bgView.image = IMAGE(@"login_mao_1242x2208");
    }else if (kMainBoundsHeight == 812){
        bgView.image = IMAGE(@"login_mao_1125x2436");
    }
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
    UIButton * maoBtn = [[UIButton alloc] init];
    maoBtn.tag = 1;
    [maoBtn setImage:IMAGE(@"login_logo_mao") forState:UIControlStateNormal];
    [bgView addSubview:maoBtn];
    
    UIButton * gouBtn = [[UIButton alloc] init];
    gouBtn.tag = 2;
    [gouBtn setImage:IMAGE(@"login_logo_gou") forState:UIControlStateNormal];
    [bgView addSubview:gouBtn];
    
    
    [maoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(70);
        make.centerY.mas_equalTo(-70);
    }];
    
    [gouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-70);
        make.centerY.mas_equalTo(70);
    }];
    
    [maoBtn addTarget:self action:@selector(adorSelect:) forControlEvents:UIControlEventTouchUpInside];
    [gouBtn addTarget:self action:@selector(adorSelect:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)adorSelect:(UIButton *)btn{
    if ([SAApplication userID] == nil) {
        [self showWaring:@"请先登录"];
        return;
    }
    NSString * zt;
    if (btn.tag == 1) { //mao
        zt = @"1";
    }else{
        zt = @"0";
    }
    [self requestPOST:API_user_choice parameters:@{@"user_id":[SAApplication userID],@"zt":zt} success:^(__kindof SARequest *request, id responseObject) {
        [SAApplication sharedApplication].userType = zt;
        [self showSuccess:responseObject[@"result"]];
        if (self.callBack) {
            self.callBack(self);
        }
//        [self.navigationController popToRootViewControllerAnimated:YES];
    } failure:NULL];
    
//    PMBindingPhoneViewController * vc = [PMBindingPhoneViewController new];
//    [self pushViewController:vc];
}

@end
