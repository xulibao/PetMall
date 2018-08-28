//
//  STInsetsTextField.m
//  SnailTruck
//
//  Created by imeng on 3/14/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STInsetsTextField.h"

@implementation STInsetsTextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeUnlessEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect paddedRect = UIEdgeInsetsInsetRect(bounds, self.textContainerInset);
    
    if (self.rightViewMode == UITextFieldViewModeAlways || self.rightViewMode == UITextFieldViewModeWhileEditing) {
        return [self adjustRectWithWidthRightView:paddedRect];
    }
    return paddedRect;
}

- (CGRect)adjustRectWithWidthRightView:(CGRect)bounds {
    CGRect paddedRect = bounds;
    paddedRect.size.width -= CGRectGetWidth(self.rightView.frame);
    
    return paddedRect;
}

@end
