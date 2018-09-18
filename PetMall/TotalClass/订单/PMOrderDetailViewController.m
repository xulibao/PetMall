//
//  PMOrderDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailViewController.h"
#import "PMLogisticsInformationViewController.h"
#import "PMOrderDetailHeaderView.h"
#import "PMOrderDetailBottomView.h"
#import "PMOrderDetailItem.h"
#import "PMSendCommentViewController.h"
@interface PMOrderDetailViewController ()
@property(nonatomic, strong) PMOrderDetailHeaderView *headerView;

@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMOrderDetailViewController
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        PMOrderDetailItem *recommendItem = [[PMOrderDetailItem alloc] init];
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        [_dataArray addObject:recommendItem];

    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self fectchView];
    [self fetchData];

}

- (void)fectchView{
    self.headerView = [[PMOrderDetailHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 126 * 2 + 8)];
    @weakify(self)
    self.headerView.logisticsInformationBlcok = ^{
        @strongify(self)
        PMLogisticsInformationViewController * vc = [[PMLogisticsInformationViewController alloc] init];
        [self pushViewController:vc];
    };
    self.tableView.tableHeaderView = self.headerView;
    PMOrderDetailBottomView * bottomView = [[PMOrderDetailBottomView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 174)];
    bottomView.copyBlcok = ^{
        [self showSuccess:@"复制成功!"];
    };
    bottomView.commentBlcok = ^{
        PMSendCommentViewController * vc= [PMSendCommentViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    };
    self.tableView.tableFooterView = bottomView;
}

- (void)fetchData {
    [self setItems:self.dataArray];
}

@end
