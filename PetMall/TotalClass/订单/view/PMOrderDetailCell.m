//
//  PMOrderDetailCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailCell.h"
#import "SAAlertController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SATruckInfoBaseBottomView.h"

#import "NSAttributedString+STAttributedString.h"
@interface PMOrderDetailCell ()
@property(nonatomic, strong) SATruckInfoBaseBottomView *bottomView;

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;
@property(nonatomic, strong) UILabel *bottomLabel;


@end

@implementation PMOrderDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initViews];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(PMOrderDetailGoodsItem *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    NSString *text0;
//    if (data.order_id) {
//        text0 = [@"订单编号：" stringByAppendingString:data.orderNo];
//    }
    _bottomView.backgroundColor = kColorEEEEEE;
//    _bottomView.tags = data.tagsText;
    NSString * bottomStr = [NSString stringWithFormat:@"运费：+%@\n实付款：¥%.2f",data.postage,[data.pay_price floatValue] + [data.postage floatValue]];
    NSMutableAttributedString * bottomAttStr = [[NSMutableAttributedString alloc] initWithString:bottomStr];
    [bottomAttStr addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexStr:@"#FF3945"]} range:[bottomStr rangeOfString:[NSString stringWithFormat:@"¥%@",data.pay_price]]];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    
    [bottomAttStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [bottomStr length])];
    
    self.bottomLabel.attributedText = bottomAttStr;
    _bottomView.label0.attributedText = nil;
    
    [self.cartImageView sd_setImageWithURL:[NSURL URLWithString:data.goods_logo] placeholderImage:nil];
    self.cartTitleLabel.text = data.goods_title;
    self.cartNatureLabel.text = data.goods_spec;
    self.cartPriceLabel.text = [NSString stringWithFormat:@"¥%@",data.pay_price];
    self.cartCountLabel.text = [NSString stringWithFormat:@"x%@",@"1"];
}
- (void)initViews{
    self.contentView.backgroundColor = [UIColor whiteColor];;
    
    _bottomView = [[SATruckInfoBaseBottomView alloc] init];
    _bottomView.tagBtnClick = ^(NSInteger tag) {
                SAAlertController *alertController = [SAAlertController alertControllerWithTitle:nil
                                                                                         message:@"确定要申请退款吗？\n申请后系统将处理此订单"
                                                                                  preferredStyle:SAAlertControllerStyleAlert];
                SAAlertAction *action = [SAAlertAction actionWithTitle:@"申请" style:SAAlertActionStyleDefault handler:^(SAAlertAction *action) {
                    
                }];
                [alertController addAction:action];
                action = [SAAlertAction actionWithTitle:@"取消" style:SAAlertActionStyleCancel handler:^(SAAlertAction *action) {
                }];
        [alertController addAction:action];

                [alertController showWithAnimated:YES];
    };
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
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    self.bottomLabel = bottomLabel;
    bottomLabel.numberOfLines = 0;
    bottomLabel.font = [UIFont systemFontOfSize:12];
    bottomLabel.textColor = [UIColor colorWithHexStr:@"#999999"];
    bottomLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:bottomLabel];
    
    
    
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(40);
    }];
    
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.bottomView.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-12);

    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(10);
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
