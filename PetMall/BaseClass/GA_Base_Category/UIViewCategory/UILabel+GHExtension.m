//
//  UILabel+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/22.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "UILabel+GHExtension.h"
#import "UIColor+GHExtension.h"
#import "UIView+GHExtension.h"
@implementation UILabel (GHExtension)
+ (UILabel *)creatLable:(CGRect)frame andWithString:(NSString *)name andFontNum:(CGFloat)num
{
    UILabel *lable=[[UILabel alloc]initWithFrame:frame];
    [lable setText:name];
    lable.backgroundColor=[UIColor clearColor];
    lable.lineBreakMode=NSLineBreakByWordWrapping;
    lable.numberOfLines= 0;
    lable.textAlignment=NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:num];
    lable.textColor = [UIColor colorWithHexStr:@"#444444"];
    return lable;
}

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    CGSize retSize = CGSizeZero;
        retSize = [self.text boundingRectWithSize:size
                                          options:\
                   NSStringDrawingTruncatesLastVisibleLine |
                   NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading
                                       attributes:attribute
                                          context:nil].size;
    
    return retSize;
}



- (CGSize)settingTheLineSpacingWith:(UILabel *)contentLabel andLineSpacing:(float)lineSpacing
{
    CGFloat Spacing = lineSpacing;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:contentLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:Spacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, contentLabel.text.length)];
    contentLabel.attributedText = attributedString;
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 500000);
    return [contentLabel sizeThatFits:size];
}

- (UILabel *)labelWithRange:(NSRange)range Color:(UIColor *)color andText:(NSString *)text font:(UIFont *)font
{
    self.font = font;
    self.textColor = [UIColor colorWithHexStr:@"#333333"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:text];
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = str;
    self.size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    return self;
}


/** 字体颜色 */
- (UILabel *)labelColorfulStringWithText1:(NSString *)text1 Color1:(UIColor *)color1 Font1:(UIFont *)font1 Text2:(NSString *)text2 Color2:(UIColor *)color2 Font2:(UIFont *)font2 AllText:(NSString *)allText
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allText];
    [str beginEditing];
    if (text1) {
        NSRange range1 = [allText rangeOfString:text1];
        [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color1 range:range1];
        if (font1) {
            [str addAttribute:NSFontAttributeName value:font1 range:range1];
        }
    }
    
    if (text2) {
        NSRange range2 = [allText rangeOfString:text2];
        [str addAttribute:(NSString *)(NSForegroundColorAttributeName) value:color2 range:range2];
        if (font2) {
            [str addAttribute:NSFontAttributeName value:font2 range:range2];
        }
    }
    [str endEditing];
    self.attributedText = str;
    return self;
}
// 设置行距
- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing {
    if (lineSpacing < 0.01 || !text) {
        self.text = text;
        return;
    }
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, [text length])];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:lineSpacing];
        [paragraphStyle setLineBreakMode:self.lineBreakMode];
        [paragraphStyle setAlignment:self.textAlignment];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        self.attributedText = attributedString;
}

// 计算行高
+ (CGFloat)textHeight:(NSString*)text heightWithFontSize:(CGFloat)fontSize width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing {
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, MAXFLOAT)];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label setText:text lineSpacing:lineSpacing];
    [label sizeToFit];
    return label.height;
}
@end
