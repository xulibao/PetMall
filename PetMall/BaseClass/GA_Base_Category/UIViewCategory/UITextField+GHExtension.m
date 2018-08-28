//
//  UITextField+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "UITextField+GHExtension.h"

@implementation UITextField (GHExtension)
/** 通过这个属性名，就可以修改textField内部的占位文字颜色 */
static NSString * const GAPlaceholderColorKeyPath = @"placeholderLabel.textColor";

// 不自动纠错，防止用户输入的ab的时候出现aa情况
- (UITextAutocorrectionType)autocorrectionType
{
    return UITextAutocorrectionTypeNo;
}
+ (UITextField *)creatTextFieldFrame:(CGRect)frame andPlaceTitle:(NSString *)placeTitle
{
    UITextField *textField=[[UITextField alloc]initWithFrame:frame];
    textField.placeholder = placeTitle;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.clearsOnBeginEditing = YES;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    return textField;
}


/**
 *  设置占位文字颜色
 */
- (void)setGa_placeholderColor:(UIColor *)ga_placeholderColor
{
    // 这3行代码的作用：1> 保证创建出placeholderLabel，2> 保留曾经设置过的占位文字
    NSString *placeholder = self.placeholder;
    self.placeholder = @" ";
    self.placeholder = placeholder;
    
    // 处理ga_placeholderColor为nil的情况：如果是nil，恢复成默认的占位文字颜色
    if (ga_placeholderColor == nil) {
        ga_placeholderColor = [UIColor colorWithRed:0 green:0 blue:0.0980392 alpha:0.22];
    }
    
    // 设置占位文字颜色
    [self setValue:ga_placeholderColor forKeyPath:GAPlaceholderColorKeyPath];
}

/**
 *  获得占位文字颜色
 */
- (UIColor *)ga_placeholderColor
{
    return [self valueForKeyPath:GAPlaceholderColorKeyPath];
}

@end
