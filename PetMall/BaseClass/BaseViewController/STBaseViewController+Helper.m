//
//  STBaseViewController+Helper.m
//  SnailAuction
//
//  Created by imeng on 2018/2/6.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STBaseViewController+Helper.h"

@implementation STBaseViewController (Helper)

/**
 *  通过遍历获取navigation bar bottom line
 *
 *  @param view navigation bar
 *
 *  @return navigation bar bottom line
 */
- (UIImageView *)navigationBarBottomLine:(UIView *)view
{
    // 判断条件为line的高度 <=1.0
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        return [self navigationBarBottomLine:subview];
    }
    return nil;
}

- (void)hideNavigationBarBottomLine
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list)
        {
            if (IOS10_OVER)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *image =  (UIImageView*)obj2;
                        if (image.height < 1) {
                            image.hidden = YES;
                        }
                    }
                }
            }else
            {
                if ([obj isKindOfClass:[UIImageView class]])
                {
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    for (id obj2 in list2)
                    {
                        if ([obj2 isKindOfClass:[UIImageView class]])
                        {
                            UIImageView *imageView2=(UIImageView *)obj2;
                            if (imageView2.height < 1) {
                                imageView2.hidden=YES;
                            }
                        }
                    }
                }
            }
        }
    }
}

@end
