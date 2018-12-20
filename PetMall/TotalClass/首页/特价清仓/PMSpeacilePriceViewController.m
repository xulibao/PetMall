//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSpeacilePriceViewController.h"
#import "PMSpeacilePriceItem.h"
#import "PMSpeacilePriceCell.h"
#import "DCSlideshowHeadView.h"
#import "DCGoodBaseViewController.h"
@interface PMSpeacilePriceViewController ()<PMSpeacilePriceCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMSpeacilePriceViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"特价清仓";
    self.viewModel.cellDelegate = self;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    imageView.image = IMAGE(@"12434342423422");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    [self requestPOST:API_Dogfood_presale parameters:@{@"pagenum":@(self.page),@"pagesize":@(10),@"fenl":@"4",@"type":[SAApplication sharedApplication].userType} success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = [PMSpeacilePriceItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
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
    PMSpeacilePriceItem * goodsItem = (PMSpeacilePriceItem *)item;
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = goodsItem.goodId;
    vc.list_id  = goodsItem.list_id;
    [self.navigationController pushViewController:vc  animated:YES];
}
- (void)cellDidAddCart:(PMSpeacilePriceItem *)item{
    [self requestPOST:API_Dogfood_cart parameters:@{@"goods_id":item.goodId,@"user_id":[SAApplication userID],@"type":@"1",@"list_id":item.list_id,@"shul":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"加入购物车成功！"];
    } failure:NULL];
}
@end
