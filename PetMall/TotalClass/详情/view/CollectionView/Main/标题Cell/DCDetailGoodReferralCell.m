//
//  DCDetailGoodReferralCell.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCDetailGoodReferralCell.h"

// Controllers

// Models

// Views
#import "DCUpDownButton.h"
// Vendors

// Categories

// Others

@interface DCDetailGoodReferralCell ()

/* 自营 */
@property (strong , nonatomic)UIImageView *autotrophyImageView;
/* 分享按钮 */
@property (strong , nonatomic)DCUpDownButton *shareButton;

@end

@implementation DCDetailGoodReferralCell

#pragma mark - Intial
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
        
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    
    _autotrophyImageView = [[UIImageView alloc] init];
    [self addSubview:_autotrophyImageView];
    _autotrophyImageView.image = [UIImage imageNamed:@"detail_title_ziying_tag"];
    
    _goodTitleLabel = [[UILabel alloc] init];
    _goodTitleLabel.font = PFR16Font;
    _goodTitleLabel.numberOfLines = 0;
    [self addSubview:_goodTitleLabel];
    
    _goodPriceLabel = [[UILabel alloc] init];
    _goodPriceLabel.font = PFR20Font;
    _goodPriceLabel.textColor = [UIColor redColor];
    [self addSubview:_goodPriceLabel];
    
    _goodSubPriceLabel = [[UILabel alloc] init];
    _goodSubPriceLabel.font = PFR13Font;
    _goodSubPriceLabel.textColor = [UIColor grayColor];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"¥28" attributes:attribtDic];
    _goodSubPriceLabel.attributedText = attribtStr;
    [self addSubview:_goodSubPriceLabel];

    _shouHuoCount = [[UILabel alloc] init];
    _shouHuoCount.font = PFR14Font;
    _shouHuoCount.textColor = [UIColor grayColor];
    _shouHuoCount.text = @"8万人收货";
    [self addSubview:_shouHuoCount];

    
    _goodSubtitleLabel = [[UILabel alloc] init];
    _goodSubtitleLabel.text = @"优惠7.2元";
    _goodSubtitleLabel.font = PFR10Font;
    _goodSubtitleLabel.numberOfLines = 0;
    _goodSubtitleLabel.textAlignment = NSTextAlignmentCenter;
    _goodSubtitleLabel.textColor = RGB(233, 35, 46);
    [self addSubview:_goodSubtitleLabel];
    _goodSubtitleLabel.layer.borderColor =  RGB(233, 35, 46).CGColor;
    _goodSubtitleLabel.layer.borderWidth = 0.5f;
    _goodSubtitleLabel.layer.cornerRadius = 5.f;
    _goodSubtitleLabel.clipsToBounds = YES;
//    _shareButton = [DCUpDownButton buttonWithType:UIButtonTypeCustom];
//    [_shareButton setTitle:@"分享" forState:0];
//    [_shareButton setImage:[UIImage imageNamed:@"icon_fenxiang2"] forState:0];
//    [_shareButton setTitleColor:[UIColor blackColor] forState:0];
//    _shareButton.titleLabel.font = PFR10Font;
//    [self addSubview:_shareButton];
//    [_shareButton addTarget:self action:@selector(shareButtonClick) forControlEvents:UIControlEventTouchUpInside];
//
    
    
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_autotrophyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    [_goodTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.top.mas_equalTo(_goodPriceLabel.mas_bottom).mas_offset(10);
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
    }];

    
//    [_goodSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(_autotrophyImageView);
//        [make.right.mas_equalTo(self)setOffset:-DCMargin * 5];
//        [make.top.mas_equalTo(_goodTitleLabel.mas_bottom)setOffset:DCMargin];
//    }];
    
    [_goodPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodTitleLabel);
        make.top.mas_equalTo(DCMargin);
    }];
    
    [_goodSubPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodPriceLabel.mas_right).mas_offset(10);
        make.bottom.mas_equalTo(_goodPriceLabel);

    }];
    
    [_shouHuoCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_goodPriceLabel);
        make.right.mas_equalTo(-DCMargin);
    }];
    
    [_shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
        [make.top.mas_equalTo(self)setOffset:DCMargin];
    }];
    
    //获取UILabel上最后一个字符串的位置。
    CGPoint lastPoint;
    CGSize sz = [_goodTitleLabel.text sizeWithFont:_goodTitleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 40)];
    
    CGSize linesSz = [_goodTitleLabel.text sizeWithFont:_goodTitleLabel.font constrainedToSize:CGSizeMake(kMainBoundsWidth - 2*DCMargin, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    if(sz.width <= linesSz.width) //判断是否折行
    {
        if (sz.width + 60 > kMainBoundsWidth - 2 * DCMargin) {
            lastPoint = CGPointMake(0 , sz.height + 48);
        }else{
            lastPoint = CGPointMake(10 + sz.width, 48);
        }
    }
    else
    {
        lastPoint = CGPointMake(10 + (int)sz.width % (int)linesSz.width,linesSz.height - sz.height + 48);
    }

    _goodSubtitleLabel.frame = CGRectMake(lastPoint.x + 10, lastPoint.y + 3, 70, 16);
}


//#pragma mark - 分享按钮点击
//- (void)shareButtonClick
//{
//    !_shareButtonClickBlock ? : _shareButtonClickBlock();
//}

#pragma mark - Setter Getter Methods


@end
