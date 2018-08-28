//
//  UIWindow+GAExtension.m
//  GHPlaceHolderSize
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "UIWindow+GAExtension.h"

@implementation UIWindow (GAExtension)
- (UIViewController*)top_Controller
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController])topController = [topController presentedViewController];
    
    //  Returning topMost ViewController
    return topController;
}

- (UIViewController*)current_Controller;
{
    UIViewController *currentViewController = [self top_Controller];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]] && [(UINavigationController*)currentViewController topViewController])
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    
    return currentViewController;
}

@end
