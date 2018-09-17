//
//  PMTimeLimitViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMTimeLimitViewController.h"
#import "PMCommonGoodsItem.h"
@interface PMTimeLimitViewController ()

@end

@implementation PMTimeLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
 
    PMTimeLimitListViewController *vc0 = [[PMTimeLimitListViewController alloc] init];
//    vc0.type = PMMyCouponType_notUsed;
    vc0.title = @"08:00\n已结束";
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
    self.segment.selectedSegmentIndex = 2;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    NSString * title = @"08:00\n已结束";
//
//    self.titles = @[attStr,
//                    attStr,
//                    attStr,
//                    attStr,
//                    attStr
//                    ];
}

- (void)initSegment {
    [super initSegment];
   
    self.segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    [self.segment setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange topRange = NSMakeRange(0, 5);
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:topRange];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(topRange.length, title.length - 5)];
        if (selected) {
                [attStr addAttributes:@{NSForegroundColorAttributeName:kColorFF5554} range:NSMakeRange(0, title.length)];
        }else{
            if (index == 0 || index == 1) {
                [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, title.length)];
            }
        }
      
        return attStr;
    }];
//
//    self.segment.titleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
//                                    NSForegroundColorAttributeName: UIColorFromRGB(0x333333)
//                                    };
//    self.segment.selectedTitleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
//                                            NSForegroundColorAttributeName: kColorBGRed
//                                            };
}
@end
@interface PMTimeLimitListViewController()

@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation PMTimeLimitListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self fetchData];
    self.tableView.mj_header.hidden = YES;
}

- (void)refreshingAction {
    [self fetchData];
}



#pragma mark - Request

- (void)fetchData {
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}
@end
