//
//  STInsetsLabel.m
//  SnailTruck
//
//  Created by 唐欢 on 15/11/26.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STInsetsLabel.h"

@implementation STInsetsLabel

- (instancetype)init {
    return [self initWithInsets:UIEdgeInsetsZero];
}

-(instancetype) initWithInsets: (UIEdgeInsets) insets {
    self = [super init];
    if(self){
        self.textContainerInset = insets;
    }
    return self;
}

// 修改绘制文字的区域，edgeInsets增加bounds
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    
    /*
     调用父类该方法
     注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
     */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 self.textContainerInset) limitedToNumberOfLines:numberOfLines];
    
    rect = UIEdgeInsetsInsetRect(rect, self.textContainerInset);
    rect.origin.x -= self.textContainerInset.left;
    rect.origin.y -= self.textContainerInset.top;
    rect.size.width += self.textContainerInset.left + self.textContainerInset.right;
    rect.size.height += self.textContainerInset.top + self.textContainerInset.bottom;
    return rect;
}

//绘制文字
- (void)drawTextInRect:(CGRect)rect {
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.textContainerInset)];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _textContainerInset = textContainerInset;
    [self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize aSize = [super sizeThatFits:size];
    aSize.width += self.textContainerInset.left + self.textContainerInset.right;
    aSize.height += self.textContainerInset.top + self.textContainerInset.bottom;
    return aSize;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.textContainerInset.left + self.textContainerInset.right;
    size.height += self.textContainerInset.top + self.textContainerInset.bottom;
    return size;
}

@end
