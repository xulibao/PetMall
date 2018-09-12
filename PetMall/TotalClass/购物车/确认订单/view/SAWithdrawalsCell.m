//
//  SAWithdrawalsCell.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/26.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAWithdrawalsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface SAWithdrawalsCell()

@property (nonatomic,strong) UIImageView * leftImageView;

@property (nonatomic,strong) UILabel * topLabel;

@property (nonatomic,strong) UILabel * bottomLabel;

@property (nonatomic,strong) UIButton * rightSelectBtn;

@end

@implementation SAWithdrawalsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView * leftImageView = [[UIImageView alloc] init];
        self.leftImageView = leftImageView;
        [self.contentView addSubview:leftImageView];
        
        UILabel * topLabel = [[UILabel alloc] init];
        self.topLabel = topLabel;
        topLabel.textColor = kColor999999;
        topLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:topLabel];
        
//        UILabel * bottomLabel = [[UILabel alloc] init];
//        self.bottomLabel = bottomLabel;
//        bottomLabel.textColor = kColorTextBlack;
//        bottomLabel.font = [UIFont systemFontOfSize:18];
//        [self.contentView addSubview:bottomLabel];
        
        UIButton *rightSelectBtn = [[UIButton alloc] init];
//        rightSelectBtn.enabled = NO;
        self.rightSelectBtn = rightSelectBtn;
        [rightSelectBtn setImage:IMAGE(@"cart_yuanquan") forState:UIControlStateNormal];
        [rightSelectBtn setImage:IMAGE(@"cart_yuanquan_selected") forState:UIControlStateSelected];
        [self.contentView addSubview:rightSelectBtn];

        [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(leftImageView.mas_right).mas_offset(15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
//        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(topLabel.mas_bottom).mas_offset(10);
//            make.left.mas_equalTo(topLabel);
//            make.bottom.mas_equalTo(self.contentView).mas_offset(-10);
//        }];
        
        [rightSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-15);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self sp_addBottomLineWithLeftMargin:15 rightMargin:0];
    }
    return self;
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(SAWithdrawalsModel *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.leftImageView.image = IMAGE(data.bankLogo);
    self.topLabel.text = data.bankName;
//    self.bottomLabel.text = data.bankAccount;
    self.rightSelectBtn.selected = data.isSelect;
}


@end
