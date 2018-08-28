//
//  UIColor+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GHExtension)
// 哈希颜色0X开头,#开头均可以
+ (UIColor *)colorWithHexStr:(NSString *)stringToConvert;
// 随机颜色
+ (UIColor *)randomColor;
// 哈希颜色0X开头,#开头均可以
+ (UIColor *)colorWithHexStr:(NSString *)stringToConvert alpha:(CGFloat)alpha;
@end


