//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleViewController.h"
#import "PMGoodSaleDetailViewController.h"
#import "PMGoodsItem.h"
#import "DCSlideshowHeadView.h"
@interface PMGoodSaleViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMGoodSaleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"潮品预售";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    imageView.image = IMAGE(@"123123313111111");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    [self requestPOST:API_Dogfood_presale parameters:@{@"pagenum":@(self.page),@"pagesize":@(10),@"fenl":@"2"} success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = [PMGoodsItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        [self setItems:self.dataArray];
        DCSlideshowHeadView * header = [[DCSlideshowHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
        NSMutableArray * imageArray = [@[] mutableCopy];
        for (NSDictionary *imgDic in responseObject[@"result"][@"img"]) {
            [imageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host], imgDic[@"img"]]];
        }
        header.imageGroupArray = imageArray;
        //        [imageView setImageWithURL:[NSURL URLWithString:imageStr] placeholder:IMAGE(@"tuangou_header")];
        self.tableView.tableHeaderView = header;
        self.tableView.mj_header.hidden = YES;
    } failure:NULL];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    
    PMGoodSaleDetailViewController * vc = [PMGoodSaleDetailViewController new];
    PMGoodsItem * goodItem = (PMGoodsItem *)item;
    vc.list_id = goodItem.list_id;
    vc.goods_id = goodItem.goodId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
