//
//  SACustomBottomView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kLoginForgetTitle @"忘记密码"
#define kLoginFastTitle @"无账号快速登录"
#define kLoginTitle @"开始使用"
#define kExistingAccountTitle @"已有登录账号"
#define kFastLoginTitle @"快速登录"
#define kLoginCommitTitle @"提   交"
#define kSignUpTitle @"注   册"


@class SACustomBottomView;
@protocol SACustomBottomViewDelegate <NSObject>

@optional
- (void)footViewClickButton:(UIButton *)button;
- (void)pushToAgreementController;//跳转协议控制器
- (void)isComplyWithTheAgreement;//是否遵守协议

@end

@interface SACustomBottomView : UIView
/**
 * title : 中间按钮文字
 *
 * leftTitle :左下角文章
 *
 * rightButton : 右下角文集
 */
+ (instancetype)footViewWithCenterButtonTitle:(NSString *)title leftButtomButtonTitle:(NSString *)leftTitle rightButtomButton:(NSString * )rightTitle;

@property (nonatomic, copy) NSString * centerTitle; //中间文字

@property (nonatomic, strong) UIButton * loginButton;//登录按钮

@property (nonatomic,weak) id <SACustomBottomViewDelegate> delegate; //点击了一行

@property (nonatomic, strong) UIView * agreementView;//协议空间

@property (nonatomic, strong)UIButton * button; //勾选按钮

@end

