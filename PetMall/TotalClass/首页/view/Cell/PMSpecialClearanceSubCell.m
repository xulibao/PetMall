//
//  PMSpecialClearanceSubCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSpecialClearanceSubCell.h"
// Views
#import "DCRecommendItem.h"
// Vendors
#import <UIImageView+WebCache.h>
@interface PMSpecialClearanceSubCell()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 剩余 */
@property (strong , nonatomic)UILabel *stockLabel;
/* 属性 */
@property (strong , nonatomic)UILabel *natureLabel;

@end


@implementation PMSpecialClearanceSubCell
#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    
    _stockLabel = [[UILabel alloc] init];
    _stockLabel.font = [UIFont systemFontOfSize:11];
    _stockLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _stockLabel.textAlignment = NSTextAlignmentCenter;
    _stockLabel.layer.cornerRadius = 6;
    _stockLabel.layer.borderColor = [UIColor colorWithHexStr:@"#FF3945"].CGColor;
    _stockLabel.layer.borderWidth = 0.5;
    _stockLabel.clipsToBounds = YES;
    [self addSubview:_stockLabel];
    
    _natureLabel = [[UILabel alloc] init];
    _natureLabel.textAlignment = NSTextAlignmentCenter;
    _natureLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_natureLabel];
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(70);
    }];
    
    [_stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_natureLabel.mas_bottom)setOffset:5];
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 15));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(_stockLabel.mas_bottom)setOffset:9];
        make.centerX.mas_equalTo(self);
    }];
    
    [_natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_goodsImageView.mas_bottom).mas_offset(12);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
}

#pragma mark - Setter Getter Methods
- (void)setClearingModel:(PMClearingModel *)clearingModel{
    _clearingModel = clearingModel;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:clearingModel.goods_logo]];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",clearingModel.selling_price];
    
    _stockLabel.text = [NSString stringWithFormat:@"%.2f折",[clearingModel.goods_pir floatValue]];
    _natureLabel.text = clearingModel.goods_title;
}

@end
