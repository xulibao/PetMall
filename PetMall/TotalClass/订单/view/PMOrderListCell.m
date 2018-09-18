//
//  SAOrderListCell.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "PMOrderListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SATruckInfoBaseBottomView.h"
#import "SATruckInfoBaseTopView.h"
#import "NSAttributedString+STAttributedString.h"
@interface PMOrderListCell ()
@property(nonatomic, strong) SATruckInfoBaseTopView *topView;
@property(nonatomic, strong) SATruckInfoBaseBottomView *bottomView;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;

@end

@implementation PMOrderListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMOrderListItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    NSString *text0;
    if (data.orderNo) {
        text0 = [@"订单编号：" stringByAppendingString:data.orderNo];
    }
    
    self.topView.attStr_label0 = [text0 attributedStingWithAttributes:nil];
    self.topView.attStr_label1 = [data.statusText attributedStingWithAttributes:nil];
    _bottomView.tags = data.tagsText;
    _bottomView.tagBtnClick = ^(NSInteger tag) {
        if ([self.cellDelegate respondsToSelector:@selector(PMOrderListCellClick)]) {
            [self.cellDelegate PMOrderListCellClick];
        }
    };
    _bottomView.label0.text = @"共一件商品 合计：¥158";
//    [_bottomView setNeedsLayout];
    
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:data.image_url] placeholderImage:nil];
    self.cartTitleLabel.text = data.goods_title;
    self.cartNatureLabel.text = data.nature;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",data.price];
    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",data.people_count];
}
- (void)initViews{
    self.contentView.backgroundColor = [UIColor colorWithHexStr:@"#f2f2f2"];
    _topView = [[SATruckInfoBaseTopView alloc] init];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_topView];
    
    _bottomView = [[SATruckInfoBaseBottomView alloc] init];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bottomView];
    
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
    
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(40);
    }];
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(-10);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(95);
    }];
    
    [cartImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.left.mas_equalTo(bgView).mas_offset(10);
        make.centerY.mas_equalTo(bgView);
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



@end
