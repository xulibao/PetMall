//
//  PMOrderDetailHeaderView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailHeaderView.h"

@interface PMOrderDetailHeaderView()
/** 运输图标 */
@property (nonatomic , strong) UIImageView *transportImage;
/** 运输标题 */
@property (nonatomic , strong) UILabel *transportTitle;
/** 运输时间 */
@property (nonatomic , strong) UILabel *transportTime;
/** 向右箭头 */
@property (nonatomic , strong) UIImageView *transportArrow;
/** 位置 */
@property (nonatomic , strong) UIImageView *position;
/** 收货人 */
@property (nonatomic , strong) UILabel *receiver;
/** 电话号码 */
@property (nonatomic , strong) UILabel *phoneNum;
/** 地址 */
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UILabel *statueLabel;
@end

@implementation PMOrderDetailHeaderView

- (UIImageView *)transportImage{
    if (_transportImage == nil) {
        _transportImage = [[UIImageView alloc]init];
        _transportImage.image = [UIImage imageNamed:@"order_transport"];
    }
    return _transportImage;
}

- (UILabel *)transportTitle{
    if (_transportTitle == nil) {
        _transportTitle = [[UILabel alloc] init];
        _transportTitle.text = @"【上海市】快件已从浦东转运中心发出，准备发往临沂市";
        _transportTitle.numberOfLines = 0;
        _transportTitle.textColor =  kColor333333;
        _transportTitle.font = [UIFont systemFontOfSize:13];
    }
    return _transportTitle;
}

- (UILabel *)transportTime {
    if (_transportTime == nil) {
        _transportTime = [[UILabel alloc]init];
        _transportTime.text = @"2018-07-18 10:15:58";
        _transportTime.textColor = kColor999999;
        _transportTime.font = [UIFont systemFontOfSize:10];
        
        
    }
    return _transportTime;
}

- (UIImageView *)transportArrow {
    if (_transportArrow == nil) {
        _transportArrow = [[UIImageView alloc]init];
        _transportArrow.image = [UIImage imageNamed:@"home_youjiantou"];
    }
    return _transportArrow;
}


- (UILabel *)address {
    if (_address == nil) {
        _address = [[UILabel alloc]init];
        _address.text = @"收货地址：山东省临沂市兰山区沂蒙路与涑河南街 交汇处西净雅新天地1号楼C座3楼";
        _address.numberOfLines = 0;
        _address.textColor = kColor333333;
        _address.font = [UIFont systemFontOfSize:13];
        
    }
    return _address;
}
- (UILabel *)phoneNum {
    if (_phoneNum == nil) {
        _phoneNum = [[UILabel alloc]init];
        _phoneNum.text = @"13836172531";
        _phoneNum.textColor =  kColor333333;
        _phoneNum.font = [UIFont systemFontOfSize:13];
        
        
    }
    return _phoneNum;
}

- (UILabel *)receiver {
    if (_receiver == nil) {
        _receiver = [[UILabel alloc]init];
        _receiver.text = @"收货人：李三";
        _receiver.textColor =  kColor333333;
        _receiver.font = [UIFont systemFontOfSize:13];
    }
    return _receiver;
}
- (UIImageView *)position {
    if (_position == nil) {
        _position = [[UIImageView alloc]init];
        _position.image = [UIImage imageNamed:@"comfirm_location"];
    }
    return _position;
}
-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self fecthSubViews];
    }
    return self;
}

- (void)fecthSubViews{
    self.backgroundColor = [UIColor colorWithHexStr:@"#f6f6f6"];
    UIView * topView = [[UIView alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, kMainBoundsWidth, 126);
    [topView.layer addSublayer:gradientLayer];
    [self addSubview:topView];
    
    UILabel * statueLabel = [[UILabel alloc] init];
    self.statueLabel = statueLabel;
    statueLabel.text = @"卖家已发货 运输中...";
    statueLabel.textColor = [UIColor whiteColor];
    [topView addSubview:statueLabel];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(126);
    }];
    
    [statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(25);
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    [bottomView addSubview:self.position];
    [bottomView addSubview:self.receiver];
    [bottomView addSubview:self.phoneNum];
    [bottomView addSubview:self.address];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(126);
    }];
    [self.position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView).offset(17.5);
        make.left.equalTo(bottomView).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@15);
    }];
    [self.receiver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.position.mas_right).offset(15);
        make.top.equalTo(bottomView).offset(55);
    }];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView).offset(-15);
        make.centerY.equalTo(self.receiver);
    }];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.receiver);
        make.top.equalTo(self.receiver.mas_bottom).offset(10);
        make.right.equalTo(bottomView).offset(-15);
        
    }];
    
    
    
    UIImageView * middleView = [[UIImageView alloc] init];
    middleView.userInteractionEnabled = YES;
    [middleView handleTapActionWithBlock:^(UIView *sender) {
        if (self.logisticsInformationBlcok) {
            self.logisticsInformationBlcok();
        }
    }];
    middleView.contentMode = UIViewContentModeScaleAspectFill;
    middleView.image = IMAGE(@"order_shadowBg");
    [self addSubview:middleView];
    [middleView addSubview:self.transportImage];
    [middleView addSubview:self.transportTitle];
    [middleView addSubview:self.transportTime];
    [middleView addSubview:self.transportArrow];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(85);
    }];
    
    [self.transportImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(middleView);
    }];
    [self.transportTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.transportImage.mas_right).mas_offset(20);
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(self.transportArrow.mas_left).mas_offset(-20);
    }];
    [self.transportTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.transportTitle);
        make.bottom.mas_equalTo(-12);
    }];
    
    [self.transportArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(middleView);
        make.right.mas_equalTo(-15);
    }];
}

- (void)setDetailModel:(PMOrderDetailModel *)detailModel{
    _detailModel = detailModel;
    PMOrderDetailAdressItem * addressItem = [detailModel.address firstObject];
    self.statueLabel.text = detailModel.statusText;
    self.phoneNum.text = addressItem.user_phone;
    self.address.text = [NSString stringWithFormat:@"收货地址：%@%@",addressItem.user_address,addressItem.user_add];
    self.receiver.text = [NSString stringWithFormat:@"收货人：%@",addressItem.user_name];
}
@end
