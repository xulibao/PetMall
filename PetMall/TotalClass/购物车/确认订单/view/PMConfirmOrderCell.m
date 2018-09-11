//
//  PMConfirmOrderCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMConfirmOrderCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PMConfirmOrderCell()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;

@end
@implementation PMConfirmOrderCell

- (void)initViews{

    
    UIView * bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = kColorEEEEEE;
    [self.contentView addSubview:bgView];
    
    
    UIImageView * cartImageView = [[UIImageView alloc] init];
    cartImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cartImageView = cartImageView;
    [bgView addSubview:cartImageView];
    
    
    UILabel *cartTitleLabel = [[UILabel alloc] init];
    cartTitleLabel.numberOfLines = 0;
    self.cartTitleLabel = cartTitleLabel;
    cartTitleLabel.font = [UIFont systemFontOfSize:13];
    cartTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [bgView addSubview:cartTitleLabel];
    
    UILabel *cartNatureLabel = [[UILabel alloc] init];
    self.cartNatureLabel = cartNatureLabel;
    cartNatureLabel.font = [UIFont systemFontOfSize:13];
    cartNatureLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    [bgView addSubview:cartNatureLabel];
    
    UILabel *cartPriceLabel = [[UILabel alloc] init];
    self.cartPriceLabel = cartPriceLabel;
    cartPriceLabel.font = [UIFont systemFontOfSize:14];
    cartPriceLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [bgView addSubview:cartPriceLabel];
    
    UILabel *cartCountLabel = [[UILabel alloc] init];
    self.cartCountLabel = cartCountLabel;
    cartCountLabel.font = [UIFont systemFontOfSize:12];
     cartCountLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    cartCountLabel.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:cartCountLabel];
    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.bottom.mas_equalTo(self.contentView);
    }];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(bgView).mas_offset(10);
        make.centerY.mas_equalTo(bgView);
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

- (void)setItem:(DCRecommendItem *)item{
    _item = item;
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:item.image_url] placeholderImage:nil];
    self.cartTitleLabel.text = item.goods_title;
    self.cartNatureLabel.text = item.nature;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",item.people_count];
}
@end
