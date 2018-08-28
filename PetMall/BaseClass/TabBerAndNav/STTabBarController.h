//
//  STTabBarController.h
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTabBarView.h"

@interface STTabBarController : UITabBarController

@property(nonatomic, strong) UIViewController *vc0;
@property(nonatomic, strong) UIViewController *vc1;
@property(nonatomic, strong) UIViewController *vc2;
@property(nonatomic, strong) UIViewController *vc3;
@property(nonatomic, strong) UIViewController *vc4;

@property (nonatomic, strong) STTabBarView *tabBarView;

- (void)selectHallVC;

@end
