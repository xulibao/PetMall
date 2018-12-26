//
//  DCFeatureChoseTopCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCFeatureChoseTopCell.h"

@interface DCFeatureChoseTopCell ()

/* 取消 */
@property (strong , nonatomic)UIButton *crossButton;
/* 商品价格 */
@property (strong , nonatomic)UILabel *goodPriceLabel;

/* 选择属性 */
@property (strong , nonatomic)UILabel *chooseAttLabel;
/* 商品编号 */
@property (strong , nonatomic)UILabel *goodNumberLabel;
@end

@implementation DCFeatureChoseTopCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setUpUI{
    _crossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_crossButton setImage:[UIImage imageNamed:@"icon_cha"] forState:0];
    [_crossButton addTarget:self action:@selector(crossButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_crossButton];
    
    _goodImageView = [UIImageView new];
    [self addSubview:_goodImageView];
    
    _goodPriceLabel = [UILabel new];
    _goodPriceLabel.font = PFR18Font;
    _goodPriceLabel.textColor = kColorFF3945;
    [self addSubview:_goodPriceLabel];
    
    _goodNumberLabel = [UILabel new];
    _goodNumberLabel.font = PFR12Font;
    [self addSubview:_goodNumberLabel];
    
    _chooseAttLabel = [UILabel new];
    _chooseAttLabel.numberOfLines = 2;
    _chooseAttLabel.font = PFR14Font;
    [self addSubview:_chooseAttLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_crossButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
    [_goodImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
  
    [self.chooseAttLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodPriceLabel);
        make.right.mas_equalTo(self.crossButton.mas_left);
        [make.top.mas_equalTo(self.goodImageView)setOffset:DCMargin];
    }];
    [self.goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.goodImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(self.chooseAttLabel.mas_bottom)setOffset:DCMargin];
    }];
    [_goodNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self.goodImageView.mas_right)setOffset:DCMargin];
        [make.top.mas_equalTo(self.goodPriceLabel.mas_bottom)setOffset:DCMargin];
    }];
 
    
}


- (void)crossButtonClick{
    !_crossButtonClickBlock ?: _crossButtonClickBlock();
}

#pragma mark - Setter Getter Methods
- (void)setPriceModel:(PMGoodDetailPriceModel *)priceModel{
    _priceModel = priceModel;
    self.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",priceModel.selling_price];
    self.chooseAttLabel.text = [NSString stringWithFormat:@"已选属性：%@",priceModel.goods_spec ? priceModel.goods_spec : @"请选择"] ;
    if (priceModel.number) {
        self.goodNumberLabel.hidden = NO;
        self.goodNumberLabel.text = [NSString stringWithFormat:@"商品编号：%@",priceModel.number] ;
    }else{
        self.goodNumberLabel.hidden = YES;
    }
}

@end
