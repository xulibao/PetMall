//
//  DCCommentHeaderCell.m
//  CDDMall
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCCommentHeaderView.h"

// Controllers

// Models

// Views

// Vendors

// Categories

// Others

@interface DCCommentHeaderView ()

/* 指示按钮 */
@property (strong , nonatomic)UIButton *indicateButton;

/* 评价数量 */
@property (strong , nonatomic)UILabel *commentNumLabel;
/* 好评比 */
@property (strong , nonatomic)UILabel *goodCommentPLabel;

@end

@implementation DCCommentHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    self.backgroundColor = [UIColor whiteColor];
    
    _commentNumLabel = [[UILabel alloc] init];
    _commentNumLabel.font = PFR16Font;
    [self addSubview:_commentNumLabel];

    _indicateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_indicateButton setImage:[UIImage imageNamed:@"home_youjiantou"] forState:UIControlStateNormal];
    [self addSubview:_indicateButton];
    
    _goodCommentPLabel = [[UILabel alloc] init];
    _goodCommentPLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
    _goodCommentPLabel.font = PFR15Font;
    [self addSubview:_goodCommentPLabel];
    
    [self handleTapActionWithBlock:^(UIView *sender) {
        if (self.callBack) {
            self.callBack();
        }
        
    }];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(self)setOffset:DCMargin];
        make.centerY.mas_equalTo(self);
    }];
    
    [_indicateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(self)setOffset:-DCMargin];
//        make.size.mas_equalTo(CGSizeMake(25, 15));
        make.centerY.mas_equalTo(self);
    }];
    
    [_goodCommentPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.right.mas_equalTo(_indicateButton.mas_left)setOffset:-6];
        make.centerY.mas_equalTo(self);
    }];
    
}

#pragma mark - Setter Getter Methods
- (void)setComNum:(NSString *)comNum
{
    _comNum = comNum;
    _commentNumLabel.text = [NSString stringWithFormat:@"商品评价(%@)",comNum];
}


- (void)setWellPer:(NSString *)wellPer
{
    _wellPer = wellPer;
    _goodCommentPLabel.text = [NSString stringWithFormat:@"好评：%@%%",wellPer];
 
}
@end
