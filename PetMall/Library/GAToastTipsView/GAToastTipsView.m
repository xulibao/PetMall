//
//  GAToastTipsView.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 16/2/1.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "GAToastTipsView.h"
GAToastGravity ToastGravityMake(GAToastHorizontalGravity x, GAToastVerticalGravity y)
{
    GAToastGravity toast;
    toast.x = x;
    toast.y = y;
    return toast;
}
@interface GAToastTipsView ()
@property (nonatomic, strong) UIImageView *indicateImageView;
@property (nonatomic, strong) UILabel     *contentLabel;
@end

@implementation GAToastTipsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self )
    {
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.font = [UIFont systemFontOfSize:15.0];
        self.contentLabel.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.layer.cornerRadius = 3;
        self.contentLabel.numberOfLines = 0;
        self.layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
        self.layer.shadowOpacity = 0.3;
        [self addSubview:self.contentLabel];
        
        self.indicateImageView = [[UIImageView alloc] init];
        self.indicateImageView.layer.contentsGravity = kCAGravityCenter;
        [self addSubview:self.indicateImageView];
        
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.indicateImageView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"H:|-10-[imageView]-5-[contentLabel]-10-|"
                              options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom
                              metrics:nil
                              views:@{@"imageView":self.indicateImageView,@"contentLabel":self.contentLabel}]];
        [self addConstraints:[NSLayoutConstraint
                              constraintsWithVisualFormat:@"V:|-10-[contentLabel]-10-|"
                              options:0
                              metrics:nil
                              views:@{@"contentLabel":self.contentLabel}]];
    }
    return self;
}

- (void)setContent:(NSString *)content
{
    if (content != nil && content.length > 16) {
        NSMutableString *strM = [NSMutableString stringWithString:content];
        [strM insertString:@"\n" atIndex:16];
        if (content.length > 32) {
            strM = [strM.copy substringToIndex:32].mutableCopy;
            [strM appendString:@"..."];
        }
        self.contentLabel.text = strM.copy;
    }else
        self.contentLabel.text = content;
}

- (void)setIndicateImage:(UIImage *)indicate
{
    self.indicateImageView.image = indicate;
}


- (void)setPositionWithGravity:(GAToastGravity)gravity inView:(UIView *)view
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    switch ( gravity.x )
    {
        case GAToastHorizontalGravityTop:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeTop
                                 multiplier:1
                                 constant:30]];
            break;
        }
        case GAToastHorizontalGravityCenter:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                 constant:0]];
            break;
        }
        case GAToastHorizontalGravityBottom:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                 constant:-20]];
            break;
        }
        default:
            break;
    }
    
    switch (gravity.y)
    {
        case GAToastVerticalGravityLeft:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                 constant:20]];
            break;
        }
        case GAToastVerticalGravityCenter:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeCenterX
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                 constant:0]];
            break;
        }
        case GAToastVerticalGravityRight:
        {
            [view addConstraint:[NSLayoutConstraint
                                 constraintWithItem:self
                                 attribute:NSLayoutAttributeRight
                                 relatedBy:NSLayoutRelationEqual
                                 toItem:view
                                 attribute:NSLayoutAttributeRight
                                 multiplier:1
                                 constant:-20]];
            break;
        }
        default:
            break;
    }
}
+ (GAToastTipsView *)showWithContent:(NSString *)content state:(GAToastTipsState)state gravity:(GAToastGravity)gravity inView:(UIView *)view;
{
    if (content == nil || content.length < 1) {
        return nil;
    }
    GAToastTipsView *toast = [[GAToastTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [toast setContent:content];
    switch (state) {
        case GAToastTipsStateNothing:{
            toast.indicateImageView.image = [UIImage imageNamed:@""];
        }
            break;
        case GAToastTipsStateSucess:
        {
            toast.indicateImageView.image = [UIImage imageNamed:@"GAToastTipsSucess"];
        }
            break;
        case GAToastTipsStateWarning:
        {
            toast.indicateImageView.image = [UIImage imageNamed:@"GAToastTipsWarning"];
        }
            break;
        case GAToastTipsStateError:
        {
            toast.indicateImageView.image = [UIImage imageNamed:@"GAToastTipsError"];
        }
            break;
            
        default:
            break;
    }
    if (view == nil) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [self superViewHaveToastView:window];
        [window addSubview:toast];
        [toast setPositionWithGravity:gravity inView:window];
    }else
    {
        [self superViewHaveToastView:view];
        [view addSubview:toast];
        [toast setPositionWithGravity:gravity inView:view];
    }
    CGFloat delayTimer = 1.5;
    if (content.length > 9) {
        delayTimer = 2.0;
    }
    [UIView animateWithDuration:0.3 delay:delayTimer options:UIViewAnimationOptionCurveEaseInOut animations:^{
        toast.alpha = 0;
    } completion:^(BOOL finished) {
        [toast removeFromSuperview];
    }];
    
    return toast;
}

+ (void)superViewHaveToastView:(UIView *)superView
{
    for (UIView *view in superView.subviews) {
        if ([view isKindOfClass:[GAToastTipsView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end
