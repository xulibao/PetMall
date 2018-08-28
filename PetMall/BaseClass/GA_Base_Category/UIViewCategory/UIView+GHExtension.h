//
//  UIView+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GAAnimationFinished)(void); // 动画分类
typedef void (^HandleTapBlock) (UIView *sender); // 手势事件
@interface UIView (GHExtension)
// 注意: 如果在分类中写@property, 只会生成get/set方法的声明, 不会生成实现
// 并且也不会在.m中自动添加_开头的属性
// 以下是基本熟悉的快速设置
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat tx;
@property (nonatomic, assign) CGFloat ty;

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// 以下是基本方法
// top, bottom, left, right
- (void)top:(CGFloat)top FromView:(UIView *)view;
- (void)bottom:(CGFloat)bottom FromView:(UIView *)view;
- (void)left:(CGFloat)left FromView:(UIView *)view;
- (void)right:(CGFloat)right FromView:(UIView *)view;

- (void)topEqualToView:(UIView *)view;
- (void)bottomEqualToView:(UIView *)view;
- (void)leftEqualToView:(UIView *)view;
- (void)rightEqualToView:(UIView *)view;

//  距离附近View间距 top, bottom, left, right
- (void)topInContainer:(CGFloat)top shouldResize:(BOOL)shouldResize;
- (void)bottomInContainer:(CGFloat)bottom shouldResize:(BOOL)shouldResize;
- (void)leftInContainer:(CGFloat)left shouldResize:(BOOL)shouldResize;
- (void)rightInContainer:(CGFloat)right shouldResize:(BOOL)shouldResize;
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// 以下是比较,填充
// size
- (void)setSize:(CGSize)size;
- (void)sizeEqualToView:(UIView *)view;

// 与父类保持一致
- (void)fillWidth;
- (void)fillHeight;
- (void)fill;

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// 以下是便捷拿到View的层次队列
// 拿到父类View
- (UIView *)getSuperView;
// removes all subviews.
- (void)removeAllSubviews;
// 得到view的Index
- (NSInteger)getSubviewIndex;
// 到最前面
- (void)bringToFront;
// 到最后面
- (void)sendToBack;
// 向前移动一层
- (void)bringOneLevelUp;
// 向后推一层
- (void)sendOneLevelDown;
// 在最前面
- (BOOL)isInFront;
// 在最后面
- (BOOL)isAtBack;
// 交换view的Index
- (void)swapDepthsWithView:(UIView*)swapView;
// 拿到父类控制器
- (UIViewController *)viewController;
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
//在视图中附加一个绑定数据。例如可以让 View 携带一个模型,cell优化等可以使用
@property (nonatomic, retain) NSObject *attachment;
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
/**
 设置视图的边框和颜色
 cornerRadius   边框角度
 borderWidth    边框宽度
 borderColor    边框颜色
 masksToBounds  是否隐藏被截部分
 */
- (void)setLayerWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds;
/**
 设置视图的几个角的lay
 UIView *viewTemp = [[UIView alloc] initWithFrame:CGRectMake(120,100,180,40)];
 viewTemp.backgroundColor = [UIColor redColor];
 [self.view addSubview:viewTemp];
 [viewTemp setLayWith:UIRectCornerTopLeft | UIRectCornerBottomLeft andCornerRadii:CGSizeMake(20,20)];
 */
- (void)setLayWith:(UIRectCorner)corners andCornerRadii:(CGSize)cornerRadii;
// 默认 Layer
- (void)setLayerDefaultModify;
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////
// 添加一条线段 当isTop = yes,是添加到view上面，否则添加到下边
- (void)addLineViewisTop:(BOOL)isTop leftInterval:(CGFloat)leftInterval andRightInterval:(CGFloat)RightInterval;
// 添加一条线段 当isLeft = yes,是添加到view左面，否则添加到右边
- (void)addVerticalLineisLeft:(BOOL)isLeft topInterval:(CGFloat)topInterval andBottomInterval:(CGFloat)BottomInterval;

// 展现阴影0.5s,用法[UIView showShadow:_shadowView];
+ (void)showShadow:(UIView *)view;

// 添加投影效果  ShadowOffset -> CGSizeMake(0.0f, 5.0f)
//shadowOpacity -> 0.5
+ (void)addShadowForView:(UIView*)view ShadowOffset:(CGSize)shadowOffset andshadowOpacity:(CGFloat)shadowOpacity;
/**
 *  快速根据xib创建View
 */
+ (instancetype)ga_viewFromXib;
/**
 *  判断self和view是否重叠
 */
- (BOOL)ga_intersectsWithView:(UIView *)view;


// 动画分类 ///////////////////////////////////
/**
 set the x location you want the view to set
 @param x is the x coordinate you want to set.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 set the x location you want the view to move to.
 @param x is the x coordinate you want to move to.
 @param finished is called when the animation finishes
 */
-(void)setX:(CGFloat)x finished:(GAAnimationFinished)finished;

/**
 move the x location (e.g. the x of the view's frame is 200 and x is 50,
 then the x coordinate of the view's frame will be 250).
 @param x is the offset of the x coordinate you want to move by.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 move the x location (e.g. the x of the view's frame is 200 and x is 50,
 then the x coordinate of the view's frame will be 250).
 @param x is the offset of the x coordinate you want to move by.
 @param finished is called when the animation finishes
 */
-(void)moveX:(CGFloat)x finished:(GAAnimationFinished)finished;

/**
 set the y location you want the view to set
 @param y is the x coordinate you want to set.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 set the y location you want the view to set
 @param y is the y coordinate you want to set.
 @param finished is called when the animation finishes
 */
-(void)setY:(CGFloat)y finished:(GAAnimationFinished)finished;

/**
 move the y location (e.g. the y of the view's frame is 200 and y is 50,
 then the y coordinate of the view's frame will be 250).
 @param y is the offset of the y coordinate you want to move by.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 move the y location (e.g. the y of the view's frame is 200 and y is 50,
 then the y coordinate of the view's frame will be 250).
 @param y is the offset of the y coordinate you want to move by.
 @param finished is called when the animation finishes
 */
-(void)moveY:(CGFloat)y finished:(GAAnimationFinished)finished;

/**
 set the point you want the view to set to.
 @param point is the x and y coordinate you want to set.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)setPoint:(CGPoint)point duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 set the point you want the view to set to.
 @param point is the x and y coordinate you want to set.
 @param finished is called when the animation finishes
 */
-(void)setPoint:(CGPoint)point finished:(GAAnimationFinished)finished;

/**
 move the x and y location (e.g. x,y is 10,20 and the point is 30,30,
 then the x and y coordinates of the view's frame will be 40,50).
 @param point is the offset of the x,y coordinates you want to move by.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)movePoint:(CGPoint)point duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 move the x and y location (e.g. x,y is 10,20 and the point is 30,30,
 then the x and y coordinates of the view's frame will be 40,50).
 @param point is the offset of the x,y coordinates you want to move by.
 @param finished is called when the animation finishes
 */
-(void)movePoint:(CGPoint)point finished:(GAAnimationFinished)finished;


/**
 set the degrees of rotation on the view
 @param r is the degrees you want the view to be rotated by. This would be a value between 0 and 360.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 set the degrees of rotation on the view
 @param r is the degrees you want the view to be rotated by. This would be a value between 0 and 360.
 @param finished is called when the animation finishes
 */
-(void)setRotation:(CGFloat)r finished:(GAAnimationFinished)finished;

/**
 move the view by a degree of rotation
 @param r is the degrees you want the view to be rotated by. This would be a value between 0 and 360.
 @param time is the duration of the animation.
 @param finished is called when the animation finishes
 */
-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(GAAnimationFinished)finished;

/**
 move the view by a degree of rotation
 @param r is the degrees you want the view to be rotated by. This would be a value between 0 and 360.
 @param finished is called when the animation finishes
 */
-(void)moveRotation:(CGFloat)r finished:(GAAnimationFinished)finished;

///-------------------------------
/// @name Attention grabbers
///-------------------------------

/**
 preform the bounce animation.
 @param finished is called when the animation finishes
 */
-(void)bounce:(GAAnimationFinished)finished;

/**
 preform the bounce animation.
 @param height is how many px to bounce up by. Default is 10.
 @param finished is called when the animation finishes
 */
-(void)bounce:(CGFloat)height finished:(GAAnimationFinished)finished;

/**
 preform the pulse animation.
 @param finished is called when the animation finishes
 */
-(void)pulse:(GAAnimationFinished)finished;

/**
 preform the shake animation.
 @param finished is called when the animation finishes
 */
-(void)shake:(GAAnimationFinished)finished;

/**
 preform the swing animation.
 @param finished is called when the animation finishes
 */
-(void)swing:(GAAnimationFinished)finished;

/**
 preform the tada animation.
 @param finished is called when the animation finishes
 */
-(void)tada:(GAAnimationFinished)finished;


///-------------------------------
/// @name Intros
///-------------------------------

typedef NS_ENUM(NSInteger, GAAnimationDirection) {
    GAAnimationDirectionTop,
    GAAnimationDirectionBottom,
    GAAnimationDirectionLeft,
    GAAnimationDirectionRight
};

/**
 The view enters from a direction and snaps into place.
 @param view is the superview you want to snap into. It will add itself as a subview of view.
 @param direction is the direction to enter from.
 */
-(void)snapIntoView:(UIView*)view direction:(GAAnimationDirection)direction;

/**
 The view enters from a direction and bounce into place.
 @param view is the superview you want to bounce into. It will add itself as a subview of view.
 @param direction is the direction to enter from.
 */
-(void)bounceIntoView:(UIView*)view direction:(GAAnimationDirection)direction;

/**
 The view expands into it's frame place.
 @param view is the superview you want to expand into. It will add itself as a subview of view.
 @param finished is called when the animation finishes
 */
-(void)expandIntoView:(UIView*)view finished:(GAAnimationFinished)finished;


///-------------------------------
/// @name Outros
///-------------------------------

/**
 The view compress into it's frame place.
 @param finished is called when the animation finishes
 */
-(void)compressIntoView:(GAAnimationFinished)finished;

/**
 The view hinges and falls off screen.
 @param finished is called when the animation finishes
 */
-(void)hinge:(GAAnimationFinished)finished;

/**
 The view will drop based on gravity.
 @param finished is called when the animation finishes
 */
-(void)drop:(GAAnimationFinished)finished;

/**
 Remove the current animator animations applied.
 */
-(void)removeCurrentAnimations;
//(^HandleTapBlock) (UIView *sender)
#pragma mark - 添加手势事件
- (void)handleTapActionWithBlock:(HandleTapBlock)block;
- (void)handleDoubleTapActionWithBlock:(HandleTapBlock)block;
/*
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(22, 22, 250, 30)];
 view.backgroundColor = [UIColor blueColor];
 [view handleTapActionWithBlock:^(UIView *sender) {
 NSLog(@"单机事件");
 }];
 [self.view addSubview:view];
 */
@end
