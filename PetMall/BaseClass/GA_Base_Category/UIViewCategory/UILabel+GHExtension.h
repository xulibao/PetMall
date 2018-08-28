//
//  UILabel+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/22.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (GHExtension)
// 快速创建
+ (UILabel *)creatLable:(CGRect)frame andWithString:(NSString *)name andFontNum:(CGFloat)num;

- (UILabel *)labelWithRange:(NSRange)range Color:(UIColor *)color andText:(NSString *)text font:(UIFont *)font;

// size
- (CGSize)boundingRectWithSize:(CGSize)size;
/** 未测试,慎用! */
- (CGSize)settingTheLineSpacingWith:(UILabel *)contentLabel andLineSpacing:(float)lineSpacing;

/** 字体颜色 */
- (UILabel *)labelColorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText;

/** 设置行距   使用：[label setText:text lineSpacing:2.0f];*/
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

// 计算行高
+ (CGFloat)textHeight:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;
@end
