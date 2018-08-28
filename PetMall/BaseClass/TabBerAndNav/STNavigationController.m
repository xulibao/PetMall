//
//  STNavigationController.m
//  SnailTruck
//
//  Created by GhGh on 16/1/11.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STNavigationController.h"
#import "STBaseNonSystemNavViewController.h"

#import "PMLoginViewController.h"

@interface UINavigationBar (UIAppearance)
@end

@implementation UINavigationBar (UIAppearance)

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self setDefaultAppearance];
    });
}

+ (void)setDefaultAppearance {
    [UINavigationBar appearance].titleTextAttributes = @{NSFontAttributeName : kNavigationTitleFont,NSForegroundColorAttributeName : kNavigationBlackColor};
    
//    [[UINavigationBar appearance] setTintColor:kNavigationBlackColor];
}

@end

@interface STNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation STNavigationController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [[UIImage imageNamed:@"nav_Back_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.navigationBar setBackIndicatorImage:image];
    [self.navigationBar setBackIndicatorTransitionMaskImage:image];
    [self.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationBar setBarTintColor:[UIColor whiteColor]];
    [self.navigationBar setTranslucent:NO];
}

// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

//- (BOOL)prefersStatusBarHidden {
//    UIViewController *topVC = self.topViewController;
//    return [topVC prefersStatusBarHidden];
//}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarUpdateAnimation];
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
    [super setViewControllers:viewControllers animated:animated];
    BOOL hiddenNav = viewControllers.firstObject.ga_prefersNavigationBarHidden;
    [self setNavigationBarHidden:hiddenNav animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIViewController *currentViewController = self.topViewController;
    if (currentViewController) {
        currentViewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    }
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    if ([viewController respondsToSelector:@selector(isNeedSign)] && (![SAApplication isSign])) {
        BOOL needSign = [(id)viewController isNeedSign];
        if (needSign) {
            @weakify(self);
            NSArray<UIViewController*> *viewControllers = self.viewControllers;
            PMLoginViewController *sign = [[PMLoginViewController alloc] init];
            [sign setCallBack:^(PMLoginViewController *viewController) {
                [weak_self setViewControllers:[viewControllers arrayByAddingObject:viewController]
                                animated:YES];
            }];
            viewController = sign;
        }
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
