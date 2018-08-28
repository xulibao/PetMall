#import "UIScrollView+SAScrollView.h"
#import "STCGUtilities.h"

@implementation UIScrollView (SAScrollView)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(description), @selector(sa_description));
    });
}

- (NSString *)sa_description {
    return [NSString stringWithFormat:@"%@, contentInset = %@", [self sa_description], NSStringFromUIEdgeInsets(self.contentInset)];
}

- (BOOL)sa_alreadyAtTop {
    if (!self.sa_canScroll) {
        return YES;
    }
    
    if (self.contentOffset.y == -self.sa_contentInset.top) {
        return YES;
    }
    
    return NO;
}

- (BOOL)sa_alreadyAtBottom {
    if (!self.sa_canScroll) {
        return YES;
    }
    
    if (self.contentOffset.y == self.contentSize.height + self.sa_contentInset.bottom - CGRectGetHeight(self.bounds)) {
        return YES;
    }
    
    return NO;
}

- (UIEdgeInsets)sa_contentInset {
    if (@available(iOS 11, *)) {
        return self.adjustedContentInset;
    } else {
        return self.contentInset;
    }
}

- (BOOL)sa_canScroll {
    // 没有高度就不用算了，肯定不可滚动，这里只是做个保护
    if (CGSizeIsEmpty(self.bounds.size)) {
        return NO;
    }
    BOOL canVerticalScroll = self.contentSize.height + UIEdgeInsetsGetVerticalValue(self.sa_contentInset) > CGRectGetHeight(self.bounds);
    BOOL canHorizontalScoll = self.contentSize.width + UIEdgeInsetsGetHorizontalValue(self.sa_contentInset) > CGRectGetWidth(self.bounds);
    return canVerticalScroll || canHorizontalScoll;
}

- (void)sa_scrollToTopForce:(BOOL)force animated:(BOOL)animated {
    if (force || (!force && [self sa_canScroll])) {
        [self setContentOffset:CGPointMake(-self.sa_contentInset.left, -self.sa_contentInset.top) animated:animated];
    }
}

- (void)sa_scrollToTopAnimated:(BOOL)animated {
    [self sa_scrollToTopForce:NO animated:animated];
}

- (void)sa_scrollToTop {
    [self sa_scrollToTopAnimated:NO];
}

- (void)sa_scrollToBottomAnimated:(BOOL)animated {
    if ([self sa_canScroll]) {
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentSize.height + self.sa_contentInset.bottom - CGRectGetHeight(self.bounds)) animated:animated];
    }
}

- (void)sa_scrollToBottom {
    [self sa_scrollToBottomAnimated:NO];
}

- (void)sa_stopDeceleratingIfNeeded {
    if (self.decelerating) {
        [self setContentOffset:self.contentOffset animated:NO];
    }
}

@end
