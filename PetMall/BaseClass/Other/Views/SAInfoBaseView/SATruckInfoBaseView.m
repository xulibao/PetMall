//
//  SATruckInfoBaseView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SATruckInfoBaseView.h"
#import "SATruckInfoConstValue.h"
@interface SATruckInfoBaseView()

@end

@implementation SATruckInfoBaseView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializationSubViews];
    }
    return self;
}

- (void)initializationSubViews{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = kColorBG;
    self.imageView = imageView;
    [self addSubview:imageView];
    
    UILabel  *label0 = [[UILabel alloc] init];
    label0.textColor = kColorTextBlack;
    label0.font = UI_SCREEN_WIDTH > 320 ? UIFontMake(16) : UIFontMake(14);
    label0.numberOfLines = 0;
    label0.text = @"北京 中国重汽 HOKA 牵引车 580匹 6x4";
    self.label0 = label0;
    [self addSubview:label0];
    
    UILabel  *label1 = [[UILabel alloc] init];
    label1.textColor = kColor999999;
    label1.font = UI_SCREEN_WIDTH > 320 ? UIFontMake(12) : UIFontMake(10);
    label1.text = @"北京  2015年7月 ";
    self.label1 = label1;
    [self addSubview:label1];
    
    UILabel  *label2 = [[UILabel alloc] init];
    label2.textColor = kColorFF5554;
    label2.font = UI_SCREEN_WIDTH > 320 ? UIFontMake(18) : UIFontMake(15);
    label2.text = @"当前最高出价：25.9万";
    self.label2 = label2;
    [self addSubview:label2];
    
    UILabel  *label3 = [[UILabel alloc] init];
    label3.textAlignment = NSTextAlignmentCenter;
    label3.textColor = [UIColor whiteColor];
    label3.font = UI_SCREEN_WIDTH > 320 ? UIFontMake(12) : UIFontMake(10);
    label3.backgroundColor = kColorFF5554;
    label3.text = @"国三";
    self.label3 = label3;
    [imageView addSubview:label3];
    
    UILabel  *label4 = [[UILabel alloc] init];
    label4.textAlignment = NSTextAlignmentCenter;
    label4.font = UI_SCREEN_WIDTH > 320 ? UIFontMake(15) : UIFontMake(13);
    label4.text = @"等待中...";
    label4.textColor = [UIColor whiteColor];
    label4.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    self.label4 = label4;
    [imageView addSubview:label4];
    
}

- (void)setImageURLStr:(NSString *)imageURLStr{
    _imageURLStr = imageURLStr;
}

- (void)setAttStr_label0:(NSAttributedString *)attStr_label0{
    _attStr_label0 = attStr_label0;
    self.label0.attributedText = attStr_label0;
}

- (void)setAttStr_label1:(NSAttributedString *)attStr_label1{
    _attStr_label1 = attStr_label1;
    self.label1.attributedText = attStr_label1;
    
}

- (void)setAttStr_label2:(NSAttributedString *)attStr_label2{
    _attStr_label2 = attStr_label2;
    self.label2.attributedText = attStr_label2;
}

/*****Set*Frame****/
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.imageView setFrame:(CGRect){k_padding_15,k_padding_15,CGRectGetWidth(self.frame) * k_imageToSelfRatio_w,CGRectGetWidth(self.frame) * k_imageToSelfRatio_w * k_imageWRatio_H}];
    CGFloat fitWidth = CGRectGetWidth(self.frame)-CGRectGetMaxX(self.imageView.frame) - k_padding_10 - k_padding_15;
    
    CGSize size = CGSizeZero;

    if (self.label2.hidden || !self.label2.text || !self.label2.attributedText) {
        CGSize label0size = [self.label0 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        CGSize label1size = [self.label1 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        
        size = (CGSize){MAX(label0size.width, label1size.width), label0size.height + label1size.height};
        
        [self.label0 setFrame:(CGRect){CGRectGetMaxX(self.imageView.frame) + k_padding_10, CGRectGetMinY(self.imageView.frame) + (CGRectGetHeight(self.imageView.frame) - size.height) / 2, fmin(label0size.width, fitWidth), label0size.height}];
        
        size = [self.label1 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        [self.label1 setFrame:(CGRect){CGRectGetMaxX(self.imageView.frame) + k_padding_10, CGRectGetMaxY(self.label0.frame),fmin(label1size.width, fitWidth), label1size.height}];

    } else {
        size = [self.label0 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        [self.label0 setFrame:(CGRect){CGRectGetMaxX(self.imageView.frame) + k_padding_10, CGRectGetMinY(self.imageView.frame), fmin(size.width, fitWidth), size.height}];

        size = [self.label2 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        [self.label2 setFrame:(CGRect){CGRectGetMaxX(self.imageView.frame) + k_padding_10, CGRectGetMaxY(self.imageView.frame) - size.height, fitWidth, size.height}];
        
        size = [self.label1 sizeThatFits:(CGSize){fitWidth,CGFLOAT_MAX}];
        [self.label1 setFrame:(CGRect){CGRectGetMaxX(self.imageView.frame) + k_padding_10, (CGRectGetMaxY(self.imageView.frame) - self.label0.height - self.label2.height) / 2 + self.label0.height,fmin(size.width, fitWidth), size.height}];
    }
    
    
    size = [self.label3 sizeThatFits:(CGSize){CGFLOAT_MAX,CGFLOAT_MAX}];
    [self.label3 setFrame:(CGRect){0,0, MAX(30, size.width), 15}];
    
    CGFloat height = UI_SCREEN_WIDTH > 320 ? 25 : 20;
    [self.label4 setFrame:(CGRect){0,CGRectGetHeight(self.imageView.bounds) -  height,self.imageView.bounds.size.width,height}];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = size;
    
//    CGFloat resultWidth = k_padding_15 + size.width * k_imageToSelfRatio_w + k_padding_10;//imageWidth
//    CGSize label0size = [self.label0 sizeThatFits:(CGSize){size.width - resultWidth - k_padding_15,CGFLOAT_MAX}];
//    resultWidth += label0size.width;
//    resultWidth += k_padding_15;
    
    resultSize.width = size.width;
    
    CGFloat resultHeight = size.width * k_imageToSelfRatio_w * k_imageWRatio_H + k_padding_15 * 2;
    resultSize.height = resultHeight;//fmax(resultHeight, size.height);
    
    return resultSize;
}

@end
