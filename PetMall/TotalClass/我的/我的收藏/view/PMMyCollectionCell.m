//
//  PMMyExchangeCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/27.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMMyCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface PMMyCollectionCell ()
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

@property(nonatomic, strong) PMMyCollectionItem *data;
@end
@implementation PMMyCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMMyCollectionItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.data = data;
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo]];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",data.market_price];

    _originLabel.text = data.time;
    //    _peopleCountLabel.text = [NSString stringWithFormat:@"已%@人参团",data.people_count];
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
    _peopleCountLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _peopleCountLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_peopleCountLabel];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightButton setImage:IMAGE(@"mine_collection_delete") forState:UIControlStateNormal];
    [_rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_rightButton];
    UIView * lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexStr:@"#FAFAFA"];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(5);
        make.left.right.top.mas_equalTo(self.contentView);
    }];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).mas_offset(35);
        make.bottom.mas_offset(-24);
        make.left.mas_equalTo(50);
        make.size.mas_equalTo(CGSizeMake(54 , 93));
    }];
    
    [self.goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsImageView.mas_right).mas_offset(50);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.goodsLabel); make.top.mas_equalTo(self.goodsLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(15);
    }];
    
    [self.peopleCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel); make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(5);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self.contentView)setOffset:-15];
        make.bottom.mas_equalTo(self.originLabel);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}

- (void)rightButtonClick{
    if ([self.cellDelegate respondsToSelector:@selector(cellDidClickDeleteCollection:)]) {
        [self.cellDelegate cellDidClickDeleteCollection:self.data];
    }
}
@end
