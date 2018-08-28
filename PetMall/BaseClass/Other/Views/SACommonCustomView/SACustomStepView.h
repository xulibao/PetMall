//
//  SACustomStepView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SACustomStepView : UIView

@property (nonatomic, retain)NSArray * _Nonnull titles;

@property (nonatomic, assign)int stepIndex;

- (instancetype _Nonnull )initWithFrame:(CGRect)frame Titles:(nonnull NSArray *)titles;

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation;

@end
