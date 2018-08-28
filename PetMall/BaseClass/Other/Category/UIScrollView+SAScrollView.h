#import <UIKit/UIKit.h>

//Modify from QMUI

@interface UIScrollView (SAScrollView)

/// 判断UIScrollView是否已经处于顶部（当UIScrollView内容不够多不可滚动时，也认为是在顶部）
@property(nonatomic, assign, readonly) BOOL sa_alreadyAtTop;

/// 判断UIScrollView是否已经处于底部（当UIScrollView内容不够多不可滚动时，也认为是在底部）
@property(nonatomic, assign, readonly) BOOL sa_alreadyAtBottom;

/// UIScrollView 的真正 inset，在 iOS11 以后需要用到 adjustedContentInset 而在 iOS11 以前只需要用 contentInset
@property(nonatomic, assign, readonly) UIEdgeInsets sa_contentInset;

/**
 * 判断当前的scrollView内容是否足够滚动
 * @warning 避免与<i>scrollEnabled</i>混淆
 */
- (BOOL)sa_canScroll;

/**
 * 不管当前scrollView是否可滚动，直接将其滚动到最顶部
 * @param force 是否无视[self sa_canScroll]而强制滚动
 * @param animated 是否用动画表现
 */
- (void)sa_scrollToTopForce:(BOOL)force animated:(BOOL)animated;

/**
 * 等同于[self sa_scrollToTopForce:NO animated:animated]
 */
- (void)sa_scrollToTopAnimated:(BOOL)animated;

/// 等同于[self sa_scrollToTopAnimated:NO]
- (void)sa_scrollToTop;

/**
 * 如果当前的scrollView可滚动，则将其滚动到最底部
 * @param animated 是否用动画表现
 * @see [UIScrollView sa_canScroll]
 */
- (void)sa_scrollToBottomAnimated:(BOOL)animated;

/// 等同于[self sa_scrollToBottomAnimated:NO]
- (void)sa_scrollToBottom;

// 立即停止滚动，用于那种手指已经离开屏幕但列表还在滚动的情况。
- (void)sa_stopDeceleratingIfNeeded;

@end
