//
//  SPCodeForgotCell.m
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/15.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "SPCodeForgotCell.h"

@interface SPCodeForgotCell()

@property(nonatomic, strong) UILabel * bottomLabel;
@property(nonatomic, strong) UILabel *topLabel;
@property(nonatomic, strong) SPCodeForgotModel *model;

@end

@implementation SPCodeForgotCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self fecthSubViews];
    }
    return self;
}
- (void)fecthSubViews{
    
    UIView * topView = [[UIView alloc] init];
    topView.userInteractionEnabled = YES;
    topView.backgroundColor = kColorBackground;
    [self.contentView addSubview:topView];
    [topView handleTapActionWithBlock:^(UIView *sender) {
        if ([self.cellDelegate respondsToSelector:@selector(cellDidClickCodeForgot:)]) {
            [self.cellDelegate cellDidClickCodeForgot:self.model];
        }
    }];
    UILabel *topLabel = [[UILabel alloc] init];
    self.topLabel = topLabel;
    topLabel.text = @"请选择所属公司";
    topLabel.textColor = kColorTextLight;
    topLabel.font = [UIFont systemFontOfSize:15];
    [topView addSubview:topLabel];
    
    UIImageView * imageView = [[UIImageView alloc] init];
    imageView.image = IMAGE(@"home_arrow");
    [topView addSubview:imageView];
    
    UILabel * bottomLabel = [[UILabel alloc] init];
    bottomLabel.backgroundColor = [UIColor clearColor];
    bottomLabel.textColor = kColorTextGay;
    bottomLabel.font = [UIFont systemFontOfSize:14];
    self.bottomLabel = bottomLabel;
    bottomLabel.text = @"动态验证码将发送到手机号：157****5023";
   
    [self.contentView addSubview:bottomLabel];
    
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(15);
    }];
    
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(topView);
    }];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(topView).mas_offset(-10);
        make.centerY.mas_equalTo(topView);
    }];
    
   
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(topView);
        make.centerY.mas_equalTo(topView).mas_offset(45);
    }];
    
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(UI_SCREEN_WIDTH, 105);
}


#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(SPCodeForgotModel *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.model = data;
//    self.topLabel.text = data.companyName ? data.companyName :@"请选择所属公司";
    self.topLabel.textColor = data.companyName ? kColorTextBlack:kColorTextLight;
  
}
@end
