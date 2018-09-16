//
//  PMMyCouponCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCouponCell.h"
#import "PMMyCouponItem.h"

@interface PMMyCouponCell()

@property(nonatomic, strong) UIImageView *bgView;
@property(nonatomic, strong) UILabel *priceLabel;

@end

@implementation PMMyCouponCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}
- (void)initViews{
    UIImageView * bgView = [[UIImageView alloc] init];
    bgView.contentMode = UIViewContentModeScaleToFill;
    self.bgView = bgView;
    [self.contentView addSubview:bgView];
    
    
    UILabel * priceLabel = [[UILabel alloc] init];
    self.priceLabel = priceLabel;
    priceLabel.font = [UIFont systemFontOfSize:30];
    priceLabel.textColor = [UIColor whiteColor];
    [self.bgView addSubview:priceLabel];
    
    UILabel * conditionsLabel = [[UILabel alloc] init];
    conditionsLabel.text = @"满100元可用";
    conditionsLabel.textColor = [UIColor whiteColor];
    conditionsLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:conditionsLabel];
    
    UILabel * voucherTitleLabel = [[UILabel alloc] init];
    voucherTitleLabel.text = @"全品类满减券";
    voucherTitleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.bgView addSubview:voucherTitleLabel];
    
    UILabel * voucherTimeLabel = [[UILabel alloc] init];
    voucherTimeLabel.text = @"2018-07-21至2018-07-30";
    voucherTimeLabel.font = [UIFont systemFontOfSize:13];
    [self.bgView addSubview:voucherTimeLabel];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(105);
        make.bottom.mas_equalTo(-2);
        make.top.mas_equalTo(2);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(-(kMainBoundsWidth - 20 - 130) * 0.5);
        make.top.mas_equalTo(20);
    }];
    
    
    [conditionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(priceLabel);
        make.bottom.mas_equalTo(-15);
    }];
    
    [voucherTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(145);
        make.top.mas_equalTo(15);
    }];
    
    [voucherTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(voucherTitleLabel);
        make.bottom.mas_equalTo(-20);
    }];
}
- (void)tableView:(UITableView *)tableView configViewWithData:(PMMyCouponItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@", data.price];
    switch (data.type) {
        case PMMyCouponType_notUsed:{
            self.bgView.image = IMAGE(@"oder_voucherBg");
        }
            break;
        case PMMyCouponType_Used:{
            self.bgView.image = IMAGE(@"mine_coupon_used");
        }
            break;
        case PMMyCouponType_Expired:{
            self.bgView.image = IMAGE(@"mine_coupon_guoqi");
        }
            break;
        default:
            break;
    }
    
}
@end
