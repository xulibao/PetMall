//
//  SAAlertController.h
//  qmui
//
//  Created by SA Team on 15/7/20.
//  Copyright (c) 2015年 SA Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAModalPresentationViewController;
@class SAButton;
@class SATextField;
@class SAAlertController;


typedef NS_ENUM(NSInteger, SAAlertActionStyle) {
    SAAlertActionStyleDefault = 0,
    SAAlertActionStyleCancel,
    SAAlertActionStyleDestructive
};

typedef NS_ENUM(NSInteger, SAAlertControllerStyle) {
    SAAlertControllerStyleActionSheet = 0,
    SAAlertControllerStyleAlert
};


@protocol SAAlertControllerDelegate <NSObject>

- (void)willShowAlertController:(SAAlertController *)alertController;
- (void)willHideAlertController:(SAAlertController *)alertController;
- (void)didShowAlertController:(SAAlertController *)alertController;
- (void)didHideAlertController:(SAAlertController *)alertController;

@end


/**
 *  SAAlertController的按钮，初始化完通过`SAAlertController`的`addAction:`方法添加到 AlertController 上即可。
 */
@interface SAAlertAction : NSObject

/**
 *  初始化`SAAlertController`的按钮
 *
 *  @param title   按钮标题
 *  @param style   按钮style，跟系统一样，有 Default、Cancel、Destructive 三种类型
 *  @param handler 处理点击时间的block
 *
 *  @return SAAlertController按钮的实例
 */
+ (instancetype)actionWithTitle:(NSString *)title style:(SAAlertActionStyle)style handler:(void (^)(SAAlertAction *action))handler;

/// `SAAlertAction`对应的 button 对象
@property(nonatomic, strong, readonly) SAButton *button;

/// `SAAlertAction`对应的标题
@property(nonatomic, copy, readonly) NSString *title;

/// `SAAlertAction`对应的样式
@property(nonatomic, assign, readonly) SAAlertActionStyle style;

/// `SAAlertAction`是否允许操作
@property(nonatomic, assign, getter=isEnabled) BOOL enabled;

/// `SAAlertAction`按钮样式，默认nil。当此值为nil的时候，则使用`SAAlertController`的`alertButtonAttributes`或者`sheetButtonAttributes`的值。
@property(nonatomic, strong) NSDictionary<NSString *, id> *buttonAttributes;

/// 原理同上`buttonAttributes`
@property(nonatomic, strong) NSDictionary<NSString *, id> *buttonDisabledAttributes;

@end


/**
 *  `SAAlertController`是模仿系统`UIAlertController`的控件，所以系统有的功能在SAAlertController里面基本都有。同时`SAAlertController`还提供了一些扩展功能，例如：它的每个 button 都是开放出来的，可以对默认的按钮进行二次处理（比如加一个图片）；可以通过 appearance 在 app 启动的时候修改整个`SAAlertController`的主题样式。
 */
@interface SAAlertController : UIViewController

/// alert距离屏幕四边的间距，默认UIEdgeInsetsMake(0, 0, 0, 0)。alert的宽度最终是通过屏幕宽度减去水平的 alertContentMargin 和 alertContentMaximumWidth 决定的。
@property(nonatomic, assign) UIEdgeInsets alertContentMargin UI_APPEARANCE_SELECTOR;

/// alert的最大宽度，默认270。
@property(nonatomic, assign) CGFloat alertContentMaximumWidth UI_APPEARANCE_SELECTOR;

/// alert上分隔线颜色，默认UIColorMake(211, 211, 219)。
@property(nonatomic, strong) UIColor *alertSeperatorColor UI_APPEARANCE_SELECTOR;

/// alert标题样式，默认@{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontBoldMake(17),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail]}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertTitleAttributes UI_APPEARANCE_SELECTOR;

/// alert信息样式，默认@{NSForegroundColorAttributeName:UIColorBlack,NSFontAttributeName:UIFontMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail]}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertMessageAttributes UI_APPEARANCE_SELECTOR;

/// alert按钮样式，默认@{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertButtonAttributes UI_APPEARANCE_SELECTOR;

/// alert按钮disabled时的样式，默认@{NSForegroundColorAttributeName:UIColorMake(129, 129, 129),NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertButtonDisabledAttributes UI_APPEARANCE_SELECTOR;

/// alert cancel 按钮样式，默认@{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontBoldMake(17),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertCancelButtonAttributes UI_APPEARANCE_SELECTOR;

/// alert destructive 按钮样式，默认@{NSForegroundColorAttributeName:UIColorRed,NSFontAttributeName:UIFontMake(17),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *alertDestructiveButtonAttributes UI_APPEARANCE_SELECTOR;

/// alert圆角大小，默认值是：IOS_VERSION >= 9.0 ? 13 : 6，以保持与系统默认样式一致
@property(nonatomic, assign) CGFloat alertContentCornerRadius UI_APPEARANCE_SELECTOR;

/// alert按钮高度，默认44pt
@property(nonatomic, assign) CGFloat alertButtonHeight UI_APPEARANCE_SELECTOR;

/// alert头部（非按钮部分）背景色，默认值是：UIColorMakeWithRGBA(247, 247, 247, 1)
@property(nonatomic, strong) UIColor *alertHeaderBackgroundColor UI_APPEARANCE_SELECTOR;

/// alert按钮背景色，默认值同`alertHeaderBackgroundColor`
@property(nonatomic, strong) UIColor *alertButtonBackgroundColor UI_APPEARANCE_SELECTOR;

/// alert按钮高亮背景色，默认UIColorMake(232, 232, 232)
@property(nonatomic, strong) UIColor *alertButtonHighlightBackgroundColor UI_APPEARANCE_SELECTOR;

/// alert头部四边insets间距
@property(nonatomic, assign) UIEdgeInsets alertHeaderInsets UI_APPEARANCE_SELECTOR;

/// alert头部title和message之间的间距，默认3pt
@property(nonatomic, assign) CGFloat alertTitleMessageSpacing UI_APPEARANCE_SELECTOR;

/// alert中textfield高度
@property(nonatomic, assign) CGFloat alertTextFieldHeight;

/// sheet距离屏幕四边的间距，默认UIEdgeInsetsMake(10, 10, 10, 10)。
@property(nonatomic, assign) UIEdgeInsets sheetContentMargin UI_APPEARANCE_SELECTOR;

/// sheet的最大宽度，默认值是5.5英寸的屏幕的宽度减去水平的 sheetContentMargin
@property(nonatomic, assign) CGFloat sheetContentMaximumWidth UI_APPEARANCE_SELECTOR;

/// sheet分隔线颜色，默认UIColorMake(211, 211, 219)
@property(nonatomic, strong) UIColor *sheetSeperatorColor UI_APPEARANCE_SELECTOR;

/// sheet标题样式，默认@{NSForegroundColorAttributeName:UIColorMake(143, 143, 143),NSFontAttributeName:UIFontBoldMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail]}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetTitleAttributes UI_APPEARANCE_SELECTOR;

/// sheet信息样式，默认@{NSForegroundColorAttributeName:UIColorMake(143, 143, 143),NSFontAttributeName:UIFontMake(13),NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:0 lineBreakMode:NSLineBreakByTruncatingTail]}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetMessageAttributes UI_APPEARANCE_SELECTOR;

/// sheet按钮样式，默认@{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetButtonAttributes UI_APPEARANCE_SELECTOR;

/// sheet按钮disabled时的样式，默认@{NSForegroundColorAttributeName:UIColorMake(129, 129, 129),NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetButtonDisabledAttributes UI_APPEARANCE_SELECTOR;

/// sheet cancel 按钮样式，默认@{NSForegroundColorAttributeName:UIColorBlue,NSFontAttributeName:UIFontBoldMake(20),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetCancelButtonAttributes UI_APPEARANCE_SELECTOR;

/// sheet destructive 按钮样式，默认@{NSForegroundColorAttributeName:UIColorRed,NSFontAttributeName:UIFontMake(20),NSKernAttributeName:@(0)}
@property(nonatomic, strong) NSDictionary<NSString *, id> *sheetDestructiveButtonAttributes UI_APPEARANCE_SELECTOR;

/// sheet cancel 按钮距离其上面元素（按钮或者header）的间距，默认8pt
@property(nonatomic, assign) CGFloat sheetCancelButtonMarginTop UI_APPEARANCE_SELECTOR;

/// sheet内容的圆角，默认值是：(IOS_VERSION >= 9.0 ? 13 : 6)，以保持与系统默认样式一致
@property(nonatomic, assign) CGFloat sheetContentCornerRadius UI_APPEARANCE_SELECTOR;

/// sheet按钮高度，默认值是：(IOS_VERSION >= 9.0 ? 57 : 44)，以保持与系统默认样式一致
@property(nonatomic, assign) CGFloat sheetButtonHeight UI_APPEARANCE_SELECTOR;

/// sheet头部（非按钮部分）背景色，默认值是：UIColorMakeWithRGBA(247, 247, 247, 1)
@property(nonatomic, strong) UIColor *sheetHeaderBackgroundColor UI_APPEARANCE_SELECTOR;

/// sheet按钮背景色，默认值同`sheetHeaderBackgroundColor`
@property(nonatomic, strong) UIColor *sheetButtonBackgroundColor UI_APPEARANCE_SELECTOR;

/// sheet按钮高亮背景色，默认UIColorMake(232, 232, 232)
@property(nonatomic, strong) UIColor *sheetButtonHighlightBackgroundColor UI_APPEARANCE_SELECTOR;

/// sheet头部四边insets间距
@property(nonatomic, assign) UIEdgeInsets sheetHeaderInsets UI_APPEARANCE_SELECTOR;

/// sheet头部title和message之间的间距，默认8pt
@property(nonatomic, assign) CGFloat sheetTitleMessageSpacing UI_APPEARANCE_SELECTOR;


/// 默认初始化方法
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(SAAlertControllerStyle)preferredStyle;

/// 通过类方法初始化实例
+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(SAAlertControllerStyle)preferredStyle;

/// @see `SAAlertControllerDelegate`
@property(nonatomic,weak) id<SAAlertControllerDelegate>delegate;

/// 增加一个按钮
- (void)addAction:(SAAlertAction *)action;

// 增加一个“取消”按钮，点击后 alertController 会被 hide
- (void)addCancelAction;

// 增加一个“确定”按钮，点击后 alertController 会被 hide
- (void)addConfirmAction;

/// 增加一个输入框
- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField *textField))configurationHandler;

/// 增加一个自定义的view作为`SAAlertController`的customView
- (void)addCustomView:(UIView *)view;

/// 显示`SAAlertController`
- (void)showWithAnimated:(BOOL)animated;

/// 隐藏`SAAlertController`
- (void)hideWithAnimated:(BOOL)animated;

/// 所有`SAAlertAction`对象
@property(nonatomic, copy, readonly) NSArray <SAAlertAction *> *actions;

/// 当前所有通过`addTextFieldWithConfigurationHandler:`接口添加的输入框
@property(nonatomic, copy, readonly) NSArray <SATextField *> *textFields;

/// 设置自定义view。通过`addCustomView:`方法添加一个自定义的view，`SAAlertController`会在布局的时候去掉用这个view的`sizeThatFits:`方法来获取size，至于x和y坐标则由控件自己控制。
@property(nonatomic, strong, readonly) UIView *customView;

/// 当前标题title
@property(nonatomic, copy) NSString *title;

/// 当前信息message
@property(nonatomic, copy) NSString *message;

/// 当前样式style
@property(nonatomic, assign, readonly) SAAlertControllerStyle preferredStyle;

/// 将`SAAlertController`弹出来的`SAModalPresentationViewController`对象
@property(nonatomic, strong, readonly) SAModalPresentationViewController *modalPresentationViewController;

/**
 *  设置按钮的排序是否要由用户添加的顺序来决定，默认为NO，也即与系统原生`UIAlertController`一致，SAAlertActionStyleDestructive 类型的action必定在最后面。
 *
 *  @warning 注意 SAAlertActionStyleCancel 按钮不受这个属性的影响
 */
@property(nonatomic, assign) BOOL orderActionsByAddedOrdered;

/// maskView是否响应点击，alert默认为NO，sheet默认为YES
@property(nonatomic, assign) BOOL shouldRespondMaskViewTouch;

/// 在 iPhoneX 机器上是否延伸底部背景色。因为在 iPhoneX 上我们会把整个面板往上移动 safeArea 的距离，如果你的面板本来就配置成撑满全屏的样式，那么就会露出底部的空隙，isExtendBottomLayout 可以帮助你把空暇填补上。默认为NO。
/// @warning: 只对 sheet 类型有效
@property(nonatomic, assign) BOOL isExtendBottomLayout UI_APPEARANCE_SELECTOR;

@end


@interface SAAlertController (UIAppearance)

+ (instancetype)appearance;

@end


@interface SAAlertController (Manager)

/// 可方便地判断是否有 alertController 正在显示，全局生效
+ (BOOL)isAnyAlertControllerVisible;

@end
