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
        PMOrderListItem *recommendItem = [[PMOrderListItem alloc] init];
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        [_dataArray addObject:recommendItem];
        
        
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
                recommendItem.goods_title = @"GO猫粮 抗敏美毛系列全 全新包装营养配方 25磅";
                recommendItem.nature = @"3.06kg  牛肉味";
                recommendItem.price = @"158";
                recommendItem.people_count = @"2";
            recommendItem.orderNo = @"1234818510";
            recommendItem.statusText = @"买家已付款";
                [_dataArray addObject:recommendItem];
        
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO猫粮 抗敏美毛系列全 全新包装营养配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        recommendItem.orderNo = @"1234851310";
        recommendItem.statusText = @"买家已付款";
        [_dataArray addObject:recommendItem];
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


#pragma mark - Request

- (void)fetchData {
        [self setItems:self.dataArray];

//    [self requestMethod:GARequestMethodGET
//              URLString:API_mine_orderList
//             parameters:@{@"userId":[SAApplication userID],
//                          @"auctionState":type
//                          }
//             resKeyPath:@"data"
//          resArrayClass:[SAOrderListItem class]
//                  retry:YES
//                success:^(__kindof SARequest *request, NSArray<SAOrderListItem*> *responseObject) {
//                    [self setItems:responseObject];
//                }
//                failure:NULL];
}

#pragma mark - Override SAInfoListViewController

- (void)didSelectCellWithItem:(PMOrderListItem *)item {
    PMOrderDetailViewController *vc = [[PMOrderDetailViewController alloc] init];

    [self pushViewController:vc];
}


@end
