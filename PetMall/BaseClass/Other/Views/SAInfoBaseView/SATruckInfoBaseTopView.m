//
//  SATruckInfoBaseTopView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SATruckInfoBaseTopView.h"
#import "SATruckInfoConstValue.h"
@interface SATruckInfoBaseTopView()

@property (nonatomic,strong) UILabel *label0;
@property (nonatomic,strong) UILabel *label1;

@end

@implementation SATruckInfoBaseTopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializationSubViews];
    }
    return self;
}

- (void)initializationSubViews{
    
    UILabel  *label0 = [[UILabel alloc] init];
    label0.textColor = kColorTextGay;
    label0.font = UIFontMake(13);
    label0.text = @"订单编号：201802201234";
    self.label0 = label0;
    [self addSubview:label0];
    
    UILabel  *label1 = [[UILabel alloc] init];
    label1.textColor = kColor999999;
    label1.font = UIFontMake(13);
    label1.text = @"已失败";
    self.label1 = label1;
    [self addSubview:label1];

}

- (void)setAttStr_label0:(NSAttributedString *)attStr_label0{
    _attStr_label0 = attStr_label0;
    self.label0.attributedText = attStr_label0;
    [self setNeedsLayout];
}

- (void)setAttStr_label1:(NSAttributedString *)attStr_label1{
    _attStr_label1 = attStr_label1;
    self.label1.attributedText = attStr_label1;
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label0 sizeToFit];
    [self.label0 setFrame:(CGRect){k_padding_15,(self.height-self.label0.height)/2,self.label0.bounds.size}];
    
    [self.label1 sizeToFit];
    [self.label1 setFrame:(CGRect){CGRectGetWidth(self.frame) - self.label1.bounds.size.width - k_padding_15,(self.height-self.label1.height)/2,self.label1.bounds.size}];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = size;
    resultSize.height = 40;
    return resultSize;
}

@end
