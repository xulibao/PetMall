//
//  STCarInfoMarginLabel.m
//  SnailTruck
//
//  Created by 唐欢 on 15/11/9.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STCarInfoMarginLabel.h"
#import "STEqualMarginLabel.h"

@interface STCarInfoMarginLabel()

@property(nonatomic, assign)CGFloat titleWith;
@property(nonatomic, strong)NSString *title;
@property(nonatomic, strong)UIFont *font;
@property(nonatomic, strong)UIColor *titleColor;

@property(nonatomic, strong)NSString *content;
@property(nonatomic, assign)CGFloat totalWith;
@property(nonatomic, strong)UIFont *contentFont;

@end
@implementation STCarInfoMarginLabel

- (instancetype)initWithTitle:(NSString*)title font:(UIFont *)titleFont contents:(NSString *)contents font:(UIFont *)contentFont WithTitleWith:(CGFloat)titleWith{
    return [self initWithTitle:title font:titleFont titleColor:nil contents:contents font:contentFont WithTitleWith:titleWith];
}

- (instancetype)initWithTitle:(NSString*)title font:(UIFont *)titleFont titleColor:(UIColor *)titleColor contents:(NSString *)contents font:(UIFont *)contentFont WithTitleWith:(CGFloat)titleWith {
    
    if (self = [super init]) {
        self.titleWith = titleWith;
        self.title = [NSString stringWithFormat:@"%@", title] ;
        if (title == nil || title.length == 0 || [title isEqualToString:@""]) {
            self.title = @"无";
        }
        self.font = titleFont;
        
        self.content = [NSString stringWithFormat:@"%@", contents];
        //        self.totalWith = kMainBoundsWidth-8*2-self.titleWith;
        //
        self.contentFont = contentFont;
        _contentLabel = [[UILabel alloc] init];
        [self addSubview:_contentLabel];
        
        _contentLabel.text = self.content;
        CGFloat contentsWith = [_contentLabel.text sizeWithFont:contentFont MaxSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
        _contentWith = contentsWith;
        
        self.titleColor = titleColor;
        
        [self drawRect:CGRectZero];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIFont * numFont = [UIFont systemFontOfSize:13];
    
    CGFloat w = self.titleWith;
    CGFloat x = 0;
    
    CGFloat one = [@"我" sizeWithFont:self.font MaxSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
    CGFloat margin = (w - self.title.length * one)/(self.title.length-1);
    
    UIColor *color = self.titleColor ? self.titleColor : (_titleColoerType?kColorTextBlack:kColorTextLighGay);
    
    
    for (int i = 0; i < self.title.length; i ++) {
        
        NSRange rang = NSMakeRange(i, 1);
        NSString * chars = [self.title substringWithRange:rang];
        
        x = i*(margin+one)+one;
        
        
        
        [chars drawInRect:CGRectMake(i*(margin+one), 1, one, 18) withAttributes:@{NSFontAttributeName:numFont, NSForegroundColorAttributeName: color}];
        
    }
    [@":" drawInRect:CGRectMake(x, 1, one, one) withAttributes:@{NSFontAttributeName:numFont, NSForegroundColorAttributeName: color}];
    /*
     int titleWith = x;
     int j = 0;
     for (int i = 0; i < self.content.length; i++) {
     NSRange rang = NSMakeRange(i, 1);
     NSString * chars = [self.content substringWithRange:rang];
     
     x = j*one + titleWith;
     
     if (x > self.totalWith) {
     row++;
     x = 0;
     j = 0;
     titleWith = 0;
     }
     j++;
     
     [chars drawInRect:CGRectMake(row == 0?  x+one: x, row*one, one, 18) withAttributes:@{NSFontAttributeName:numFont, NSForegroundColorAttributeName: kTextBlackColor}];
     
     }
     */
    //    [self.content drawInRect:CGRectMake(w+one, 0, self.frame.size.width-w-one, self.frame.size.height) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName: kTextBlackColor}];
    CGContextStrokePath(context);
    
    
    
    _contentLabel.font = [UIFont systemFontOfSize:13];
    _contentLabel.frame = CGRectMake(self.titleWith+10, 0, _contentWith, 18);
}

-(NSInteger)returnMaxWith
{
    //无法先触发drawrect先这么写
    CGFloat contentsWith = [_contentLabel.text sizeWithFont:_contentFont MaxSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
    _contentLabel.frame = CGRectMake(self.titleWith+10, 0, contentsWith, 18);
    return contentsWith +self.titleWith+10 ;
}

@end
