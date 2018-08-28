//
//  SAIndicatorSegmentViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SASegmentPageViewController.h"

@interface SAIndicatorSegmentViewController : SASegmentPageViewController

@end

@interface SAIndicatorSegmentViewController (SubclassingHooks)

- (void)layoutSegment;

- (void)initSegment;

@end
