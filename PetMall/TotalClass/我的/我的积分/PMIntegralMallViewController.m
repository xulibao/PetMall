//
//  PMIntegralMallViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMIntegralMallViewController.h"
#import "PMCommonGoodsItem.h"

@interface PMIntegralMallViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMIntegralMallViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分商城";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    imageView.image = IMAGE(@"mine_integralMall");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}

@end
