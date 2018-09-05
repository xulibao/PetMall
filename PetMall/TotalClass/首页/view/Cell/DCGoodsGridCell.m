//
//  DCGoodsGridCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsGridCell.h"

// Controllers

// Models
#import "DCGridItem.h"
// Views

// Vendors
#import <UIImageView+WebCache.h>
// Categories
#import "UIView+DCRolling.h"
//#import "UIColor+DCColorChange.h"
// Others

@interface DCGoodsGridCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;
/* tagLabel */
@property (strong , nonatomic)UILabel *tagLabel;

@end

@implementation DCGoodsGridCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];

    }
    return self;
}

- (void)setUpUI
{
    _gridImageView = [[UIImageView alloc] init];
//    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = [UIFont systemFontOfSize:12];
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
//
//    _tagLabel = [[UILabel alloc] init];
//    _tagLabel.font = [UIFont systemFontOfSize:8];
//    _tagLabel.backgroundColor = [UIColor whiteColor];
//    _tagLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_tagLabel];
    
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.top.mas_equalTo(self)setOffset:10];
        make.centerX.mas_equalTo(self);
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        [make.top.mas_equalTo(self.gridImageView.mas_bottom)setOffset:5];
    }];

}


#pragma mark - Setter Getter Methods
- (void)setGridItem:(DCGridItem *)gridItem
{
    _gridItem = gridItem;
    _gridLabel.text = gridItem.gridTitle;

    if (_gridItem.iconImage.length == 0) return;
    if ([[_gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:_gridItem.iconImage];
    }
}

@end
