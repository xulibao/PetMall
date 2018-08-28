//
//  SAPageViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAPageViewController.h"

@interface SAPageViewController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@end

@implementation SAPageViewController

- (void)didInitialized {
    [super didInitialized];
    [self initPageView];
}

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    [self.pageViewController.gestureRecognizers enumerateObjectsUsingBlock:^(__kindof UIGestureRecognizer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj requireGestureRecognizerToFail:self.navigationController.ga_fullscreenPopGestureRecognizer];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutPageView];
    [self layoutEmptyView];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    _viewControllers = viewControllers;
    [self.pageViewController setViewControllers:@[[viewControllers firstObject]]
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:NULL];
}

#pragma mark - UIPageViewControllerDataSource

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController] - 1;
    if (index >= 0) {
        return self.viewControllers[index];
    }
    return nil;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [_viewControllers indexOfObject:viewController] + 1;
    if (index < [_viewControllers count]) {
        return self.viewControllers[index];
    }
    return nil;
}

@end

@implementation SAPageViewController(SubclassingHooks)

- (void)initPageView {
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.dataSource = self;
        _pageViewController.delegate = self;
        [_pageViewController willMoveToParentViewController:self];
        [self addChildViewController:_pageViewController];
    }
}
- (void)layoutPageView {
    self.pageViewController.view.frame = self.view.bounds;
}

@end
