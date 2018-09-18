//
//  PMNewUserViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/18.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMNewUserViewController.h"

@interface PMNewUserViewController ()

@end

@implementation PMNewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView * bgView = [[UIImageView alloc] init];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    if (kMainBoundsHeight == 480) {
        bgView.image = IMAGE(@"xinren_640x960");
    }else if (kMainBoundsHeight == 568){
        bgView.image = IMAGE(@"xinren_640x1136");
    }else if (kMainBoundsHeight == 667){
        bgView.image = IMAGE(@"xinren_750x1334");
    }else if (kMainBoundsHeight == 736){
        bgView.image = IMAGE(@"xinren_1242x2208");
    }else if (kMainBoundsHeight == 812){
        bgView.image = IMAGE(@"xinren_1125x2436");
    }
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    
    UIButton * maoBtn = [[UIButton alloc] init];
    [maoBtn setImage:IMAGE(@"login_logo_mao") forState:UIControlStateNormal];
    [bgView addSubview:maoBtn];
    
    UIButton * gouBtn = [[UIButton alloc] init];
    [gouBtn setImage:IMAGE(@"login_logo_gou") forState:UIControlStateNormal];
    [bgView addSubview:gouBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
