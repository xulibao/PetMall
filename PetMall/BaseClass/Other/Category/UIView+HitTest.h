//
//  UIView+HitTest.h
//  SnailTruck
//
//  Created by imeng on 2017/10/18.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HitTest)

+ (CGRect)HitTestingBounds:(CGRect)bounds minimumHitTestSize:(CGSize)minimumHitTestSize;

@end
