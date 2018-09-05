//
//  DCGoodsHandheldCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsHandheldCell.h"

// Controllers

// Models

// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories

// Others

@interface DCGoodsHandheldCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *handheldImageView;

@end

@implementation DCGoodsHandheldCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

#pragma mark - UI
- (void)setUpUI
{
    _handheldImageView = [[UIImageView alloc] init];
    _handheldImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_handheldImageView];
    
    
    UIImageView * hengfuImage = [[UIImageView alloc] init];
    hengfuImage.image = IMAGE(@"home_hengfu");
    hengfuImage.contentMode = UIViewContentModeScaleToFill;
    [_handheldImageView addSubview:hengfuImage];
    
    
    UILabel * label  = [[UILabel alloc] init];
    label.text = @"距离开售还有 01 天";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    [hengfuImage addSubview:label];

    [_handheldImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(175);
    }];
    
    [hengfuImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_handheldImageView);
        make.top.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(122, 20));
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(hengfuImage);
    }];
}


#pragma mark - Setter Getter Methods
- (void)setHandheldImage:(NSString *)handheldImage
{
    _handheldImage = handheldImage;
    [_handheldImageView sd_setImageWithURL:[NSURL URLWithString:handheldImage]];
}

@end
