//
//  UIWindow+GAExtension.h
//  GHPlaceHolderSize
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (GAExtension)
/**
 Returns the current Top Most ViewController in hierarchy.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *top_Controller;

/**
 Returns the topViewController in stack of topMostController.
 */
@property (nullable, nonatomic, readonly, strong) UIViewController *current_Controller;
@end
