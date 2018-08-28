//
//  STRightImageButton.m
//  SnailTruck
//
//  Created by imeng on 6/29/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STRightImageButton.h"

@implementation STRightImageButton

- (CGRect)contentRectForBounds:(CGRect)bounds {
    CGRect rect = [super contentRectForBounds:bounds];
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect titleFrame = [super titleRectForContentRect:contentRect];
    if (self.currentImage != nil) {
        titleFrame.origin.x = CGRectGetMinX([super imageRectForContentRect:contentRect]);
    }
    return titleFrame;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect imageFrame = [super imageRectForContentRect:contentRect];
    imageFrame.origin.x = CGRectGetWidth(contentRect) - CGRectGetWidth(imageFrame);
    return imageFrame;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self layoutIfNeeded];
}

@end
