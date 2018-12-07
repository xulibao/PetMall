//
//  PMGoodsCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMGoodsCell.h"

#import <UIImageView+WebCache.h>

@interface PMGoodsCell ()
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

/* 相同 */
@property (strong , nonatomic)UIButton *rightButton;

@end
@implementation PMGoodsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMGoodsItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.item = data;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",data.selling_price];
    _originLabel.text = [NSString stringWithFormat:@"%@人收货",data.package_sale];
    _peopleCountLabel.text = [NSString stringWithFormat:@"%@条评价 %@%%好评",data.package_pl,data.package_ok];
    _goodsLabel.text = data.goods_title;
    
    
}
- (void)initViews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = [UIFont systemFontOfSize:16];
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_priceLabel];
    
    _originLabel = [[UILabel alloc] init];
    _originLabel.textColor = kColor999999;
    _originLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_originLabel];
    
    _peopleCountLabel = [[UILabel alloc] init];
    _peopleCountLabel.textColor = kColor999999;
    _peopleCountLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_peopleCountLabel];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setImage:IMAGE(@"cart_add") forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(addCartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexStr:@"#FAFAFA"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(35);
        make.bottom.mas_offset(-24);
        make.left.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(54 , 93));
        
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImageView.mas_right).mas_offset(50);
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
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.contentView)setOffset:-15];
        make.top.mas_equalTo(self.priceLabel).mas_offset(4);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
}

- (void)addCartClick{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidAddCart:)]) {
        [self.cellDelegate cellDidAddCart:self.item];
    }
    
}

@end
