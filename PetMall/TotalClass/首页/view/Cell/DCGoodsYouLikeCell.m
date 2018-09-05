//
//  DCGoodsYouLikeCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#define cellWH kMainBoundsWidth * 0.5 - 50

#import "DCGoodsYouLikeCell.h"

// Controllers

// Models
#import "DCRecommendItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsYouLikeCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 原价 */
@property (strong , nonatomic)UILabel *originLabel;

/* 参团人数 */
@property (strong , nonatomic)UILabel *peopleCountLabel;


@end

@implementation DCGoodsYouLikeCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = [UIFont systemFontOfSize:16];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_priceLabel];
    
    _originLabel = [[UILabel alloc] init];
    _originLabel.textColor = kColor999999;
    _originLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:_originLabel];
    
    _peopleCountLabel = [[UILabel alloc] init];
    _peopleCountLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _peopleCountLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_peopleCountLabel];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_sameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"立即参团" forState:UIControlStateNormal];
    _sameButton.backgroundColor = [UIColor colorWithHexStr:@"#FF3945"];
    _sameButton.layer.cornerRadius = 15;
    _sameButton.clipsToBounds = YES;
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sameButton];
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor colorWithHexStr:@"#FAFAFA"];
    [self addSubview:bottomView];
    
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        [make.centerY.mas_equalTo(self)setOffset:-5];
        make.size.mas_equalTo(CGSizeMake(120 , 120));
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView.mas_right).mas_offset(15);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsLabel); make.top.mas_equalTo(_goodsLabel.mas_bottom).mas_offset(15);
    }];
    
    [_originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(_priceLabel);
    }];
    
    [_peopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLabel); make.top.mas_equalTo(_priceLabel.mas_bottom).mas_offset(5);
    }];
    
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-10];
        make.top.mas_equalTo(_priceLabel).mas_offset(4);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.left.right.bottom.mas_equalTo(self);
    }];
}




#pragma mark - Setter Getter Methods
- (void)setYouLikeItem:(DCRecommendItem *)youLikeItem
{
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:youLikeItem.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",youLikeItem.price];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",youLikeItem.stock] attributes:attribtDic];
    _originLabel.attributedText = attribtStr;
    _peopleCountLabel.text = [NSString stringWithFormat:@"已%@人参团",youLikeItem.people_count];
    _goodsLabel.text = youLikeItem.main_title;
}

#pragma mark - 点击事件
- (void)lookSameGoods
{
    !_lookSameBlock ? : _lookSameBlock();
}

@end
