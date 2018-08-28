//
//  UIView+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "UIView+GHExtension.h"
#import <objc/runtime.h>
static NSTimeInterval DEFAULT_DURATION = 0.25;
@interface UIImageView (GHExtension)
@property (readwrite, nonatomic, strong, setter = ga_supAnimator:)UIDynamicAnimator *ga_supAnimator;
@end
@implementation UIView (GHExtension)
// 以下是基本熟悉的快速设置

- (CGFloat)tx {
    return self.transform.tx;
}

- (void)setTx:(CGFloat)tx {
    CGAffineTransform transform = self.transform;
    transform.tx = tx;
    self.transform = transform;
}

- (CGFloat)ty {
    return self.transform.ty;
}

- (void)setTy:(CGFloat)ty {
    CGAffineTransform transform = self.transform;
    transform.ty = ty;
    self.transform = transform;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
- (CGPoint)origin {
    return self.frame.origin;
}
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)centerXEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.getSuperView];
    CGPoint centerPoint = [self.getSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerX = centerPoint.x;
}

- (void)centerYEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewCenterPoint = [superView convertPoint:view.center toView:self.getSuperView];
    CGPoint centerPoint = [self.getSuperView convertPoint:viewCenterPoint toView:self.superview];
    self.centerY = centerPoint.y;
}

// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + top + view.height;
}

- (void)bottom:(CGFloat)bottom FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y - bottom - self.height;
}

- (void)left:(CGFloat)left FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x - left - self.width;
}

- (void)right:(CGFloat)right FromView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + right + view.width;
}

- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.y - top + self.height;
    }
    self.y = top;
}

- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.height = self.superview.height - bottom - self.y;
    } else {
        self.y = self.superview.height - self.height - bottom;
    }
}

- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.x - left + self.superview.width;
    }
    self.x = left;
}

- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize
{
    if (shouldResize) {
        self.width = self.superview.width - right - self.x;
    } else {
        self.x = self.superview.width - self.width - right;
    }
}

- (void)topEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y;
}

- (void)bottomEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.y = newOrigin.y + view.height - self.height;
}

- (void)leftEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x;
}

- (void)rightEqualToView:(UIView *)view
{
    UIView *superView = view.superview ? view.superview : view;
    CGPoint viewOrigin = [superView convertPoint:view.origin toView:self.getSuperView];
    CGPoint newOrigin = [self.getSuperView convertPoint:viewOrigin toView:self.superview];
    
    self.x = newOrigin.x + view.width - self.width;
}

- (void)sizeEqualToView:(UIView *)view
{
    self.frame = CGRectMake(self.x, self.y, view.width, view.height);
}

// imbueset
- (void)fillWidth
{
    self.width = self.superview.width;
}

- (void)fillHeight
{
    self.height = self.superview.height;
}

- (void)fill
{
    self.frame = CGRectMake(0, 0, self.superview.width, self.superview.height);
}
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
- (UIView *)getSuperView
{
    UIView *getSuperView = self.superview;
    if (getSuperView == nil) {
        getSuperView = self;
    } else {
        while (getSuperView.superview) {
            getSuperView = getSuperView.superview;
        }
    }
    return getSuperView;
}
-(NSInteger)getSubviewIndex
{
    return [self.superview.subviews indexOfObject:self];
}
//将一个View显示在最前面时调用
-(void)bringToFront
{
    [self.superview bringSubviewToFront:self];
}
//将一个View层推送到背后时调用
-(void)sendToBack
{
    [self.superview sendSubviewToBack:self];
}

-(void)bringOneLevelUp
{
    NSInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

-(void)sendOneLevelDown
{
    NSInteger currentIndex = [self getSubviewIndex];
    [self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

-(BOOL)isInFront
{
    return ([self.superview.subviews lastObject]==self);
}

-(BOOL)isAtBack
{
    return ([self.superview.subviews objectAtIndex:0]==self);
}

-(void)swapDepthsWithView:(UIView*)swapView
{
    [self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}

- (UIViewController *)viewController
{
    id next = [self nextResponder];
    
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            return next;
        }
        next = [next nextResponder];
    }
    return nil;
}
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//在视图中附加一个绑定数据。例如可以让 View 携带一个模型,cell优化等可以使用
- (NSObject *)attachment {
    return objc_getAssociatedObject(self, @"kViewAttachment");
}
- (void)setAttachment:(NSObject *)attachment {
    objc_setAssociatedObject(self, @"kViewAttachment",nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @"kViewAttachment",attachment, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
/**
 设置视图的边框和颜色
 cornerRadius   边框角度
 borderWidth    边框宽度
 borderColor    边框颜色
 masksToBounds  是否隐藏被截部分
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds
{
    self.layer.masksToBounds = masksToBounds;
    self.layer.cornerRadius = cornerRadius;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = borderColor.CGColor;
}
/**
 设置视图的几个角的lay
 */
- (void)setLayWith:(UIRectCorner)corners andCornerRadii:(CGSize)cornerRadii{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)setLayerDefaultModify
{
    self.backgroundColor = [UIColor whiteColor];
    [self setLayerWithCornerRadius:4 borderWidth:0.3 borderColor:[UIColor lightGrayColor] masksToBounds:YES];
}






// 添加一条线段 当isTop = yes,是添加到view上面，否则添加到下边
- (void)addLineViewisTop:(BOOL)isTop leftInterval:(CGFloat)leftInterval andRightInterval:(CGFloat)RightInterval;
{
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(leftInterval, isTop ? 0 : self.height - 1.0/[UIScreen mainScreen].scale, self.bounds.size.width - leftInterval - RightInterval, 1.0/[UIScreen mainScreen].scale)];
    lineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [self addSubview:lineView];
}

// 添加一条线段 当isLeft = yes,是添加到view左面，否则添加到右边
- (void)addVerticalLineisLeft:(BOOL)isLeft topInterval:(CGFloat)topInterval andBottomInterval:(CGFloat)BottomInterval
{
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(isLeft ? 0 : self.width - 1.0/[UIScreen mainScreen].scale, topInterval, 1.0/[UIScreen mainScreen].scale, self.height - topInterval - BottomInterval)];
    lineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    [self addSubview:lineView];
}
// 展现阴影0.5s
+ (void)showShadow:(UIView *)view{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)[[UIColor clearColor] CGColor];
    animation.toValue = (id)[[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6] CGColor];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.5;
    [view.layer addAnimation:animation forKey:@"FadeAnimation"];
}
// 添加投影效果
+ (void)addShadowForView:(UIView*)view ShadowOffset:(CGSize)shadowOffset andshadowOpacity:(CGFloat)shadowOpacity
{
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:view.bounds];
    view.layer.masksToBounds = NO;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shadowPath = shadowPath.CGPath;
}

/**
 *  快速根据xib创建View
 */
- (BOOL)ga_intersectsWithView:(UIView *)view
{
    //都先转换为相对于窗口的坐标，然后进行判断是否重合
    CGRect selfRect = [self convertRect:self.bounds toView:nil];
    CGRect viewRect = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(selfRect, viewRect);
}
/**
 *  判断self和view是否重叠
 */
+ (instancetype)ga_viewFromXib
{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}



#pragma mark - 动画分类
// 动画分类 ///////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
- (UIDynamicAnimator*)ga_animator {
    return [self.superview ga_supAnimator];
}
//////////////////////////////////////////////////////////////////////////////////////
- (UIDynamicAnimator*)ga_supAnimator {
    
    UIDynamicAnimator *animator = (UIDynamicAnimator*)objc_getAssociatedObject(self, @selector(ga_supAnimator));
    if(!animator)
    {
        animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        [self ga_setSupAnimator:animator];
    }
    return animator;
}
//////////////////////////////////////////////////////////////////////////////////////
- (void)ga_setSupAnimator:(UIDynamicAnimator*)animator {
    objc_setAssociatedObject(self, @selector(ga_supAnimator), animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
//////////////////////////////////////////////////////////////////////////////////////
CGFloat degreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setDirection:(GAAnimationDirection)direction
{
    //these need to be more accurate
    CGRect frame = self.frame;
    if(direction == GAAnimationDirectionBottom)
        frame.origin.y = self.window.frame.size.height;
    else if(direction == GAAnimationDirectionTop)
        frame.origin.y = -self.window.frame.size.height;
    else if(direction == GAAnimationDirectionLeft)
        frame.origin.x = -self.window.frame.size.width;
    else {
        CGFloat offset = self.window.frame.size.width;
        if([self.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *view = (UIScrollView*)self.superview;
            offset = view.contentSize.width;
        }
        frame.origin.x = offset;
    }
    self.frame = frame;
}
//////////////////////////////////////////////////////////////////////////////////////
-(CGVector)vectorDirection:(GAAnimationDirection)direction
{
    if(direction == GAAnimationDirectionBottom)
        return CGVectorMake(0, -1);
    else if(direction == GAAnimationDirectionTop)
        return CGVectorMake(0, 1);
    else if(direction == GAAnimationDirectionLeft)
        return CGVectorMake(1, 0);
    else
        return CGVectorMake(-1, 0);
}
//////////////////////////////////////////////////////////////////////////////////////

#pragma general movements

//////////////////////////////////////////////////////////////////////////////////////
-(void)setX:(CGFloat)x finished:(GAAnimationFinished)finished
{
    [self setX:x duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.x = x;
        self.frame = frame;
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [self setX:(self.frame.origin.x+x) duration:time finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveX:(CGFloat)x finished:(GAAnimationFinished)finished
{
    [self moveX:x duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
    }completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setY:(CGFloat)y finished:(GAAnimationFinished)finished
{
    [self setY:y duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [self setY:(self.frame.origin.y+y) duration:time finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveY:(CGFloat)y finished:(GAAnimationFinished)finished
{
    [self moveY:y duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setPoint:(CGPoint)point duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin = point;
        self.frame = frame;
    }completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setPoint:(CGPoint)point finished:(GAAnimationFinished)finished
{
    [self setPoint:point finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)movePoint:(CGPoint)point duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [self setPoint:CGPointMake(self.frame.origin.x+point.x, self.frame.origin.y+point.y) duration:time finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)movePoint:(CGPoint)point finished:(GAAnimationFinished)finished
{
    [self movePoint:point duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)setRotation:(CGFloat)r finished:(GAAnimationFinished)finished
{
    [self setRotation:r duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = self.transform;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)moveRotation:(CGFloat)r finished:(GAAnimationFinished)finished
{
    [self moveRotation:r duration:DEFAULT_DURATION finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////

#pragma attention grabbers

//////////////////////////////////////////////////////////////////////////////////////
-(void)bounce:(GAAnimationFinished)finished
{
    [self bounce:10 finished:finished];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)bounce:(CGFloat)height finished:(GAAnimationFinished)finished
{
    UIDynamicAnimator *animator = [self ga_animator];
    [animator removeAllBehaviors];
    [self moveY:-height duration:0.25 finished:^{
        [self moveY:height duration:0.15 finished:^{
            [self moveY:-(height/2) duration:0.15 finished:^{
                [self moveY:height/2 duration:0.05 finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)pulse:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL f){
        [UIView animateWithDuration:0.5 delay:0.1 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL f){
            if(finished)
                finished();
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)shake:(GAAnimationFinished)finished
{
    float dist = 10;
    [self moveX:-dist duration:0.15 finished:^{
        [self moveX:dist*2 duration:0.15 finished:^{
            [self moveX:-(dist*2) duration:0.15 finished:^{
                [self moveX:dist duration:0.15 finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)swing:(GAAnimationFinished)finished
{
    float dist = 15;
    float dur = 0.20;
    __weak id weakSelf = self;
    [weakSelf setRotation:dist duration:dur finished:^{
        [weakSelf setRotation:-dist duration:dur finished:^{
            [weakSelf setRotation:dist/2 duration:dur finished:^{
                [weakSelf setRotation:-dist/2 duration:dur finished:^{
                    [weakSelf setRotation:0 duration:dur finished:^{
                        if(finished)
                            finished();
                    }];
                }];
            }];
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)tada:(GAAnimationFinished)finished
{
    float dist = 3;
    float dur = 0.12;
    [UIView animateWithDuration:dur animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformMakeScale(0.95, 0.95);
        rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(dist));
        self.transform = rotationTransform;
    } completion:^(BOOL f){
        [UIView animateWithDuration:dur animations:^{
            CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1.05, 1.05);
            rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(-dist));
            self.transform = rotationTransform;
        } completion:^(BOOL f){
            
            __weak id weakSelf = self;
            [weakSelf moveRotation:dist*2 duration:dur finished:^{
                [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                    [weakSelf moveRotation:dist*2 duration:dur finished:^{
                        [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                            [UIView animateWithDuration:dur animations:^{
                                CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1, 1);
                                rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(0));
                                self.transform = rotationTransform;
                            } completion:^(BOOL f){
                                if(finished)
                                    finished();
                            }];
                        }];
                    }];
                }];
            }];
            
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////

#pragma intros

//////////////////////////////////////////////////////////////////////////////////////
-(void)removeCurrentAnimations
{
    UIDynamicAnimator *animator = [self ga_animator];
    [animator removeAllBehaviors];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)snapIntoView:(UIView*)view direction:(GAAnimationDirection)direction
{
    if(self.superview != view)
        [self removeFromSuperview];
    [view addSubview:self];
    UIDynamicAnimator *animator = [self ga_animator];
    if(!animator.isRunning)
        [animator removeAllBehaviors];
    
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self snapToPoint:self.center];
    [self setDirection:direction];
    snapBehaviour.damping = 0.75f;
    [animator addBehavior:snapBehaviour];
    
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)bounceIntoView:(UIView*)view direction:(GAAnimationDirection)direction
{
    if(self.superview != view)
        [self removeFromSuperview];
    [view addSubview:self];
    UIDynamicAnimator *animator = [self ga_animator];
    if(!animator.isRunning)
        [animator removeAllBehaviors];
    
    UIAttachmentBehavior *behavior = [[UIAttachmentBehavior alloc] initWithItem:self attachedToAnchor:self.center];
    [self setDirection:direction];
    behavior.length = 0;
    behavior.damping = 0.55;
    behavior.frequency = 1.0;
    [animator addBehavior:behavior];
    
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)expandIntoView:(UIView *)view finished:(GAAnimationFinished)finished
{
    if(self.superview != view)
        [self removeFromSuperview];
    [view addSubview:self];
    
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////

#pragma outros

//////////////////////////////////////////////////////////////////////////////////////
-(void)compressIntoView:(GAAnimationFinished)finished
{
    [UIView animateWithDuration:0.3 animations:^{
        self.transform = CGAffineTransformMakeScale(0, 0);
    } completion:^(BOOL f){
        self.hidden = YES;
        if(finished)
            finished();
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)hinge:(GAAnimationFinished)finished
{
    UIDynamicAnimator *animator = [self ga_animator];
    [animator removeAllBehaviors];
    CGPoint point = CGPointMake(self.frame.origin.x, self.frame.origin.y);
    self.layer.anchorPoint = CGPointMake(0, 0);
    self.center = point;
    __weak UIView *weakSelf = self;
    float dur = 0.5;
    [weakSelf setRotation:80 duration:dur finished:^{
        [weakSelf setRotation:70 duration:dur finished:^{
            [weakSelf setRotation:80 duration:dur finished:^{
                [weakSelf setRotation:70 duration:dur finished:^{
                    [self moveY:weakSelf.window.frame.size.height duration:dur finished:^{
                        [self removeFromSuperview];
                        if(finished)
                            finished();
                        [weakSelf setRotation:0 finished:NULL];
                    }];
                }];
            }];
        }];
    }];
}
//////////////////////////////////////////////////////////////////////////////////////
-(void)drop:(GAAnimationFinished)finished
{
    UIDynamicAnimator *animator = [self ga_animator];
    if(!animator.isRunning) {
        [animator removeAllBehaviors];
    }
    
    UIGravityBehavior *gravityBehaviour = [[UIGravityBehavior alloc] initWithItems:@[self]];
    gravityBehaviour.gravityDirection = CGVectorMake(0.0f, 10.0f);
    [animator addBehavior:gravityBehaviour];
    
    UIDynamicItemBehavior *itemBehaviour = [[UIDynamicItemBehavior alloc] initWithItems:@[self]];
    [itemBehaviour addAngularVelocity:-M_PI_2 forItem:self];
    [animator addBehavior:itemBehaviour];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL f){
        [self removeFromSuperview];
        if(finished)
            finished();
    }];
}
#pragma mark - 添加手势事件
#ifndef GASYNTH_DYNAMIC_PROPERTY_OBJECT
#define GASYNTH_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
- (void)_setter_ : (_type_)object { \
[self willChangeValueForKey:@#_getter_]; \
objc_setAssociatedObject(self, _cmd, object, OBJC_ASSOCIATION_ ## _association_); \
[self didChangeValueForKey:@#_getter_]; \
} \
- (_type_)_getter_ { \
return objc_getAssociatedObject(self, @selector(_setter_:)); \
}
#endif
GASYNTH_DYNAMIC_PROPERTY_OBJECT(handleTapBlock, setHandleTapBlock, COPY_NONATOMIC, HandleTapBlock)
GASYNTH_DYNAMIC_PROPERTY_OBJECT(handleDoubleTapBlock, setHandleDoubleTapBlock, COPY_NONATOMIC, HandleTapBlock)
#ifndef Block_exe
#define Block_exe(block, ...) \
if (block) { \
block(__VA_ARGS__); \
}
#endif
- (void)handleTapActionWithBlock:(HandleTapBlock)block
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(handleTapAction:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    self.handleTapBlock = block;
}
- (void)handleDoubleTapActionWithBlock:(HandleTapBlock)block
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:[self class] action:@selector(handleDoubleTapAction:)];
    tapGestureRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:tapGestureRecognizer];
    self.userInteractionEnabled = YES;
    self.handleDoubleTapBlock = block;
}
+ (void)handleTapAction:(UITapGestureRecognizer *)tapGesture {
    Block_exe(tapGesture.view.handleTapBlock, tapGesture.view);
}

+ (void)handleDoubleTapAction:(UITapGestureRecognizer *)tapGesture {
    Block_exe(tapGesture.view.handleDoubleTapBlock, tapGesture.view);
}
@end
