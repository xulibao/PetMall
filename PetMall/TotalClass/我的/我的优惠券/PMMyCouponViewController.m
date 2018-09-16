//
//  PMMyCouponViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCouponViewController.h"
@interface PMMyCouponViewController ()

@end

@implementation PMMyCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"优惠券";
    PMMyCouponListViewController *vc0 = [[PMMyCouponListViewController alloc] init];
    vc0.type = PMMyCouponType_notUsed;
    vc0.title = @"未使用";
    PMMyCouponListViewController *vc1 = [[PMMyCouponListViewController alloc] init];
    vc1.title = @"已使用";
    vc1.type = PMMyCouponType_Used;
    PMMyCouponListViewController *vc2 = [[PMMyCouponListViewController alloc] init];
    vc2.type = PMMyCouponType_Expired;
    vc2.title = @"已过期";
    self.viewControllers = @[vc0, vc1, vc2];
}

- (void)initSegment {
    [super initSegment];
    self.segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
}
@end
@interface PMMyCouponListViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMyCouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header.hidden = YES;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}



#pragma mark - Request

- (void)fetchData {
    self.dataArray = [NSMutableArray array];
    PMMyCouponItem * model = [PMMyCouponItem new];
    model.price = @"10";
    model.type = self.type;
    [self.dataArray addObject:model];
    model = [PMMyCouponItem new];
    model.price = @"20";
    model.type = self.type;
    [self.dataArray addObject:model];
    model = [PMMyCouponItem new];
    model.price = @"30";
    model.type = self.type;
    [self.dataArray addObject:model];
    model = [PMMyCouponItem new];
    model.price = @"40";
    model.type = self.type;
    [self.dataArray addObject:model];
        model = [PMMyCouponItem new];
    model.price = @"50";
    model.type = self.type;
            [self.dataArray addObject:model];
    [self setItems:self.dataArray];
}

@end
