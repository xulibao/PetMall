//
//  PMContactUsViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMContactUsViewController.h"

@interface PMContactUsViewController ()
@property(nonatomic, strong) UILabel *contactusLabel;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UITextField *textField1;
@end

@implementation PMContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    [self fecthData];
    
}
- (void)fecthData{
    [self requestPOST:API_user_contactus parameters:nil success:^(__kindof SARequest *request, id responseObject) {
        self.contactusLabel.text = responseObject[@"result"];
    } failure:NULL];
}

- (void)initSubviews{
    [super initSubviews];
    UIView * bgView = [UIView new];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.borderColor = [UIColor colorWithHexStr:@"#e2e2e2"].CGColor;
    bgView.layer.borderWidth = 0.5;
    [self.view addSubview:bgView];

    
    UILabel * label = [UILabel new];
    self.contactusLabel = label;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"致用户\n\n尊敬用户，欢迎您使用***APP，任何对***的建议都可以在这里直接告诉我们。我们会认真阅读每一份反馈并进行改进。你的反馈是我们最关注的事情。请相信我们，相信***团队。";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = kColor999999;
    [bgView addSubview:label];

    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(155);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
    }];
    UITextField * textField = [UITextField new];
    self.textField = textField;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"输入想对我们说的话";
    [self.view addSubview:textField];
    [textField sp_addBottomLineWithLeftMargin:0 rightMargin:0];
    UITextField * textField1= [UITextField new];
    self.textField1 = textField1;
    textField1.font = [UIFont systemFontOfSize:15];
    textField1.placeholder = @"留下手机号码  方便与您联系";
    [self.view addSubview:textField1];
    [textField1 sp_addBottomLineWithLeftMargin:0 rightMargin:0];

    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(bgView);
        make.right.mas_equalTo(bgView);
        make.height.mas_equalTo(40);
    }];
    
    [textField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(textField.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(bgView);
        make.right.mas_equalTo(bgView);
        make.height.mas_equalTo(40);
    }];
    
    
    UIButton * footView = [[UIButton alloc] init];
    [self.view addSubview:footView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [footView.layer addSublayer:gradientLayer];
//    [bgView addSubview:footView];
    footView.titleLabel.font = [UIFont systemFontOfSize:18];
    [footView setTitle:@"提交" forState:UIControlStateNormal];
    [footView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addTarget:self
                 action:@selector(commit)
       forControlEvents:UIControlEventTouchUpInside];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view); make.top.mas_equalTo(textField1.mas_bottom).mas_offset(30);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
    }];
    
    
}

-(void)commit{
    if ([self.textField.text length] == 0 || [self.textField1.text length] == 0) {
        [self showWaring:@"请填写内容"];
        return;
    }
    [self requestPOST:API_user_submission parameters:@{@"user_id":[SAApplication userID],@"content":self.textField.text,@"phone":self.textField1.text} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"提交成功"];
        [self performSelector:@selector(popView) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];


    } failure:NULL];

}

- (void)popView{
    [self.navigationController popViewControllerAnimated:YES];

}


@end
