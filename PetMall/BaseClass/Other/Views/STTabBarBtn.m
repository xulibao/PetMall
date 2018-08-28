//
//  STTabBarBtn.m
//  SnailTruck
//
//  Created by 曼 on 15/10/23.
//  Copyright (c) 2015年 GhGh. All rights reserved.
//

#import "STTabBarBtn.h"

@implementation STTabBarBtn
- (instancetype)init{
    if (self = [super init]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageH = 25;
    CGFloat imageW = 25;
    CGFloat imageY = 4;
    CGFloat imageX = (self.width - imageW) * 0.5 ;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 30;
    CGFloat titleW = self.width;
    CGFloat titleH = 15;
    return CGRectMake(titleX, titleY, titleW, titleH);
}
- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end


