//
//  STEqualMarginLabel.m
//  SnailTruck
//
//  Created by 唐欢 on 15/11/9.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STEqualMarginLabel.h"

@interface STEqualMarginLabel()
@property(nonatomic, strong)NSString *text;
@property(nonatomic, strong)UIFont *font;
@end
@implementation STEqualMarginLabel


- (instancetype)initWithText:(NSString*)text font:(UIFont*)font{
    if (self = [super init]) {
        self.text = text;
        self.font = font;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIFont * numFont = [UIFont systemFontOfSize:14];
    
    CGFloat w = self.frame.size.width;
    CGFloat one = [@"我" sizeWithFont:self.font MaxSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
    CGFloat margin = (w - self.text.length * one)/(self.text.length-1);
    for (int i = 0; i < self.text.length; i ++) {
        
        NSRange rang = NSMakeRange(i, 1);
        NSString * chars = [self.text substringWithRange:rang];
        [chars drawInRect:CGRectMake(i*(margin+one), 0, one, one) withAttributes:@{NSFontAttributeName:numFont}];
        
    }
    CGContextStrokePath(context);
    
}

@end
