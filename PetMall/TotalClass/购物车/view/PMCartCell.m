//
//  PMCartCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMCartCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface PMCartCell()

@property(nonatomic, strong) UIButton *selectBtn;
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;
@end

@implementation PMCartCell

- (void)initViews{
    
    UIButton *selectBtn = [[UIButton alloc] init];
    selectBtn.backgroundColor = kColorFAFAFA;
    [selectBtn setImage:IMAGE(@"cart_yuanquan") forState:UIControlStateNormal];
    [selectBtn setImage:IMAGE(@"cart_yuanquan_selected") forState:UIControlStateSelected];
    self.selectBtn = selectBtn;
    [selectBtn addTarget:self action:@selector(selectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:selectBtn];
    
    
    UIView * bgView = [[UIView alloc] init];
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];

    
    UIImageView * cartImageView = [[UIImageView alloc] init];
    cartImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.cartImageView = cartImageView;
    [bgView addSubview:cartImageView];

    
    UILabel *cartTitleLabel = [[UILabel alloc] init];
    cartTitleLabel.numberOfLines = 0;
    self.cartTitleLabel = cartTitleLabel;
    cartTitleLabel.font = [UIFont systemFontOfSize:16];
    cartTitleLabel.textColor = [UIColor colorWithHexStr:@"#333333"];
    [bgView addSubview:cartTitleLabel];
    
    UILabel *cartNatureLabel = [[UILabel alloc] init];
    self.cartNatureLabel = cartNatureLabel;
    cartNatureLabel.font = [UIFont systemFontOfSize:13];
    cartNatureLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    [bgView addSubview:cartNatureLabel];
    
    
    UILabel *cartPriceLabel = [[UILabel alloc] init];
    self.cartPriceLabel = cartPriceLabel;
    cartPriceLabel.font = [UIFont systemFontOfSize:15];
    cartPriceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    [bgView addSubview:cartPriceLabel];
    
    UILabel *cartCountLabel = [[UILabel alloc] init];
    self.cartCountLabel = cartCountLabel;
    cartCountLabel.font = [UIFont systemFontOfSize:15];
    cartCountLabel.textAlignment = NSTextAlignmentCenter;
    cartCountLabel.backgroundColor = [UIColor colorWithHexStr:@"#EEEEEE"];
    [bgView addSubview:cartCountLabel];
    
    UIButton *plusBtn = [[UIButton alloc] init];
    [plusBtn setTitle:@"+" forState:UIControlStateNormal];
    [plusBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:plusBtn];
    [plusBtn addTarget:self action:@selector(plusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *reduceBtn = [[UIButton alloc] init];
    [reduceBtn setTitle:@"-" forState:UIControlStateNormal];
    [reduceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bgView addSubview:reduceBtn];
     [reduceBtn addTarget:self action:@selector(reduceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(40);
    }];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectBtn.mas_right);
        make.right.mas_equalTo(-10);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(110);
        make.left.top.bottom.mas_equalTo(bgView);
    }];
    
    [cartTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartImageView.mas_right);
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-20);
    }];
    
    [cartNatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartTitleLabel);
        make.top.mas_equalTo(cartTitleLabel.mas_bottom).mas_offset(6);
    }];
    
    [cartPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cartTitleLabel);
        make.top.mas_equalTo(cartNatureLabel.mas_bottom).mas_offset(15);
    }];
    
    [plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
    
    [cartCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(plusBtn.mas_left);
        make.top.bottom.mas_equalTo(plusBtn);
        make.width.mas_equalTo(35);
    }];
    
    [reduceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(cartCountLabel.mas_left);
        make.top.bottom.mas_equalTo(plusBtn);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
    
}

- (void)selectBtnClick{
    self.selectBtn.selected = !self.selectBtn.selected;
    self.item.isSelect = self.selectBtn.selected;
    if (self.calculateCallBack) {
        self.calculateCallBack(self.cartCountLabel.text);
    }
}

- (void)plusBtnClick{
    int  num = [self.cartCountLabel.text intValue];
    num += 1;
    self.cartCountLabel.text = [NSString stringWithFormat:@"%d", num];
    if (self.calculateCallBack) {
        self.item.people_count = self.cartCountLabel.text;
        self.calculateCallBack(self.cartCountLabel.text);
    }
}

- (void)reduceBtnClick{
    int  num = [self.cartCountLabel.text intValue];
    num -=1;
    if (num <= 0) {
        return;
    } else {
        self.cartCountLabel.text = [NSString stringWithFormat:@"%d", num];
    }
    if (self.calculateCallBack) {
        self.item.people_count = self.cartCountLabel.text;
        self.calculateCallBack(self.cartCountLabel.text);
    }
}

- (void)setItem:(DCRecommendItem *)item{
    _item = item;
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:item.image_url] placeholderImage:nil];
    self.cartTitleLabel.text = item.goods_title;
    self.cartNatureLabel.text = item.nature;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
    self.cartCountLabel.text = item.people_count;
    self.selectBtn.selected = item.isSelect;
    
    [self.contentView sp_removeBottomLine];
    self.bgView.layer.cornerRadius = 0;
    switch (item.cellLocationType) {
        case PMCellLocationTypeSingle:{
            self.bgView.layer.cornerRadius = 5;
            self.bgView.clipsToBounds = YES;
        }
            break;
        case PMCellLocationTypeTop:{
            [self.contentView sp_addBottomLineWithLeftMargin:150 rightMargin:0];
        }
            break;
        case PMCellLocationTypeMiddle:{
            [self.contentView sp_addBottomLineWithLeftMargin:150 rightMargin:0];
        }
            break;
        case PMCellLocationTypeBottom:{
            
        }
            break;
        default:
            break;
    }
}
@end
