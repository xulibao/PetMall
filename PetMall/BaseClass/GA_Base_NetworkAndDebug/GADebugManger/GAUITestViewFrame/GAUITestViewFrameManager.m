//
//  GAUITestViewFrameManager.m
//  GHPlaceHolderSize
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GAUITestViewFrameManager.h"
#import "GAUITestViewFrame.h"
#import "UIWindow+GAExtension.h"
@interface GAUITestViewFrameManager ()
@property (nonatomic, strong) NSMutableArray *allSubViewsArrayM;
@end
@implementation GAUITestViewFrameManager
+ (GAUITestViewFrameManager *)sharedInstance{
    static GAUITestViewFrameManager *uiTest = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        uiTest = [[GAUITestViewFrameManager alloc] init];
        uiTest.isOpenUITest = NO; // 默认不打开
    });
    return uiTest;
}
/**
 * 直接显示所有子视图宽度 高度 以及 本身的宽高
 */
- (void)testAllSubViews_UIWidthAndHeight:(UIView *)view withLineColor:(UITstColor)lineColor
{
    if (self.isOpenUITest == NO) {
        [self removeAllTestUILine:nil];
        return;
    }
    [self.allSubViewsArrayM removeAllObjects];
    if (view != nil && [view isKindOfClass:[UIView class]]) {
        [self ViewRtrurnAllSubViews:view];
    }else
    {
    UIViewController *tempVC = (UIViewController *)[UIApplication sharedApplication].keyWindow.current_Controller;
    if (tempVC != nil && tempVC.view != nil) {
        [self ViewRtrurnAllSubViews:tempVC.view];
        if (tempVC.navigationController.view != nil) {
           [self ViewRtrurnAllSubViews:tempVC.navigationController.view];
        }
        if ([[UIApplication sharedApplication].keyWindow.rootViewController isKindOfClass:[UITabBarController class]] && [UIApplication sharedApplication].keyWindow.rootViewController.view != nil) {
            [self ViewRtrurnAllSubViews:[UIApplication sharedApplication].keyWindow.rootViewController.view];
        }
    }
    }
    UIColor *lineTempColor = [UIColor redColor];
    if (lineColor == UITstColor_Black) {
        lineTempColor = [UIColor blackColor];
    }else if (lineColor == UITstColor_White)
    {
         lineTempColor = [UIColor whiteColor];
    }else if (lineColor == UITstColor_Random)
    {
        lineTempColor = [self randomColor];
    }
    
    for (UIView *subView in self.allSubViewsArrayM) {
        [subView showPlaceHolderWithLineColor:lineTempColor];
    }
    
}
- (UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
// 移除所有的线段
- (void)removeAllTestUILine:(UIView *)view
{
    if (view != nil && [view isKindOfClass:[UIView class]]) {
        [view removePlaceHolderWithAllSubviews];
    }else
    {
        for (UIView *view in self.allSubViewsArrayM) {
            [view removePlaceHolderWithAllSubviews];
        }
        [self.allSubViewsArrayM removeAllObjects];
    }
}
- (void)ViewRtrurnAllSubViews:(UIView *)superView{
    [self.allSubViewsArrayM addObject:superView];
    for (UIView *view in superView.subviews) {
        [self.allSubViewsArrayM addObject:view];
        if (view.subviews > 0) {
            [self ViewRtrurnAllSubViews:view];
        }
    }
}
- (NSMutableArray *)allSubViewsArrayM
{
    if (_allSubViewsArrayM == nil) {
        _allSubViewsArrayM = [NSMutableArray arrayWithCapacity:5];
    }
    return _allSubViewsArrayM;
}
@end
