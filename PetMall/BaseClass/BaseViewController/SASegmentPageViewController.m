//
//  SASegmentPageViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SASegmentPageViewController.h"
#import "STCGUtilities.h"

@interface SASegmentPageViewController ()

@property(nonatomic, weak) UIViewController *pendingViewController;

@end

@implementation SASegmentPageViewController
@synthesize titles = _titles;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutSegment];
}

- (void)initSubviews {
    [super initSubviews];
    [self initSegment];
}

- (BOOL)shouldHiddenSystemNavgation {
    return NO;
}

- (NSArray<NSString *> *)titles {
    return self.segment.sectionTitles;
}

#pragma mark - UIPageViewControllerDelegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    self.pendingViewController = [pendingViewControllers firstObject];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    UIViewController *vc = [previousViewControllers firstObject];
    if (completed && self.pendingViewController != vc) {
        NSInteger index = [self.viewControllers indexOfObject:self.pendingViewController];
        [self.segment setSelectedSegmentIndex:index animated:self.segment.shouldAnimateUserSelection];
    } else {
        self.pendingViewController = [previousViewControllers firstObject];
    }
}


#pragma mark - Setter

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [self layoutSegment];
    self.segment.sectionTitles = titles;
}

- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    [super setViewControllers:viewControllers];
    NSMutableArray *titles = [@[] mutableCopy];
    for (UIViewController *vc in viewControllers) {
        if (vc.title) {
            [titles addObject:vc.title];
        }
    }
    [self setTitles:titles];
}

@end

@implementation SASegmentPageViewController (SubclassingHooks)

- (void)initSegment {
    SACommonSegment *segment = [[SACommonSegment alloc] init];
    _segment = segment;
    segment.layer.borderColor = kColorBGRed.CGColor;
    segment.layer.cornerRadius = 10.f / 2;
    segment.layer.borderWidth = 1;
    segment.clipsToBounds = YES;
    segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    segment.shouldAnimateUserSelection = NO;
    segment.selectionStyle = HMSegmentedControlSelectionStyleBox;
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    segment.selectionIndicatorBoxColor = kColorBGRed;
    segment.selectionIndicatorBoxOpacity = 1;
    segment.titleTextAttributes = @{NSFontAttributeName: UIFontMake(13),
                                    NSForegroundColorAttributeName: UIColorFromRGB(0x333333)
                                    };
    segment.selectedTitleTextAttributes = @{NSFontAttributeName: UIFontMake(13),
                                            NSForegroundColorAttributeName: [UIColor whiteColor]
                                            };
    [self.navigationItem setTitleView:segment];

    [segment addTarget:self
                 action:@selector(pageControlValueChanged:)
       forControlEvents:UIControlEventValueChanged];
}

- (void)layoutSegment {
    NSString *maxLengthText = nil;
    for (NSString *title in self.titles) {
        if (title.length > maxLengthText.length) {
            maxLengthText = title;
        }
    }
    if (maxLengthText) {
        CGSize size = [maxLengthText sizeWithAttributes:self.segment.titleTextAttributes];
        
        self.segment.frame = CGRectMake(0, 0, (size.width + UIEdgeInsetsGetHorizontalValue(self.segment.segmentEdgeInset) + 5) * self.titles.count, UIEdgeInsetsGetVerticalValue(self.segment.segmentEdgeInset) + 25);
    }
}

#pragma mark HMSegmentedControl target

- (void)pageControlValueChanged:(SACommonSegment *)sender {
    NSInteger index = sender.selectedSegmentIndex;
    UIViewController *vc = self.viewControllers[index];
    [self.pageViewController setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
}

@end
