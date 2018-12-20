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
#import "PMConfirmPayViewController.h"
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
    
    switch ([self.status integerValue]) {
        case 1:{
            [self.bottomView.tagBtn setTitle:@"取消订单" forState:UIControlStateNormal];
             [self.bottomView.tagBtn1 setTitle:@"付款" forState:UIControlStateNormal];
            bottomView.tagBtnBlcok = ^{
                [self PMOrderListCellClickCancle];
            };
            bottomView.tagBtn1Blcok = ^{
                [self PMOrderListCellClickPay];
            };
        }
            break;
        case 2:{
            [self.bottomView.tagBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            bottomView.tagBtnBlcok = ^{
                [self PMOrderListCellClickCancle];
            };
        }
            break;
        case 4:{
            [self.bottomView.tagBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            [self.bottomView.tagBtn1 setTitle:@"评价" forState:UIControlStateNormal];
            bottomView.tagBtnBlcok = ^{
                [self PMOrderListCellClickConfirm];
            };
            bottomView.tagBtn1Blcok = ^{
                [self PMOrderListCellClickComment];
            };
        }
            break;
            
        default:
            break;
    }
    bottomView.copyBlcok = ^{
        [self showSuccess:@"复制成功!"];
    };
    self.tableView.tableFooterView = bottomView;
}

//退款
- (void)PMOrderListCellClickRefund{
    [self requestPOST:API_User_refund parameters:@{@"id":self.order_no} success:^(__kindof SARequest *request, id responseObject) {
        [self fetchData];
    } failure:NULL];
}
//取消
- (void)PMOrderListCellClickCancle{
    [self requestPOST:API_Goods_cancellation parameters:@{@"order_id":self.order_no} success:^(__kindof SARequest *request, id responseObject) {
        [self fetchData];
    } failure:NULL];
}
//支付
- (void)PMOrderListCellClickPay{
    PMConfirmPayViewController * vc = [[PMConfirmPayViewController alloc] init];
    vc.order_no = self.order_no;
    vc.price = [NSString stringWithFormat:@"%@",self.pay_price];
    [self.navigationController pushViewController:vc animated:YES];
}
//确认收货
- (void)PMOrderListCellClickConfirm{
    [self requestPOST:API_user_receip parameters:@{@"order_no":self.order_no,@"user_id":[SAApplication userID]} success:^(__kindof SARequest *request, id responseObject) {
        [self fetchData];
    } failure:NULL];
}
//评论
- (void)PMOrderListCellClickComment{
    PMSendCommentViewController * vc =[PMSendCommentViewController new];
    [self pushViewController:vc];
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
