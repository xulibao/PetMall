//
//  SABillRecordViewController.m
//  SnailAuction
//
//  Created by imeng on 01/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "PMOrderViewController.h"
#import "PMOrderListItem.h"
#import "PMOrderDetailViewController.h"
#import "PMSendCommentViewController.h"
#import "PMConfirmPayViewController.h"
@interface PMOrderViewController ()

@end

@implementation PMOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的订单";
    
    PMOrderListViewController *vc0 = [[PMOrderListViewController alloc] init];
    vc0.type = PMOrderOrderTypeAll;
    vc0.title = @"全部";
    PMOrderListViewController *vc1 = [[PMOrderListViewController alloc] init];
    vc1.type = PMOrderOrderTypePayment;
    vc1.title = @"待付款";
    PMOrderListViewController *vc2 = [[PMOrderListViewController alloc] init];
    vc2.type = PMOrderOrderTypeTransfer;
    vc2.title = @"待发货";
    PMOrderListViewController *vc3 = [[PMOrderListViewController alloc] init];
    vc3.type = PMOrderOrderTypeComment;
    vc3.title = @"待评价";
    self.viewControllers = @[vc0, vc1, vc2,vc3];
    if (self.type == PMOrderOrderTypeComment) {
         [self.segment setSelectedSegmentIndex:3 animated:YES];
    }else{
         [self.segment setSelectedSegmentIndex:self.type animated:YES];
    }
   
}

- (void)initSegment {
    [super initSegment];
    self.segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
}

@end

@interface PMOrderListViewController()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMOrderListViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (instancetype)initWithType:(PMOrderOrderType)type {
    if (self = [super init]) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.cellDelegate =self;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}

- (void)PMOrderListCellClick{
    PMSendCommentViewController * vc =[PMSendCommentViewController new];
    [self pushViewController:vc];
}

- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PMOrderItem * item = [self.viewModel objectAtIndexPath:indexPath];
    
    return 90 + item.order_list.count * 100;
}
#pragma mark - Request

- (void)fetchData {

    NSMutableDictionary * dictM = [@{} mutableCopy];
    [dictM setObject:[SAApplication userID] forKey:@"user_id"];
    if (self.type != PMOrderOrderTypeAll) {
        [dictM setObject:@(self.type) forKey:@"status"];

    }
    [self requestMethod:GARequestMethodPOST
              URLString:API_Goods_myorder
             parameters:dictM
             resKeyPath:@"result"
          resArrayClass:[PMOrderItem class]
                  retry:YES
                success:^(__kindof SARequest *request, NSArray<PMOrderItem*> *responseObject) {
                    [self setItems:responseObject];
                }
                failure:NULL];
}

#pragma mark - Override SAInfoListViewController

- (void)didSelectCellWithItem:(PMOrderItem *)item {
    PMOrderDetailViewController *vc = [[PMOrderDetailViewController alloc] init];
    vc.order_no = item.order_no;
    [self pushViewController:vc];
}
//退款
- (void)PMOrderListCellClickRefund:(PMOrderListCell *)cell{
    [self requestPOST:API_User_refund parameters:@{@"id":cell.item.order_no} success:^(__kindof SARequest *request, id responseObject) {
        [self fetchData];
    } failure:NULL];
}
//取消
- (void)PMOrderListCellClickCancle:(PMOrderListCell *)cell{
    [self requestPOST:API_Goods_cancellation parameters:@{@"order_id":cell.item.order_no} success:^(__kindof SARequest *request, id responseObject) {
        [self fetchData];
    } failure:NULL];
}
//支付
- (void)PMOrderListCellClickPay:(PMOrderListCell *)cell{
    PMConfirmPayViewController * vc = [[PMConfirmPayViewController alloc] init];
    vc.order_no = cell.item.order_no;
    vc.price = [NSString stringWithFormat:@"%@",cell.item.pay_price];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
