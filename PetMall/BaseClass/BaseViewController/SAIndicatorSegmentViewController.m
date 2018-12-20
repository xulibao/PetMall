//
//  SAIndicatorSegmentViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAIndicatorSegmentViewController.h"

@interface SAIndicatorSegmentViewController ()

@end

@implementation SAIndicatorSegmentViewController

//- (void)viewDidLayoutSubviews {
//    [super viewDidLayoutSubviews];
//}

- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}

- (BOOL)shouldInitSTNavgationBar {
    return YES;
}

- (void)layoutPageView {
    self.pageViewController.view.frame = (CGRect){0, self.viewOrigin.y + 40, self.view.width, self.view.height - self.viewOrigin.y - 40};
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    self.segment.sectionTitles = titles;
}

@end

@implementation SAIndicatorSegmentViewController (SubclassingHooks)

- (void)layoutSegment {
    self.segment.frame = (CGRect){0, self.viewOrigin.y, self.view.width, 40};
}

- (void)initSegment {
    SACommonSegment *segment = [[SACommonSegment alloc] init];
    segment.layer.shadowColor = [UIColor blackColor].CGColor;
    segment.layer.shadowOffset = CGSizeMake(0, 1);
    segment.layer.shadowOpacity = .14f;
    segment.layer.shadowRadius = 3.f;
    
    self.segment = segment;
    if (UI_SCREEN_WIDTH > 320) {
        if (UI_SCREEN_WIDTH > 375) {
            segment.segmentEdgeInset = UIEdgeInsetsMake(0, 13, 0, 13);
        } else {
            segment.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
        }
    }
    //    segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    segment.shouldAnimateUserSelection = YES;
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionIndicatorHeight = 1;
    segment.selectionIndicatorColor = kColorBGRed;
    segment.titleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
                                    NSForegroundColorAttributeName: UIColorFromRGB(0x333333)
                                    };
    segment.selectedTitleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
                                            NSForegroundColorAttributeName: kColorBGRed
                                            };
    [self.view addSubview:segment];
    [segment addTarget:self
                action:@selector(pageControlValueChanged:)
      forControlEvents:UIControlEventValueChanged];
}

@end
