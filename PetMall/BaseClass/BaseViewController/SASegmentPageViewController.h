//
//  SASegmentPageViewController.h
//  SnailAuction
//
//  Created by imeng on 2018/2/11.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAPageViewController.h"
#import "SACommonSegment.h"

@interface SASegmentPageViewController : SAPageViewController

@property(nonatomic, strong) SACommonSegment *segment;

@property(nonatomic, copy) NSArray<NSString *> *titles;

@end

@interface SASegmentPageViewController (SubclassingHooks)

- (void)initSegment;
- (void)layoutSegment;
- (void)pageControlValueChanged:(SACommonSegment *)sender;

@end
