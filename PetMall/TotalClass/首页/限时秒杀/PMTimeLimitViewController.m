//
//  PMTimeLimitViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMTimeLimitViewController.h"

@interface PMTimeLimitViewController ()

@end

@implementation PMTimeLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
    NSString * title = @"08:00\n已结束";
//    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:title];
//    NSRange topRange = [title rangeOfString:@"08:00"];
//    NSRange bottomRange = [title rangeOfString:@"已结束"];
//
//    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:topRange];
//    [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:bottomRange];
    PMTimeLimitListViewController *vc0 = [[PMTimeLimitListViewController alloc] init];
//    vc0.type = PMMyCouponType_notUsed;
    vc0.title = title;
    PMTimeLimitListViewController *vc1 = [[PMTimeLimitListViewController alloc] init];
    vc1.title = @"10:00\n已结束";
//    vc1.type = PMMyCouponType_Used;
    PMTimeLimitListViewController *vc2 = [[PMTimeLimitListViewController alloc] init];
//    vc2.type = PMMyCouponType_Expired;
    vc2.title = @"12:00\n秒杀中";
    PMTimeLimitListViewController *vc3 = [[PMTimeLimitListViewController alloc] init];
    //    vc2.type = PMMyCouponType_Expired;
    vc3.title = @"14:00\n即将开始";
    PMTimeLimitListViewController *vc4 = [[PMTimeLimitListViewController alloc] init];
    //    vc2.type = PMMyCouponType_Expired;
    vc4.title = @"16:00\n即将开始";
    self.viewControllers = @[vc0, vc1, vc2,vc3,vc4];
}

- (void)initSegment {
    [super initSegment];
    self.segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    
    self.segment.titleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
                                    NSForegroundColorAttributeName: UIColorFromRGB(0x333333)
                                    };
    self.segment.selectedTitleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
                                            NSForegroundColorAttributeName: kColorBGRed
                                            };
}
@end

@implementation PMTimeLimitListViewController

@end
