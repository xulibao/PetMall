//
//  UINavigationController+GAFullscreenPopGesture.h
//  GANavGestFullScreenPop
//
//  Created by GhGh on 15/11/19.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (GAFullscreenPopGesture)
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *ga_fullscreenPopGestureRecognizer;
@property (nonatomic, assign) BOOL ga_viewControllerBasedNavigationBarAppearanceEnabled;
@end


@interface UIViewController (GAFullscreenPopGesture)

// 在当前页面禁止 POP
/**
 *  用法
   - (void)viewDidLoad {
    [super viewDidLoad];
    self.ga_interactivePopDisabled = YES;
   }
 */
@property (nonatomic, assign) BOOL ga_interactivePopDisabled;

/**
 *  bar 是否隐藏,用法同上
 */
@property (nonatomic, assign) BOOL ga_prefersNavigationBarHidden;

/**
 *  手势可以拖动的区域y值。例如200，300等
 */
@property (nonatomic, assign) CGFloat ga_interactivePopMaxAllowedInitialDistanceToLeftEdge;

@end
