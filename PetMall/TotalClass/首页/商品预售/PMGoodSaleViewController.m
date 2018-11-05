//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleViewController.h"
#import "PMGoodSaleDetailViewController.h"
#import "PMGoodSaleItem.h"
#import "PMGoodSaleCell.h"
#import "DCSlideshowHeadView.h"
@interface PMGoodSaleViewController ()<PMGoodSaleCellDelegate>

@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) DCSlideshowHeadView * header;
@end

@implementation PMGoodSaleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.cellDelegate = self;
    self.title = @"潮品预售";
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
    [self requestPOST:API_Dogfood_presale parameters:@{@"pagenum":@(self.page),@"pagesize":@(10),@"fenl":@"2"} success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = [PMGoodSaleItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        [self setItems:self.dataArray];
        NSMutableArray * imageArray = [@[] mutableCopy];
        for (NSDictionary *imgDic in responseObject[@"result"][@"img"]) {
            [imageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host], imgDic[@"img"]]];
        }
        self.header.imageGroupArray = imageArray;
    } failure:NULL];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    
    PMGoodSaleDetailViewController * vc = [PMGoodSaleDetailViewController new];
    PMGoodSaleItem * goodItem = (PMGoodSaleItem *)item;
    vc.list_id = goodItem.list_id;
    vc.goods_id = goodItem.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)cellDidAddCart:(PMGoodSaleItem *)item{
    [self requestPOST:API_Dogfood_cart parameters:@{@"goods_id":item.goodId,@"user_id":[SAApplication userID],@"type":@"1",@"list_id":item.list_id,@"shul":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"加入购物车成功！"];
        
    } failure:NULL];

}
@end
