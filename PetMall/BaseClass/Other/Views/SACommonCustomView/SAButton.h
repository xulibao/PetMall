#import <UIKit/UIKit.h>

//Modify from QMUI

NS_ASSUME_NONNULL_BEGIN

/// 控制图片在UIButton里的位置，默认为SAButtonImagePositionLeft
typedef NS_ENUM(NSUInteger, SAButtonImagePosition) {
    SAButtonImagePositionTop,             // imageView在titleLabel上面
    SAButtonImagePositionLeft,            // imageView在titleLabel左边
    SAButtonImagePositionBottom,          // imageView在titleLabel下面
    SAButtonImagePositionRight,           // imageView在titleLabel右边
};

/**
 *  提供以下功能：
 *  1. highlighted、disabled 状态均通过改变整个按钮的alpha来表现，无需分别设置不同 state 下的 titleColor、image。alpha 的值可在配置表里修改 ButtonHighlightedAlpha、ButtonDisabledAlpha。
 *  2. 支持点击时改变背景色颜色（highlightedBackgroundColor）
 *  3. 支持点击时改变边框颜色（highlightedBorderColor）
 *  4. 支持设置图片相对于 titleLabel 的位置（imagePosition）
 *  5. 支持设置图片和 titleLabel 之间的间距，无需自行调整 titleEdgeInests、imageEdgeInsets（spacingBetweenImageAndTitle）
 *  @warning SAButton 重新定义了 UIButton.titleEdgeInests、imageEdgeInsets、contentEdgeInsets 这三者的布局逻辑，sizeThatFits: 里会把 titleEdgeInests 和 imageEdgeInsets 也考虑在内（UIButton 不会），以使这三个接口的使用更符合直觉。
 */

@interface SAButton : UIButton

/**
 * 让按钮的文字颜色自动跟随tintColor调整（系统默认titleColor是不跟随的）<br/>
 * 默认为NO
 */
@property(nonatomic, assign) IBInspectable BOOL adjustsTitleTintColorAutomatically;

/**
 * 让按钮的图片颜色自动跟随tintColor调整（系统默认image是需要更改renderingMode才可以达到这种效果）<br/>
 * 默认为NO
 */
@property(nonatomic, assign) IBInspectable BOOL adjustsImageTintColorAutomatically;

/**
 *  等价于 adjustsTitleTintColorAutomatically = YES & adjustsImageTintColorAutomatically = YES & tintColor = xxx
 *  @note 一般只使用这个属性的 setter，而 getter 永远返回 self.tintColor
 *  @warning 不支持传 nil
 */
@property(nonatomic, strong) IBInspectable UIColor *tintColorAdjustsTitleAndImage;

/**
 * 是否自动调整highlighted时的按钮样式，默认为YES。<br/>
 * 当值为YES时，按钮highlighted时会改变自身的alpha属性为<b>ButtonHighlightedAlpha</b>
 */
@property(nonatomic, assign) IBInspectable BOOL adjustsButtonWhenHighlighted;

/**
 * 是否自动调整disabled时的按钮样式，默认为YES。<br/>
 * 当值为YES时，按钮disabled时会改变自身的alpha属性为<b>ButtonDisabledAlpha</b>
 */
@property(nonatomic, assign) IBInspectable BOOL adjustsButtonWhenDisabled;

/**
 * 设置按钮点击时的背景色，默认为nil。
 * @warning 不支持带透明度的背景颜色。当设置highlightedBackgroundColor时，会强制把adjustsButtonWhenHighlighted设为NO，避免两者效果冲突。
 * @see adjustsButtonWhenHighlighted
 */
@property(nonatomic, strong, nullable) IBInspectable UIColor *highlightedBackgroundColor;

/**
 * 设置按钮点击时的边框颜色，默认为nil。
 * @warning 当设置highlightedBorderColor时，会强制把adjustsButtonWhenHighlighted设为NO，避免两者效果冲突。
 * @see adjustsButtonWhenHighlighted
 */
@property(nonatomic, strong, nullable) IBInspectable UIColor *highlightedBorderColor;

/**
 * 设置按钮里图标和文字的相对位置，默认为SAButtonImagePositionLeft<br/>
 * 可配合imageEdgeInsets、titleEdgeInsets、contentHorizontalAlignment、contentVerticalAlignment使用
 */
@property(nonatomic, assign) SAButtonImagePosition imagePosition;

/**
 * 设置按钮里图标和文字之间的间隔，会自动响应 imagePosition 的变化而变化，默认为0。<br/>
 * 系统默认实现需要同时设置 titleEdgeInsets 和 imageEdgeInsets，同时还需考虑 contentEdgeInsets 的增加（否则不会影响布局，可能会让图标或文字溢出或挤压），使用该属性可以避免以上情况。<br/>
 * @warning 会与 imageEdgeInsets、 imageEdgeInsets、 contentEdgeInsets 共同作用。
 */
@property(nonatomic, assign) IBInspectable CGFloat spacingBetweenImageAndTitle;

@end

/**
 *  支持显示下划线的按钮，可用于需要链接的场景。下划线默认和按钮宽度一样，可通过 `underlineInsets` 调整。
 */
@interface SALinkButton : SAButton

/// 控制下划线隐藏或显示，默认为NO，也即显示下划线
@property(nonatomic, assign) IBInspectable BOOL underlineHidden;

/// 设置下划线的宽度，默认为 1
@property(nonatomic, assign) IBInspectable CGFloat underlineWidth;

/// 控制下划线颜色，若设置为nil，则使用当前按钮的titleColor的颜色作为下划线的颜色。默认为 nil。
@property(nonatomic, strong, nullable) IBInspectable UIColor *underlineColor;

/// 下划线的位置是基于 titleLabel 的位置来计算的，默认x、width均和titleLabel一致，而可以通过这个属性来调整下划线的偏移值。默认为UIEdgeInsetsZero。
@property(nonatomic, assign) UIEdgeInsets underlineInsets;

@end

/**
 *  用于 `SAGhostButton.cornerRadius` 属性，当 `cornerRadius` 为 `SAGhostButtonCornerRadiusAdjustsBounds` 时，`SAGhostButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
extern const CGFloat SAGhostButtonCornerRadiusAdjustsBounds;

/**
 *  “幽灵”按钮，也即背景透明、带圆角边框的按钮
 *
 *  可通过 `SAGhostButtonColor` 设置几种预设的颜色，也可以用 `ghostColor` 设置自定义颜色。
 *
 *  @warning 默认情况下，`ghostColor` 只会修改文字和边框的颜色，如果需要让 image 也跟随 `ghostColor` 的颜色，则可将 `adjustsImageWithGhostColor` 设为 `YES`
 */
@interface SAGhostButton : SAButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *ghostColor;    // 默认为 GhostButtonColorBlue
@property(nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR;    // 默认为 1pt
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;   // 默认为 SAGhostButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。

/**
 *  控制按钮里面的图片是否也要跟随 `ghostColor` 一起变化，默认为 `NO`
 */
@property(nonatomic, assign) BOOL adjustsImageWithGhostColor UI_APPEARANCE_SELECTOR;

//- (instancetype)initWithGhostType:(SAGhostButtonColor)ghostType;
- (instancetype)initWithGhostColor:(nullable UIColor *)ghostColor;

@end


/**
 *  用于 `SAFillButton.cornerRadius` 属性，当 `cornerRadius` 为 `SAFillButtonCornerRadiusAdjustsBounds` 时，`SAFillButton` 会在高度变化时自动调整 `cornerRadius`，使其始终保持为高度的 1/2。
 */
extern const CGFloat SAFillButtonCornerRadiusAdjustsBounds;

/**
 *  SAFillButton
 *  实心填充颜色的按钮，支持预定义的几个色值
 */
@interface SAFillButton : SAButton

@property(nonatomic, strong, nullable) IBInspectable UIColor *fillColor; // 默认为 FillButtonColorBlue
@property(nonatomic, strong, nullable) IBInspectable UIColor *titleTextColor; // 默认为 UIColorWhite
@property(nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR;// 默认为 SAFillButtonCornerRadiusAdjustsBounds，也即固定保持按钮高度的一半。

/**
 *  控制按钮里面的图片是否也要跟随 `titleTextColor` 一起变化，默认为 `NO`
 */
@property(nonatomic, assign) BOOL adjustsImageWithTitleTextColor UI_APPEARANCE_SELECTOR;

//- (instancetype)initWithFillType:(SAFillButtonColor)fillType;
//- (instancetype)initWithFillType:(SAFillButtonColor)fillType frame:(CGRect)frame;
- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor;
- (instancetype)initWithFillColor:(nullable UIColor *)fillColor titleTextColor:(nullable UIColor *)textColor frame:(CGRect)frame;

@end

@interface SAGradientButton : SAButton

@property(nonatomic, strong) CAGradientLayer *gradientLayer;

@end

NS_ASSUME_NONNULL_END

//typedef NS_ENUM(NSUInteger, SAGhostButtonColor) {
//    SAGhostButtonColorBlue,
//    SAGhostButtonColorRed,
//    SAGhostButtonColorGreen,
//    SAGhostButtonColorGray,
//    SAGhostButtonColorWhite,
//};
//
//typedef NS_ENUM(NSUInteger, SAFillButtonColor) {
//    SAFillButtonColorBlue,
//    SAFillButtonColorRed,
//    SAFillButtonColorGreen,
//    SAFillButtonColorGray,
//    SAFillButtonColorWhite,
//};
//
//typedef NS_ENUM(NSUInteger, SANavigationButtonType) {
//    SANavigationButtonTypeNormal,         // 普通导航栏文字按钮
//    SANavigationButtonTypeBold,           // 导航栏加粗按钮
//    SANavigationButtonTypeImage,          // 图标按钮
//    SANavigationButtonTypeBack            // 自定义返回按钮(可以同时带有title)
//};
//
//typedef NS_ENUM(NSUInteger, SAToolbarButtonType) {
//    SAToolbarButtonTypeNormal,            // 普通工具栏按钮
//    SAToolbarButtonTypeRed,               // 工具栏红色按钮，用于删除等警告性操作
//    SAToolbarButtonTypeImage,              // 图标类型的按钮
//};
//
//typedef NS_ENUM(NSInteger, SANavigationButtonPosition) {
//    SANavigationButtonPositionNone = -1,  // 不处于navigationBar最左（右）边的按钮，则使用None。用None则不会在alignmentRectInsets里调整位置
//    SANavigationButtonPositionLeft,       // 用于leftBarButtonItem，如果用于leftBarButtonItems，则只对最左边的item使用，其他item使用SANavigationButtonPositionNone
//    SANavigationButtonPositionRight,      // 用于rightBarButtonItem，如果用于rightBarButtonItems，则只对最右边的item使用，其他item使用SANavigationButtonPositionNone
//};
