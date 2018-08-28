//
//  SACustomBottomView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACustomBottomView.h"

@interface SACustomBottomView ()
@property (nonatomic, strong) UIButton * forgetButton;//忘记密码按钮
@property (nonatomic, strong) UIButton * fastButton;//无账号快速登录按钮
@property (nonatomic, copy) NSString * leftTitle; //左下角文字
@property (nonatomic, copy) NSString * rightTitle;//右下角文字

@end

@implementation SACustomBottomView

- (UIView *)agreementView{
    if (!_agreementView ) {
        _agreementView =[[UIView alloc] init];
        
        UILabel * title = [[UILabel alloc] init];
        title.text = @"登录即表示你同意";
        title.font = [UIFont systemFontOfSize:12];
        title.textColor = kColorTextLighGay;
        title.size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [_agreementView addSubview:title];
        
        //协议按钮文本
        UIButton * agreementButton = [UIButton creatButtonFrame:CGRectMake(0, 0, 0, 0) title:@"《蜗牛二手货车用户服务协议》" andNormalImage:nil withHightImage:nil];
        agreementButton.titleLabel.font = title.font;
        [agreementButton setTitleColor:kColorBGRed forState:UIControlStateNormal];
        agreementButton.size = [agreementButton.titleLabel boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        [_agreementView addSubview:agreementButton];
        [agreementButton addTarget:self action:@selector(agreementButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_agreementView];
        
        CGFloat margin = 5;
        _agreementView.height = agreementButton.height;
        _agreementView.width = agreementButton.width + title.width + agreementButton.height + margin;
        
        //勾选按钮
        self.button = [UIButton creatButtonFrame:CGRectMake(0, 0, agreementButton.height, agreementButton.height) title:nil andNormalImage:nil withHightImage:nil];
        self.button.adjustsImageWhenHighlighted = NO;
        [self.button setImage:[UIImage imageNamed:@"mine_subscribeSelect"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"mine_subscribeNormal"] forState:UIControlStateSelected];
        [self.button addTarget:self action:@selector(buttonSelect:) forControlEvents:UIControlEventTouchDown];
        self.button.hidden = YES;
        [_agreementView addSubview:self.button];
        
        title.x = CGRectGetMaxX(self.button.frame) + margin;
        agreementButton.x = CGRectGetMaxX(title.frame);
        
        _agreementView.x = (kMainBoundsWidth - _agreementView.width) * 0.5;
        _agreementView.y = CGRectGetMaxY(self.forgetButton.frame) + 10;
    }
    
    return _agreementView;
}

- (void)buttonSelect:(UIButton *)button{
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(isComplyWithTheAgreement)]) {
        //是否遵守协议
        [self.delegate isComplyWithTheAgreement];
    }
}

- (void)agreementButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(pushToAgreementController)]) {
        //跳转协议控制器
        [self.delegate pushToAgreementController];
    }
}

- (void)initViews{
    //登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginButton setTitle:self.centerTitle forState:UIControlStateNormal];
    [self.loginButton setTitleColor:kColorCellground forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage imageWithColor:kColorBGRed] forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:[UIImage resizableImageWithName:@"sell_commitDisEnable"] forState:UIControlStateDisabled];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.loginButton addTarget:self action:@selector(FootViewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.x = 35;
    self.loginButton.width = kMainBoundsWidth - 2 * self.loginButton.x;
    self.loginButton.height = 40;
    self.loginButton.y = 35;
    
    [self addSubview:self.loginButton];
    
    //忘记密码
    if (self.leftTitle.length >0) {
        self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.forgetButton setTitle:self.leftTitle forState:UIControlStateNormal];
        [self.forgetButton setTitleColor:kColorMaiRed forState:UIControlStateNormal];
        self.forgetButton.titleLabel.font = [UIFont systemFontOfSize:11];
        self.forgetButton.width = [self.forgetButton.titleLabel boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        self.forgetButton.height = 30;
        self.forgetButton.x = self.loginButton.x;
        self.forgetButton.y = CGRectGetMaxY(self.loginButton.frame);
        [self.forgetButton addTarget:self action:@selector(FootViewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.forgetButton];
    }
    if (self.rightTitle.length > 0) {
        //快速登录
        self.fastButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.fastButton setTitle:self.rightTitle forState:UIControlStateNormal];
        [self.fastButton setTitleColor:kColorMaiRed forState:UIControlStateNormal];
        self.fastButton.titleLabel.font = [UIFont systemFontOfSize:11];
        self.fastButton.width = [self.fastButton.titleLabel boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
        self.fastButton.height = 30;
        self.fastButton.x = CGRectGetMaxX(self.loginButton.frame) - self.fastButton.width;
        self.fastButton.y = CGRectGetMaxY(self.loginButton.frame);
        [self.fastButton addTarget:self action:@selector(FootViewsButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.fastButton];
    }
    
    
}

- (void)setCenterTitle:(NSString *)centerTitle{
    _centerTitle = centerTitle;
    [self.loginButton setTitle:centerTitle forState:UIControlStateNormal];
}

+ (instancetype)footViewWithCenterButtonTitle:(NSString *)title leftButtomButtonTitle:(NSString *)leftTitle rightButtomButton:(NSString * )rightButton{
    return [[self alloc] initWithCenterButtonTitle:title leftButtomButtonTitle:leftTitle rightButtomButton:rightButton];
}

- (instancetype)initWithCenterButtonTitle:(NSString *)title leftButtomButtonTitle:(NSString *)leftTitle rightButtomButton:(NSString * )rightTitle{
    if (self = [super init]) {
        self.centerTitle = title;
        self.leftTitle = leftTitle;
        self.rightTitle = rightTitle;
        [self initViews];
    }
    return self;
}

//点击了那个按钮传回控制器
- (void)FootViewsButtonClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(footViewClickButton:)]) {
        
        [self.delegate footViewClickButton:button];
    }
}

@end
