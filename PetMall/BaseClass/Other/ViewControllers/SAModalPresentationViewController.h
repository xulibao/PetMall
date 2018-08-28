//
//  SAModalPresentationViewController.h
//  qmui
//
//  Created by MoLice on 16/7/6.
//  Copyright © 2016年 SA Team. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SAViewAnimationOptionsCurveOut (7<<16)
#define SAViewAnimationOptionsCurveIn (8<<16)

#define UIColorMask     (UIColorMakeWithRGBA(0, 0, 0, .35f))
#define UIColorClear    ([UIColor colorWithRed:1 green:1 blue:1 alpha:0])


@class SAModalPresentationViewController;
@class SAModalPresentationWindow;

typedef NS_ENUM(NSUInteger, SAModalPresentationAnimationStyle) {
    SAModalPresentationAnimationStyleFade,    // 渐现渐隐，默认
    SAModalPresentationAnimationStylePopup,   // 从中心点弹出
    SAModalPresentationAnimationStyleSlide    // 从下往上升起
};

@protocol SAModalPresentationContentViewControllerProtocol <NSObject>

@optional

/**
 *  当浮层以 UIViewController 的形式展示（而非 UIView），并且使用 modalController 提供的默认布局时，则可通过这个方法告诉 modalController 当前浮层期望的大小
 *  @param  controller  当前的modalController
 *  @param  limitSize   浮层最大的宽高，由当前 modalController 的大小及 `contentViewMargins`、`maximumContentViewWidth` 决定
 *  @return 返回浮层在 `limitSize` 限定内的大小，如果业务自身不需要限制宽度/高度，则为 width/height 返回 `CGFLOAT_MAX` 即可
 */
- (CGSize)preferredContentSizeInModalPresentationViewController:(SAModalPresentationViewController *)controller limitSize:(CGSize)limitSize;

@end

@protocol SAModalPresentationViewControllerDelegate <NSObject>

@optional

/**
 *  是否应该隐藏浮层，会在调用`hideWithAnimated:completion:`时，以及点击背景遮罩时被调用。默认为YES。
 *  @param  controller  当前的modalController
 *  @return 是否允许隐藏，YES表示允许隐藏，NO表示不允许隐藏
 */
- (BOOL)shouldHideModalPresentationViewController:(SAModalPresentationViewController *)controller;

/**
 *  modalController 即将隐藏时的回调方法，在调用完这个方法后才开始做一些隐藏前的准备工作，例如恢复 window 的 dimmed 状态等。
 *  @param  controller  当前的modalController
 */
- (void)willHideModalPresentationViewController:(SAModalPresentationViewController *)controller;

/**
 *  modalController隐藏后的回调方法，不管是直接调用`hideWithAnimated:completion:`，还是通过点击遮罩触发的隐藏，都会调用这个方法。
 *  如果你想区分这两种方式的隐藏回调，请直接使用hideWithAnimated方法的completion参数，以及`didHideByDimmingViewTappedBlock`属性。
 *  @param  controller  当前的modalController
 */
- (void)didHideModalPresentationViewController:(SAModalPresentationViewController *)controller;

- (void)requestHideAllModalPresentationViewController;

@end

/**
 *  一个提供通用的弹出浮层功能的控件，可以将任意`UIView`或`UIViewController`以浮层的形式显示出来并自动布局。
 *
 *  支持 3 种方式显示浮层：
 *
 *  1. **推荐** 新起一个 `UIWindow` 盖在当前界面上，将 `SAModalPresentationViewController` 以 `rootViewController` 的形式显示出来，可通过 `supportedOrientationMask` 支持横竖屏，不支持在浮层不消失的情况下做界面切换（因为 window 会把背后的 controller 盖住，看不到界面切换）。
 *  可通过 shownInWindowMode 属性来判断是否在用这种方式显示。
 *  @code
 *  [modalPresentationViewController showWithAnimated:YES completion:nil];
 *  @endcode
 *
 *  2. 使用系统接口来显示，支持界面切换，**注意** 使用这种方法必定只能以动画的形式来显示浮层，无法以无动画的形式来显示，并且 `animated` 参数必须为 `NO`。可通过 `supportedOrientationMask` 支持横竖屏。
 *  可通过 shownInPresentedMode 属性来判断是否在用这种方式显示。
 *  @code
 *  [self presentViewController:modalPresentationViewController animated:NO completion:nil];
 *  @endcode
 *
 *  3. 将浮层作为一个 subview 添加到 `superview` 上，从而能够实现在浮层不消失的情况下进行界面切换，但需要 `superview` 自行管理浮层的大小和横竖屏旋转，而且 `SAModalPresentationViewController` 不能用局部变量来保存，会在显示后被释放，需要自行 retain。横竖屏跟随当前界面的设置。
 *  可通过 shownInSubviewMode 属性来判断是否在用这种方式显示。
 *  @code
 *  self.modalPresentationViewController.view.frame = CGRectMake(50, 50, 100, 100);
 *  [self.view addSubview:self.modalPresentationViewController.view];
 *  @endcode
 *
 *  默认的布局会将浮层居中显示，浮层的大小可通过接口控制：
 *  1. 如果是用 `contentViewController`，则可通过 `preferredContentSizeInModalPresentationViewController:limitSize:` 来设置
 *  2. 如果使用 `contentView`，或者使用 `contentViewController` 但没实现 `preferredContentSizeInModalPresentationViewController:limitSize:`，则调用`contentView`的`sizeThatFits:`方法获取大小。
 *  3. 浮层大小会受 `maximumContentViewWidth` 属性的限制，以及 `contentViewMargins` 属性的影响。
 *
 *  通过`layoutBlock`、`showingAnimation`、`hidingAnimation`可设置自定义的布局、打开及隐藏的动画，并允许你适配键盘升起时的场景。
 *
 *  默认提供背景遮罩`dimmingView`，你也可以使用自己的遮罩 view。
 *
 *  默认提供多种显示动画，可通过 `animationStyle` 来设置。
 *
 *  @warning 如果使用者retain了modalPresentationViewController，注意应该在`hideWithAnimated:completion:`里release
 *
 *  @see SAAlertController
 *  @see SADialogViewController
 *  @see SAMoreOperationController
 */
@interface SAModalPresentationViewController : UIViewController {
    UITapGestureRecognizer      *_dimmingViewTapGestureRecognizer;
    CGFloat                     _keyboardHeight;
}

@property(nonatomic, weak) IBOutlet id<SAModalPresentationViewControllerDelegate> delegate;

/**
 *  要被弹出的浮层
 *  @warning 当设置了`contentView`时，不要再设置`contentViewController`
 */
@property(nonatomic, strong) IBOutlet UIView *contentView;

/**
 *  要被弹出的浮层，适用于浮层以UIViewController的形式来管理的情况。
 *  @warning 当设置了`contentViewController`时，`contentViewController.view`会被当成`contentView`使用，因此不要再自行设置`contentView`
 *  @warning 注意`contentViewController`是强引用，容易导致循环引用，使用时请注意
 */
@property(nonatomic, strong) IBOutlet UIViewController<SAModalPresentationContentViewControllerProtocol> *contentViewController;

/**
 *  设置`contentView`布局时与外容器的间距，默认为(20, 20, 20, 20)
 *  @warning 当设置了`layoutBlock`属性时，此属性不生效
 */
@property(nonatomic, assign) UIEdgeInsets contentViewMargins UI_APPEARANCE_SELECTOR;

/**
 *  限制`contentView`布局时的最大宽度，默认为iPhone 6竖屏下的屏幕宽度减去`contentViewMargins`在水平方向的值，也即浮层在iPhone 6 Plus或iPad上的宽度以iPhone 6上的宽度为准。
 *  @warning 当设置了`layoutBlock`属性时，此属性不生效
 */
@property(nonatomic, assign) CGFloat maximumContentViewWidth UI_APPEARANCE_SELECTOR;

/**
 *  背景遮罩，默认为一个普通的`UIView`，背景色为`UIColorMask`，可设置为自己的view，注意`dimmingView`的大小将会盖满整个控件。
 *
 *  `SAModalPresentationViewController`会自动给自定义的`dimmingView`添加手势以实现点击遮罩隐藏浮层。
 */
@property(nonatomic, strong) IBOutlet UIView *dimmingView;

/**
 *  由于点击遮罩导致浮层被隐藏时的回调（区分于`hideWithAnimated:completion:`里的completion，这里是特地用于点击遮罩的情况）
 */
@property(nonatomic, copy) void (^didHideByDimmingViewTappedBlock)(void);

/**
 *  控制当前是否以模态的形式存在。如果以模态的形式存在，则点击空白区域不会隐藏浮层。
 *
 *  默认为NO，也即点击空白区域将会自动隐藏浮层。
 */
@property(nonatomic, assign, getter=isModal) BOOL modal;

/**
 *  标志当前浮层的显示/隐藏状态，默认为NO。
 */
@property(nonatomic, assign, readonly, getter=isVisible) BOOL visible;

/**
 *  修改当前界面要支持的横竖屏方向，默认为 SupportedOrientationMask。
 */
@property(nonatomic, assign) UIInterfaceOrientationMask supportedOrientationMask;

/**
 *  设置要使用的显示/隐藏动画的类型，默认为`SAModalPresentationAnimationStyleFade`。
 *  @warning 当使用了`showingAnimation`和`hidingAnimation`时，该属性无效
 */
@property(nonatomic, assign) SAModalPresentationAnimationStyle animationStyle UI_APPEARANCE_SELECTOR;

/// 是否以 UIWindow 的方式显示，建议在显示之后才使用，否则可能不准确。
@property(nonatomic, assign, readonly, getter=isShownInWindowMode) BOOL shownInWindowMode;

/// 是否以系统 present 的方式显示，建议在显示之后才使用，否则可能不准确。
@property(nonatomic, assign, readonly, getter=isShownInPresentedMode) BOOL shownInPresentedMode;

/// 是否以 addSubview 的方式显示，建议在显示之后才使用，否则可能不准确。
@property(nonatomic, assign, readonly, getter=isShownInSubviewMode) BOOL shownInSubviewMode;

/**
 *  管理自定义的浮层布局，将会在浮层显示前、控件的容器大小发生变化时（例如横竖屏、来电状态栏）被调用
 *  @arg  containerBounds         浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight          键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  contentViewDefaultFrame 不使用自定义布局的情况下的默认布局，会受`contentViewMargins`、`maximumContentViewWidth`、`contentView sizeThatFits:`的影响
 *
 *  @see contentViewMargins
 *  @see maximumContentViewWidth
 */
@property(nonatomic, copy) void (^layoutBlock)(CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewDefaultFrame);

/**
 *  管理自定义的显示动画，需要管理的对象包括`contentView`和`dimmingView`，在`showingAnimation`被调用前，`contentView`已被添加到界面上。若使用了`layoutBlock`，则会先调用`layoutBlock`，再调用`showingAnimation`。在动画结束后，必须调用参数里的`completion` block。
 *  @arg  dimmingView         背景遮罩的View，请自行设置显示遮罩的动画
 *  @arg  containerBounds     浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight      键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  contentViewFrame    动画执行完后`contentView`的最终frame，若使用了`layoutBlock`，则也即`layoutBlock`计算完后的frame
 *  @arg  completion          动画结束后给到modalController的回调，modalController会在这个回调里做一些状态设置，务必调用。
 */
@property(nonatomic, copy) void (^showingAnimation)(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, CGRect contentViewFrame, void(^completion)(BOOL finished));

/**
 *  管理自定义的隐藏动画，需要管理的对象包括`contentView`和`dimmingView`，在动画结束后，必须调用参数里的`completion` block。
 *  @arg  dimmingView         背景遮罩的View，请自行设置隐藏遮罩的动画
 *  @arg  containerBounds     浮层所在的父容器的大小，也即`self.view.bounds`
 *  @arg  keyboardHeight      键盘在当前界面里的高度，若无键盘，则为0
 *  @arg  completion          动画结束后给到modalController的回调，modalController会在这个回调里做一些清理工作，务必调用
 */
@property(nonatomic, copy) void (^hidingAnimation)(UIView *dimmingView, CGRect containerBounds, CGFloat keyboardHeight, void(^completion)(BOOL finished));

/**
 *  请求重新计算浮层的布局
 */
- (void)updateLayout;

/**
 *  将浮层以 UIWindow 的方式显示出来
 *  @param animated    是否以动画的形式显示
 *  @param completion  显示动画结束后的回调
 */
- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将浮层隐藏掉
 *  @param animated    是否以动画的形式隐藏
 *  @param completion  隐藏动画结束后的回调
 *  @warning 这里的`completion`只会在你显式调用`hideWithAnimated:completion:`方法来隐藏浮层时会被调用，如果你通过点击`dimmingView`来触发`hideWithAnimated:completion:`，则completion是不会被调用的，那种情况下如果你要在浮层隐藏后做一些事情，请使用`delegate`提供的`didHideModalPresentationViewController:`方法。
 */
- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将浮层以 addSubview 的方式显示出来
 *
 *  @param view         要显示到哪个 view 上
 *  @param animated     是否以动画的形式显示
 *  @param completion   显示动画结束后的回调
 */
- (void)showInView:(UIView *)view animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

/**
 *  将某个 view 上显示的浮层隐藏掉
 *  @param view         要隐藏哪个 view 上的浮层
 *  @param animated     是否以动画的形式隐藏
 *  @param completion   隐藏动画结束后的回调
 *  @warning 这里的`completion`只会在你显式调用`hideInView:animated:completion:`方法来隐藏浮层时会被调用，如果你通过点击`dimmingView`来触发`hideInView:animated:completion:`，则completion是不会被调用的，那种情况下如果你要在浮层隐藏后做一些事情，请使用`delegate`提供的`didHideModalPresentationViewController:`方法。
 */
- (void)hideInView:(UIView *)view animated:(BOOL)animated completion:(void (^)(BOOL finished))completion;

@end


@interface SAModalPresentationViewController (Manager)

/**
 *  判断当前App里是否有modalViewController正在显示（存在modalViewController但不可见的时候，也视为不存在）
 *  @return 只要存在正在显示的浮层，则返回YES，否则返回NO
 */
+ (BOOL)isAnyModalPresentationViewControllerVisible;

/**
 *  把所有正在显示的并且允许被隐藏的modalViewController都隐藏掉
 *  @return 只要遇到一个正在显示的并且不能被隐藏的浮层，就会返回NO，否则都返回YES，表示成功隐藏掉所有可视浮层
 *  @see    shouldHideModalPresentationViewController:
 */
+ (BOOL)hideAllVisibleModalPresentationViewControllerIfCan;
@end

@interface SAModalPresentationViewController (UIAppearance)

+ (instancetype)appearance;

@end

/// 专用于SAModalPresentationViewController的UIWindow，这样才能在`[[UIApplication sharedApplication] windows]`里方便地区分出来
@interface SAModalPresentationWindow : UIWindow

@end


@interface UIViewController (SAModalPresentationViewController)

/**
 *  获取弹出当前 vieController 的 SAModalPresentationViewController
 */
@property(nonatomic, weak, readonly) SAModalPresentationViewController *qmui_modalPresentationViewController;

- (UIViewController *)sa_visibleViewControllerIfExist;
@end

@interface SAModalPresentationViewController(Helper)

+ (void)dimmedApplicationWindow;
+ (void)resetDimmedApplicationWindow;
+ (UIViewController *)visibleViewController;

+ (CGFloat)keyboardHeightWithNotification:(NSNotification *)notification inView:(UIView *)view;

@end