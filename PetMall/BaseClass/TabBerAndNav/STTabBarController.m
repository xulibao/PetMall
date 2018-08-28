//
//  STTabBarController.m
//  SnailTruck
//
//  Created by xu on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import "STTabBarController.h"
#import "PMLoginViewController.h"
#import "PMHomeViewController.h"
#import "PMCategoryViewController.h"
#import "PMCartViewController.h"
#import "PMGroupPurchaseViewController.h"
#import "PMMineViewController.h"

@interface STTabBarController () <UITabBarControllerDelegate>

@end

@implementation STTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setUpChildControllers];
    [self setUpTabBarView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.selectedViewController;
    return [topVC preferredStatusBarStyle];
}

//- (BOOL)prefersStatusBarHidden {
//    UIViewController *topVC = self.selectedViewController;
//    return [topVC prefersStatusBarHidden];
//}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    UIViewController *topVC = self.selectedViewController;
    return [topVC preferredStatusBarUpdateAnimation];
}

- (void)setUpChildControllers
{
//    STNavigationController *nav0 = [[STNavigationController alloc] initWithRootViewController:[SAHomeViewController new]];
//    STNavigationController *nav1 = [[STNavigationController alloc] initWithRootViewController:[SAHallViewController new]];
//    STNavigationController *nav2 = [[STNavigationController alloc] initWithRootViewController:[SAMyCarViewController new]];
//    STNavigationController *nav3 = [[STNavigationController alloc] initWithRootViewController:[SAMineViewController new]];
//    self.viewControllers = @[nav0,nav1,nav2,nav3];
    UIViewController *vc0 = [PMHomeViewController new];
    UIViewController *vc1 = [PMCategoryViewController new];
    UIViewController *vc2 = [PMGroupPurchaseViewController new];
    UIViewController *vc3 = [PMCartViewController new];
    UIViewController *vc4 = [PMMineViewController new];

    _vc0 = vc0;
    _vc1 = vc1;
    _vc2 = vc2;
    _vc3 = vc3;
    _vc4 = vc4;
    
//    vc0.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页"
//                                                   image:[UIImage imageNamed:@"home_btn_normal"]
//                                           selectedImage:[UIImage imageNamed:@"home_btn_select"]];
//    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"拍卖大厅"
//                                                   image:[UIImage imageNamed:@"Auction_btn_normal"]
//                                           selectedImage:[UIImage imageNamed:@"Auction_btn_select"]];
//    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的车辆"
//                                                   image:[UIImage imageNamed:@"truck_btn_normal"]
//                                           selectedImage:[UIImage imageNamed:@"truck_btn_select"]];
//    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"我的"
//                                                   image:[UIImage imageNamed:@"mine_btn_normal"]
//                                           selectedImage:[UIImage imageNamed:@"mine_btn_select"]];
    
    self.viewControllers = @[vc0,vc1,vc2,vc3,vc4];
}

//设置底部tabBar
- (void)setUpTabBarView{
    STTabBtnModel *home = [STTabBtnModel tabBtnModelWithTitle:@"首页" normalImageName:@"home_btn_normal" andSelectImageName:@"home_btn_select"];
    
    STTabBtnModel *category = [STTabBtnModel tabBtnModelWithTitle:@"分类"  normalImageName:@"category_btn_normal" andSelectImageName:@"category_btn_select"];
    
    STTabBtnModel *group = [STTabBtnModel tabBtnModelWithTitle:@"团购活动" normalImageName:@"truck_btn_normal" andSelectImageName:@"truck_btn_select"];
    
    STTabBtnModel *cart = [STTabBtnModel tabBtnModelWithTitle:@"购物车" normalImageName:@"cart_btn_normal" andSelectImageName:@"cart_btn_select"];
     STTabBtnModel *mine = [STTabBtnModel tabBtnModelWithTitle:@"我的" normalImageName:@"mine_btn_normal" andSelectImageName:@"mine_btn_select"];
    
    NSArray *tabBtnModelArray = @[home,category,group,cart,mine];
    
   self.tabBarView = [[STTabBarView alloc] init];
    self.tabBarView.tabBtnModelArray = tabBtnModelArray;
    [self setValue:self.tabBarView forKey:@"tabBar"];
}

- (void)setSelectedViewController:(__kindof UIViewController *)selectedViewController {
    [super setSelectedViewController:selectedViewController];
    [self updateViewStatusWithViewController:selectedViewController];
}

- (void)updateViewStatusWithViewController:(UIViewController *)viewController {
    UIViewController *selectedViewController = viewController;
    BOOL hiddenNav = selectedViewController.ga_prefersNavigationBarHidden;
    [self.navigationController setNavigationBarHidden:hiddenNav animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [super setSelectedIndex:selectedIndex];
    UIViewController *viewController = [self.viewControllers objectAtIndex:selectedIndex];
    [self updateViewStatusWithViewController:viewController];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController respondsToSelector:@selector(isNeedSign)] && (![SAApplication isSign])) {
        BOOL needSign = [(id)viewController isNeedSign];
        if (needSign) {
            @weakify(self);
            NSArray<UIViewController*> *viewControllers = self.navigationController.viewControllers;
            NSUInteger index = [self.viewControllers indexOfObject:viewController];
            PMLoginViewController *sign = [[PMLoginViewController alloc] init];
            [sign setCallBack:^(PMLoginViewController *viewController) {
                [weak_self.navigationController setViewControllers:viewControllers animated:YES];
//                [weak_self setSelectedIndex:index];
                UIViewController *vc = [self viewControllers][index];
                [weak_self setSelectedViewController:vc];
            }];
            [self.navigationController pushViewController:sign animated:YES];
            return NO;
        }
    }
    return YES;
}

- (BOOL)ga_prefersNavigationBarHidden {
    return self.selectedViewController.ga_prefersNavigationBarHidden;
}

- (void)selectHallVC{
    [self setSelectedIndex:1];
}

@end

