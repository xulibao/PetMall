//
//  DCYouLikeHeadView.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCYouLikeHeadView.h"
#import "DCZuoWenRightButton.h"

@interface DCYouLikeHeadView ()
@property(nonatomic, strong) DCZuoWenRightButton * moreBtn;
@end

@implementation DCYouLikeHeadView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    UIView * redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor colorWithHexStr:@"#FF3945"];
    [self addSubview:redView];

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
    [self addSubview:_titleLabel];
    
    DCZuoWenRightButton * moreBtn = [DCZuoWenRightButton buttonWithType:UIButtonTypeCustom];
    self.moreBtn = moreBtn;
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [moreBtn setImage:[UIImage imageNamed:@"home_youjiantou"] forState:UIControlStateNormal];
    [moreBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [moreBtn setTitle:@"更多" forState:UIControlStateNormal];
    [self addSubview:moreBtn];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(2, 20));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redView.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(redView);
    }];
    
//    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self);
//        make.right.mas_equalTo(-15);
//    }];
    
    moreBtn.frame =  CGRectMake(self.width - 55, 0, 55, self.height);
    
}

- (void)setType:(PMHeaderDetailType)type{
    _type = type;
    switch (type) {
        case PMHeaderDetailTypeMore:{
            
        }
            break;
        case PMHeaderDetailTypeCountDown:{
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - Setter Getter Methods


@end
