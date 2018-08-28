//
//  STTabBarView.h
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STTabBtnModel.h"
#import "STTabBarBtn.h"

@interface STTabBarView : UITabBar
@property (nonatomic, strong) NSMutableArray<STTabBarBtn*> *tabBtnViewArray;
@property (nonatomic, copy) NSArray<STTabBtnModel*> *tabBtnModelArray;

//- (void)selectIndex:(NSUInteger)index;
//+ (instancetype)tabBarViewWithTabBtnModelArray:(NSArray *)tabBtnModelArray;

@end
