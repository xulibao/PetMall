//
//  PMConfirmOrderHeaderView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMConfirmOrderHeaderView.h"

@interface PMConfirmOrderHeaderView()
/** 位置 */
@property (nonatomic , strong) UIImageView *position;
/** 收货人 */
@property (nonatomic , strong) UILabel *receiver;
/** 向右箭头 */
@property (nonatomic , strong) UIImageView *arrow;
/** 电话号码 */
@property (nonatomic , strong) UILabel *phoneNum;
/** 地址 */
@property (nonatomic , strong) UILabel *address;


@property(nonatomic, strong) UIImageView *headerTiaoWenView;

@property(nonatomic, strong) UIImageView *footerTiaoWenView;

@end

@implementation PMConfirmOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
//        [self addGes];
    }
    return self;
}

- (UILabel *)address {
    if (_address == nil) {
        _address = [[UILabel alloc]init];
        _address.text = @"收货地址：山东省临沂市兰山区沂蒙路与涑河南街 交汇处西净雅新天地1号楼C座3楼";
        _address.numberOfLines = 0;
        _address.textColor = [UIColor blackColor];
        _address.font = [UIFont systemFontOfSize:13];
        
    }
    return _address;
}
- (UILabel *)phoneNum {
    if (_phoneNum == nil) {
        _phoneNum = [[UILabel alloc]init];
        _phoneNum.text = @"13836172531";
        _phoneNum.textColor = [UIColor blackColor];
        _phoneNum.font = [UIFont systemFontOfSize:13];
        
        
    }
    return _phoneNum;
}
- (UIImageView *)arrow {
    if (_arrow == nil) {
        _arrow = [[UIImageView alloc]init];
        _arrow.image = [UIImage imageNamed:@"home_youjiantou"];
    }
    return _arrow;
}
- (UILabel *)receiver {
    if (_receiver == nil) {
        _receiver = [[UILabel alloc]init];
        _receiver.text = @"收货人：李三";
        _receiver.textColor = [UIColor blackColor];
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

-(void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.position];
    [self.position mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(-7.5);
        make.left.equalTo(self).offset(15);
        make.height.equalTo(@20);
        make.width.equalTo(@15);
    }];
    
    [self addSubview:self.arrow];
    [self.arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.position);
        make.right.equalTo(self).offset(-15);
        make.height.equalTo(@15);
        make.width.equalTo(@10);
    }];
    //
    [self addSubview:self.receiver];
    [self.receiver mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.position.mas_right).offset(15);
        make.top.equalTo(self).offset(15);
    }];
    
    [self addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.arrow.mas_left).offset(-35);
        make.centerY.equalTo(self.receiver);
    }];
    [self addSubview:self.address];
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.receiver);
        make.top.equalTo(self.receiver.mas_bottom).offset(10);
        make.right.equalTo(self.arrow.mas_left).offset(-25);

    }];
    
    UIImageView * headerTiaoWenView = [UIImageView new];
    UIImage *image =  [UIImage imageNamed:@"oder_caitiao"];   //图片

    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    headerTiaoWenView.image = image;
    [self addSubview:headerTiaoWenView];
    
    UIImageView *footerTiaoWenView = [UIImageView new];
    image =  [UIImage imageNamed:@"oder_caitiao"];   //图片
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile];
    footerTiaoWenView.image = image;

    [self addSubview:footerTiaoWenView];
    
    UIImageView *headerView = [UIImageView new];
    headerView.backgroundColor = kColorFAFAFA;
    [self addSubview:headerView];
    
    UIImageView *bottomView = [UIImageView new];
    bottomView.backgroundColor = [UIColor colorWithHexStr:@"#F7F7F7"];
    [self addSubview:bottomView];

    
    [headerTiaoWenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(headerView.mas_bottom);
        make.left.mas_equalTo(-25);
        make.height.mas_equalTo(3);
    }];
    [footerTiaoWenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(bottomView.mas_top);
        make.left.mas_equalTo(headerTiaoWenView);
        make.height.mas_equalTo(3);
    }];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(5);
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(10);
        }];
    
}




@end
