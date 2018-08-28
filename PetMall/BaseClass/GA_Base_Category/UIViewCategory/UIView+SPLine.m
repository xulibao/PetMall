//
//  UIView+SPLine.m
//  GA_Base_Category
//
//  Created by GhGh on 2016/12/12.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "UIView+SPLine.h"
#import <objc/runtime.h>
#import "Masonry.h"

#define SP_lineWidth 1.0/[UIScreen mainScreen].scale
static char const *kSPTopLineKey;
static char const *kSPBottomLineKey;

static char const *kSPHorizontalMiddleLineKey;
static char const *kSPHorizontalTopLineKey;
static char const *kSPHorizontalBottomLineKey;

static char const *kSPVerticalMiddleLineKey;
static char const *kSPVerticalHeadLineKey;
static char const *kSPVerticalTailLineKey;
@implementation UIView (SPLine)
+ (instancetype)sp_line {
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, 0, [self lineWidth], [self lineWidth]);
    line.backgroundColor = [self colorWithHexStr:@"#d3d3d3"];
    return line;
}
+ (CGFloat)lineWidth {
    return 1.0/[UIScreen mainScreen].scale;
}

#pragma mark - Bottom line.

- (UIView *)sp_addBottomLineWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPBottomLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addBottomLineWithLeftMargin:(CGFloat)leftMargin
                               rightMargin:(CGFloat)rightMargin
                                 lineColor:(UIColor *)color {
    UIView *line = [self sp_getCellLineByKey:&kSPBottomLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    line.backgroundColor = color;
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (void)sp_removeBottomLine {
    UIView *line = [self sp_getCellLineByKey:&kSPBottomLineKey];
    [line removeFromSuperview];
}


#pragma mark - Top line.

- (UIView *)sp_addTopLineWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPTopLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addTopLineWithLeftMargin:(CGFloat)leftMargin
                            rightOffset:(CGFloat)rightMargin
                              lineColor:(UIColor *)color {
    UIView *line = [self sp_getCellLineByKey:&kSPTopLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    line.backgroundColor = color;
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (void)sp_removeTopLine {
    UIView *line = [self sp_getCellLineByKey:&kSPTopLineKey];
    [line removeFromSuperview];
}


#pragma mark - Horizontal middle line.

- (UIView *)sp_addHorizontalTopLineWithLeftMargin:(CGFloat)leftMargin
                                      rightMargin:(CGFloat)rightMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalTopLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.width.equalTo(self.mas_height).with.offset(-leftMargin-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addHorizontalMiddleLineWithLeftMargin:(CGFloat)leftMargin
                                         rightMargin:(CGFloat)rightMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalMiddleLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.right.equalTo(self).with.offset(-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addHorizontalBottomLineWithLeftMargin:(CGFloat)leftMargin
                                         rightMargin:(CGFloat)rightMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalBottomLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(leftMargin);
        make.width.equalTo(self.mas_height).with.offset(-leftMargin-rightMargin);
        make.height.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (void)sp_removeHorizontalMiddleLine {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalMiddleLineKey];
    [line removeFromSuperview];
}

- (void)sp_removeHorizontalTopLine {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalTopLineKey];
    [line removeFromSuperview];
}

- (void)sp_removeHorizontalBottomLine {
    UIView *line = [self sp_getCellLineByKey:&kSPHorizontalBottomLineKey];
    [line removeFromSuperview];
}


#pragma mark - Vertical middle line.

- (UIView *)sp_addVerticalHeadLineWithTopMargin:(CGFloat)topMargin
                                   bottomMargin:(CGFloat)bottomMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalHeadLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).with.offset(topMargin);
        make.height.equalTo(self.mas_height).with.offset(-bottomMargin-topMargin);
        make.width.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addVerticalMiddleLineWithTopMargin:(CGFloat)topMargin
                                     bottomMargin:(CGFloat)bottomMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalMiddleLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(topMargin);
        make.height.equalTo(self.mas_height).with.offset(-bottomMargin-topMargin);
        make.width.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (UIView *)sp_addVerticalTailLineWithTopMargin:(CGFloat)topMargin
                                   bottomMargin:(CGFloat)bottomMargin {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalTailLineKey];
    [line removeFromSuperview];
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self).with.offset(topMargin);
        make.height.equalTo(self.mas_height).with.offset(-bottomMargin-topMargin);
        make.width.equalTo(@(SP_lineWidth));
    }];
    
    return line;
}

- (void)sp_removeVerticalMiddleLine {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalMiddleLineKey];
    [line removeFromSuperview];
}

- (void)sp_removeVerticalHeadLine {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalHeadLineKey];
    [line removeFromSuperview];
}

- (void)sp_removeVerticalTailLine {
    UIView *line = [self sp_getCellLineByKey:&kSPVerticalTailLineKey];
    [line removeFromSuperview];
}


#pragma mark - Private methods.

- (UIView *)sp_getCellLineByKey:(void *)key {
    UIView *line = objc_getAssociatedObject(self, key);
    if (!line) {
        line = [UIView sp_line];
        objc_setAssociatedObject(self, key, line, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return line;
}


#pragma mark - 颜色
+ (UIColor *)colorWithHexStr:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor whiteColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor whiteColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}
@end
