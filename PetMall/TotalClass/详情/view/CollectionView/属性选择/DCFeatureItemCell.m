//
//  DCFeatureItemCell.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCFeatureItemCell.h"

// Controllers

// Models
#import "DCFeatureItem.h"
#import "DCFeatureList.h"
// Views

// Vendors

// Categories

// Others

@interface DCFeatureItemCell ()

/* 属性 */
@property (strong , nonatomic)UILabel *attLabel;

@end

@implementation DCFeatureItemCell

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
    _attLabel = [[UILabel alloc] init];
    _attLabel.textAlignment = NSTextAlignmentCenter;
    _attLabel.font = PFR13Font;
    _attLabel.layer.cornerRadius = 15;
    _attLabel.layer.borderWidth = 0.5;
    _attLabel.clipsToBounds = YES;
    [self addSubview:_attLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_attLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}


#pragma mark - Setter Getter Methods

- (void)setContent:(PMGoodDetailSpecificationModel *)content{
    _content = content;
    _attLabel.text = content.last;
    
    if (content.isSelect) {
        _attLabel.textColor = kColorFF3945;
        _attLabel.layer.borderColor = kColorFF3945.CGColor;
     
    }else{
        _attLabel.textColor = [UIColor blackColor];
        _attLabel.layer.borderColor = kColor999999.CGColor;
    }
}

@end
