//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGroupPurchaseViewController.h"
#import "PMGroupPurchaserDetailViewController.h"
#import "PMHomeModel.h"
#import "PMGoodsGroupCell.h"
#import "DCSlideshowHeadView.h"
#import "PMConfirmOrderViewController.h"
@interface PMGroupPurchaseViewController ()<PMGoodsGroupCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) DCSlideshowHeadView * header;

@end

@implementation PMGroupPurchaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.cellDelegate = self;
    self.title = @"团购活动";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    DCSlideshowHeadView * header = [[DCSlideshowHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    self.header = header;
    self.tableView.tableHeaderView = header;
    self.tableView.mj_header.hidden = YES;
}


#pragma mark - Request

- (void)fetchData {
    [self requestPOST:API_Dogfood_grouppurchase parameters:@{@"pagenum":@(self.page),@"pagesize":@(10)} success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = [PMGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        [self setItems:self.dataArray];
        NSMutableArray * imageArray = [@[] mutableCopy];
        for (NSDictionary *imgDic in responseObject[@"result"][@"img"]) {
            [imageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host], imgDic[@"img"]]];
        }
        self.header.imageGroupArray = imageArray;
    } failure:NULL];
    
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item1{
    
    PMGroupPurchaserDetailViewController * vc = [PMGroupPurchaserDetailViewController new];
//    PMCommonGoodsItem * item = self.dataArray[0];
//    vc.goodTitle = @"包退通用牛肉泰迪贵宾金毛比熊幼犬成犬双拼狗粮 5斤10斤";
//    vc.goodPrice = item.price;
//    vc.goodTip= @"26人参团  还差4人";
//    vc.goodSubtitle = @"参团立省7.2元";
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cellDidAddGroup:(PMGroupModel *)item{
//    PMConfirmOrderViewController *vc = [[PMConfirmOrderViewController alloc] init];
//    vc.order_id = item.groupId;
//    vc.cart_id = item.list_id;
//    [self.navigationController pushViewController:vc animated:YES];
    
    [self requestPOST:API_Classification_purchase parameters:@{@"goods_id":item.groupId,@"user_id":[SAApplication userID],@"list_id":item.list_id,@"shul":@"1",@"type":@"1",@"flag":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:responseObject[@"msg"]];
//        PMIntegralResultViewController * vc = [PMIntegralResultViewController new];
//        [self pushViewController:vc];
    } failure:NULL];
}
@end
