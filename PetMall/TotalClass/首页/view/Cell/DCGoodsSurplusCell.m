//
//  DCGoodsSurplusCell.m
//  CDDMall
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsSurplusCell.h"

// Controllers

// Models

// Views
#import "DCRecommendItem.h"
// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsSurplusCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 商品名 */
@property (strong , nonatomic)UILabel *natureLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 原价 */
@property (strong , nonatomic)UILabel *stockLabel;


@end

@implementation DCGoodsSurplusCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    [self addSubview:_priceLabel];
    
    _stockLabel = [[UILabel alloc] init];
    _stockLabel.textColor = [UIColor darkGrayColor];
    _stockLabel.font = [UIFont systemFontOfSize:12];
    _stockLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_stockLabel];
    
    _natureLabel = [[UILabel alloc] init];
    _natureLabel.textAlignment = NSTextAlignmentCenter;
    _natureLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_natureLabel];
    
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(100);
    }];
    
    [_natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsImageView.mas_bottom).mas_offset(10);
        make.centerX.mas_equalTo(self.goodsImageView);
//        make.size.mas_equalTo(CGSizeMake(30, 15));
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.natureLabel.mas_bottom).mas_offset(5);
        make.centerX.mas_equalTo(self).mas_offset(-25);
    }];
    
    [_stockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel);
        make.centerX.mas_equalTo(self).mas_offset(25);
    }];
    
    [self sp_addTopLineWithLeftMargin:0 rightMargin:0];
    [self sp_addVerticalTailLineWithTopMargin:0 bottomMargin:0];
}

#pragma mark - Setter Getter Methods
- (void)setSecondkillModel:(PMSecondkillModel *)secondkillModel{
    _secondkillModel = secondkillModel;
    
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:secondkillModel.goods_logo]];
    
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",secondkillModel.selling_price];
    
    NSString * stock = [NSString stringWithFormat:@"¥%@",secondkillModel.market_price];;
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:stock attributes:attribtDic];
    _stockLabel.attributedText = attribtStr;
    _natureLabel.text = secondkillModel.goods_title;
}

@end
