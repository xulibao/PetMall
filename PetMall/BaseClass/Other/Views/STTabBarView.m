//
//  STTabBarView.m
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GM. All rights reserved.
//

#import "STTabBarView.h"

@implementation STTabBarView

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.tabBtnViewArray enumerateObjectsUsingBlock:^(STTabBarBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.width = kMainBoundsWidth / self.tabBtnModelArray.count;
        obj.height = self.height;
        obj.x = idx * obj.width;
    }];
}

- (void)setTabBtnModelArray:(NSArray<STTabBtnModel *> *)tabBtnModelArray {
    _tabBtnModelArray = tabBtnModelArray;
    {
        self.tabBtnViewArray = [NSMutableArray array];
        for (int i = 0; i < tabBtnModelArray.count; i++) {
            STTabBtnModel * item = tabBtnModelArray[i];
    
            STTabBarBtn * tabBarBtn = [[STTabBarBtn alloc] init];
            [tabBarBtn setTitle:item.title forState:UIControlStateNormal];
            [tabBarBtn setTitleColor:kColorTextBlack forState:UIControlStateNormal];
            [tabBarBtn setTitleColor:kColorMaiRed forState:UIControlStateSelected];
            [tabBarBtn setImage:[UIImage imageNamed:item.normalImageName] forState:UIControlStateNormal];
            [tabBarBtn setImage:[UIImage imageNamed:item.selectImageName] forState:UIControlStateSelected];
            tabBarBtn.index = i;
            [self.tabBtnViewArray addObject:tabBarBtn];
            [self addSubview:tabBarBtn];
        }
        [self updateSelectedButtonWithIndex:0];
    }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    NSUInteger index = [self.items indexOfObject:selectedItem];
    [self updateSelectedButtonWithIndex:index];
    [super setSelectedItem:selectedItem];
}

- (void)updateSelectedButtonWithIndex:(NSUInteger)index {
    [self.tabBtnViewArray enumerateObjectsUsingBlock:^(STTabBarBtn * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.selected = (index == obj.index);
        if (obj.selected) {
            [self playAnimation:obj.imageView];
        }
    }];
}

- (void)playAnimation:(UIImageView *)icon
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1.1), @(1), @(0.75), @(0.75), @(1)];
    animation.duration = 0.3;
    animation.calculationMode = kCAAnimationCubic;
    [icon.layer addAnimation:animation forKey:@"playAnimation"];
}

@end
