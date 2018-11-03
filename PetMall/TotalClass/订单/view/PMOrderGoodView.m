//
//  PMOrderGoodView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/28.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMOrderGoodView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PMOrderGoodView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self fecthSubViews];
    }
    return self;
}

- (void)fecthSubViews{
    self.backgroundColor = kColorEEEEEE;
    
    UIImageView * cartImageView = [[UIImageView alloc] init];
    cartImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cartImageView = cartImageView;
    [self addSubview:cartImageView];
    
    
    UILabel *cartTitleLabel = [[UILabel alloc] init];
    cartTitleLabel.numberOfLines = 0;
    self.cartTitleLabel = cartTitleLabel;
    cartTitleLabel.font = [UIFont systemFontOfSize:13];
    cartTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self addSubview:cartTitleLabel];
    
    UILabel *cartNatureLabel = [[UILabel alloc] init];
    self.cartNatureLabel = cartNatureLabel;
    cartNatureLabel.font = [UIFont systemFontOfSize:13];
    cartNatureLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    [self addSubview:cartNatureLabel];
    
    UILabel *cartPriceLabel = [[UILabel alloc] init];
    self.cartPriceLabel = cartPriceLabel;
    cartPriceLabel.font = [UIFont systemFontOfSize:14];
    cartPriceLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [self addSubview:cartPriceLabel];
    
    UILabel *cartCountLabel = [[UILabel alloc] init];
    self.cartCountLabel = cartCountLabel;
    cartCountLabel.font = [UIFont systemFontOfSize:12];
    cartCountLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    cartCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:cartCountLabel];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(self).mas_offset(10);
        make.centerY.mas_equalTo(self);
        //        make.top.mas_equalTo(10);
        //        make.bottom.mas_equalTo(-10);
        
    }];
    
    [cartTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartImageView.mas_right).mas_offset(10);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-50);
    }];
    
    [cartNatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartTitleLabel);
        make.top.mas_equalTo(cartTitleLabel.mas_bottom).mas_offset(6);
    }];
    
    [cartPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
    }];
    
    
    [cartCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cartPriceLabel);
        make.centerY.mas_equalTo(cartNatureLabel);
    }];
}

- (void)setData:(PMOrderListItem *)data{
    _data = data;
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo] placeholderImage:nil];
    self.cartTitleLabel.text = data.goods_title;
    self.cartNatureLabel.text = data.goods_spec;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",data.pay_price];
    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",data.goods_shul];
}

@end
