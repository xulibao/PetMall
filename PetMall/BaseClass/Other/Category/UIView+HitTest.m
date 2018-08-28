//
//  UIView+HitTest.m
//  SnailTruck
//
//  Created by imeng on 2017/10/18.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "UIView+HitTest.h"

static CGRect p_HitTestingBounds(CGRect bounds, CGFloat minimumHitTestWidth, CGFloat minimumHitTestHeight) {
    CGRect hitTestingBounds = bounds;
    if (minimumHitTestWidth > bounds.size.width) {
        hitTestingBounds.size.width = minimumHitTestWidth;
        hitTestingBounds.origin.x -= (hitTestingBounds.size.width - bounds.size.width)/2;
    }
    if (minimumHitTestHeight > bounds.size.height) {
        hitTestingBounds.size.height = minimumHitTestHeight;
        hitTestingBounds.origin.y -= (hitTestingBounds.size.height - bounds.size.height)/2;
    }
    return hitTestingBounds;
}

@implementation UIView (HitTest)

+ (CGRect) HitTestingBounds:(CGRect)bounds minimumHitTestSize:(CGSize)minimumHitTestSize {
    return p_HitTestingBounds(bounds, minimumHitTestSize.width, minimumHitTestSize.height);
}

@end
