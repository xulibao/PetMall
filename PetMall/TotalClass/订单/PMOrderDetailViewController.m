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
@property(nonatomic, strong) PMOrderDetailBottomView * bottomView;

@property(nonatomic, strong) NSArray *dataArray;

@end

@implementation PMOrderDetailViewController
- (NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
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
    self.bottomView = bottomView;
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
    [self requestPOST:API_user_details parameters:@{@"user_id":[SAApplication userID],@"order_no":self.order_no} success:^(__kindof SARequest *request, id responseObject) {
        PMOrderDetailModel * detailModel = [PMOrderDetailModel mj_objectWithKeyValues:responseObject[@"result"]];
        self.dataArray = detailModel.goods;
        [self setItems:self.dataArray];
        self.headerView.detailModel = detailModel;
        self.bottomView.infoModel = detailModel.order;
    } failure:NULL];
    
}

@end
