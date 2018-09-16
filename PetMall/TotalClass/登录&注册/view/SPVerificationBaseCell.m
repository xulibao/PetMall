//
//  SAVerificationBaseCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SPVerificationBaseCell.h"
#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

@interface SPVerificationBaseCell()<STCommonTableViewItemUpdateDelegate>

@property (nonatomic, strong) UILabel * titleLabel; //标题
//@property (nonatomic, strong) UIImageView * leftImageView; //左边标题
@property (nonatomic, strong) UIButton *verificationButton;//验证按钮
@property (nonatomic, strong) UIButton *secureBtn;//密文按钮
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *bgView;

@end

@implementation SPVerificationBaseCell
@synthesize cellDelegate=_cellDelegate;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.fd_enforceFrameLayout = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    //白色背景
    self.contentView.backgroundColor = kColorFAFAFA;
    
    //
    UIView * bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    //    //标题
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.textColor = [UIColor colorWithHexStr:@"#666666"];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    
    [bgView addSubview:self.titleLabel];
    
//    UIImageView *leftImageView = [[UIImageView alloc] init];
//    leftImageView.contentMode =  UIViewContentModeCenter;
//    self.leftImageView = leftImageView;
//    [bgView addSubview:leftImageView];
    
    //输入框
    self.cellTextField =[[SABaseInputValidTextField alloc] init];
    [self.cellTextField addTarget:self action:@selector(baseFieldDidEditWithText:) forControlEvents:UIControlEventEditingChanged];
    self.cellTextField.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 20);
    self.cellTextField.backgroundColor = [UIColor clearColor];
    self.cellTextField.font = [UIFont systemFontOfSize:15];
    self.cellTextField.textColor = kColorTextBlack;
    [bgView addSubview:self.cellTextField];

    //获取验证码按钮
    self.verificationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.verificationButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.verificationButton setTitleColor:kColorFF3945 forState:UIControlStateNormal];
    self.verificationButton.backgroundColor = [UIColor clearColor];
    self.verificationButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.verificationButton addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:self.verificationButton];
    [self.verificationButton sp_addVerticalHeadLineWithTopMargin:5 bottomMargin:5];
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 94, 30) byRoundingCorners:UIRectCornerAllCorners  cornerRadii:CGSizeMake(15,15)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = CGRectMake(0, 0, 94, 30);
//    maskLayer.path = maskPath.CGPath;
//    self.verificationButton.layer.mask = maskLayer;
    
    UIButton *secureBtn = [[UIButton alloc] init];
    [secureBtn addTarget:self action:@selector(secureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.secureBtn = secureBtn;
    secureBtn.hidden = YES;
    [secureBtn setImage:IMAGE(@"login_biyan") forState:UIControlStateNormal];
     [secureBtn setImage:IMAGE(@"login_zhengyan") forState:UIControlStateSelected];
    [bgView addSubview:secureBtn];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.height.mas_equalTo(44);
        make.bottom.mas_equalTo(-15);
    }];
    
//    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(10);
//        make.centerY.mas_equalTo(bgView);
//        make.size.mas_equalTo(CGSizeMake(20, 23));
//    }];
//
    [self.cellTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.top.bottom.mas_equalTo(bgView);
        make.right.mas_equalTo(self.verificationButton.mas_left);
    }];
    
    [self.verificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(110, 30));
    }];
    
    [secureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(bgView);
        make.centerY.mas_equalTo(bgView);
        make.size.mas_equalTo(CGSizeMake(50, 30));


    }];
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(UI_SCREEN_WIDTH, 60);
}

- (void)secureBtnClick{
    self.secureBtn.selected = !self.secureBtn.selected;
    self.cellTextField.secureTextEntry = !self.secureBtn.selected;
    self.model.isCiphertext = !self.secureBtn.selected;
}

- (void)getVerificationCode:(UIButton *)button
{
    
    if ([self.cellDelegate respondsToSelector:@selector(cellDidClickSendMessageCode:)]) {
        [self.cellDelegate cellDidClickSendMessageCode:self];
    }
}


- (void)baseFieldDidEditWithText:(SABaseInputValidTextField *)baseField{
    if (self.model && self.model.showType == kVerificationShowForShow) {
        if (baseField.text.length == 11) {
            self.verificationButton.enabled = YES;
//            self.verificationButton.backgroundColor = kColorFF5554;
//            [self.verificationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            self.verificationButton.enabled = YES;
//            [self.verificationButton setTitleColor:kColor999999 forState:UIControlStateNormal];
//            self.verificationButton.backgroundColor = kColorEEEEEE;
        }
    }
    self.model.severValue = baseField.text;
    self.model.titleText = baseField.text;

}

- (void)updateVerifcationWithViewData:(SPVerificationBaseModel *)data {
    if (data.countdownEpisode.isTimeOver) {
        self.verificationButton.enabled = YES;
        [self.verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [self.verificationButton setTitleColor:kColor999999 forState:UIControlStateNormal];
//        self.verificationButton.backgroundColor = kColorEEEEEE;
    } else {
        self.verificationButton.enabled = NO;
        [self.verificationButton setTitle:[NSString stringWithFormat:@"%.2lld秒后可重发",data.countdownEpisode.countDownSecond]
                                 forState:UIControlStateNormal];
//        [self.verificationButton setBackgroundColor:kColorFF5554];
//        [self.verificationButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
//    if(timeout<=0){ //倒计时结束，关闭
//        dispatch_source_cancel(_timer);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //设置界面的按钮显示 根据自己需求设置
//        });
//    }else{
//        int seconds = timeout % 120;
//        NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //设置界面的按钮显示 根据自己需求设置
//
//        });
//        signUpVerTime = timeout;
//        if (timeout ==0) {
//            signUpVerTime = 120;
//        }
//    }
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(SPVerificationBaseModel *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.model = data;
    self.titleLabel.text = (NSString *)data.titleText;
    self.secureBtn.hidden = !data.isShowCiphertext;
    self.cellTextField.secureTextEntry = data.isCiphertext;
    self.cellTextField.placeholder = data.feildPlace;
    self.cellTextField.keyboardType = data.keyBoardType;
    self.cellTextField.inputHandle = data.handle;
    if (data.severValue && data.severValue.length > 0) {
        self.cellTextField.text = data.severValue;
    }
    if (data.showType == kVerificationShowForShow) { //显示验证
        self.verificationButton.hidden = NO;
        [data addDelegate:self];
    }else{
//        if (self.secureBtn.hidden) {
//            [self.cellTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.left.mas_equalTo(44);
//                make.top.bottom.mas_equalTo(self.bgView);
//                make.right.mas_equalTo(-30);
//            }];

//        }
        self.verificationButton.hidden = YES;
    }
    
    [self updateVerifcationWithViewData:data];

}

#pragma mark - STCommonTableViewItemUpdateDelegate

- (void)objectDidUpdate:(SPVerificationBaseModel *)object {
    if ([object isKindOfClass:[SPVerificationBaseModel class]]) {
        [self updateVerifcationWithViewData:object];
    }
}

- (void)objectDidExpired:(SPVerificationBaseModel *)object {
    if ([object isKindOfClass:[SPVerificationBaseModel class]]) {
        [self updateVerifcationWithViewData:object];
    }
}

@end
