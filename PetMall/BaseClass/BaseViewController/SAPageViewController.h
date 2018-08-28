//
//  SAPageViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseNonSystemNavViewController.h"

@interface SAPageViewController : STBaseNonSystemNavViewController

@property(nonatomic, strong) UIPageViewController *pageViewController;
@property(nonatomic, copy) NSArray<UIViewController*> *viewControllers;

@end

@interface SAPageViewController (SubclassingHooks)

- (void)initPageView;
- (void)layoutPageView;

@end
