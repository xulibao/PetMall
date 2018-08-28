//
//  UIView+SPLine.h
//  GA_Base_Category
//
//  Created by GhGh on 2016/12/12.
//  Copyright © 2016年 GhGh. All rights reserved.
//
// Split line  为分割线，简写SPLine
#import <UIKit/UIKit.h>

@interface UIView (SPLine)
+ (instancetype)sp_line;

- (UIView *)sp_addBottomLineWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;
// 默认颜色
- (UIView *)sp_addBottomLineWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin lineColor:(UIColor *)color;

- (UIView *)sp_addTopLineWithLeftMargin:(CGFloat)leftMargin rightMargin:(CGFloat)rightMargin;
// 默认颜色
- (UIView *)sp_addTopLineWithLeftMargin:(CGFloat)leftMargin rightOffset:(CGFloat)rightMargin lineColor:(UIColor *)color;
// 中间添加线段 - 垂直方向
- (UIView *)sp_addVerticalMiddleLineWithTopMargin:(CGFloat)topMargin
                                     bottomMargin:(CGFloat)bottomMargin;
- (UIView *)sp_addVerticalHeadLineWithTopMargin:(CGFloat)topMargin
                                   bottomMargin:(CGFloat)bottomMargin;
- (UIView *)sp_addVerticalTailLineWithTopMargin:(CGFloat)topMargin
                                   bottomMargin:(CGFloat)bottomMargin;
// 中间添加线段 - 水平方向
- (UIView *)sp_addHorizontalMiddleLineWithLeftMargin:(CGFloat)leftMargin
                                         rightMargin:(CGFloat)rightMargin;
- (UIView *)sp_addHorizontalTopLineWithLeftMargin:(CGFloat)leftMargin
                                      rightMargin:(CGFloat)rightMargin;
- (UIView *)sp_addHorizontalBottomLineWithLeftMargin:(CGFloat)leftMargin
                                         rightMargin:(CGFloat)rightMargin;
// 移除线
- (void)sp_removeTopLine;
- (void)sp_removeBottomLine;

- (void)sp_removeHorizontalMiddleLine;
- (void)sp_removeHorizontalTopLine;
- (void)sp_removeHorizontalBottomLine;

- (void)sp_removeVerticalMiddleLine;
- (void)sp_removeVerticalHeadLine;
- (void)sp_removeVerticalTailLine;
@end
