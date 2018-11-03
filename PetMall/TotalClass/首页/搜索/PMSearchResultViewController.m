//
//  PMSearchResultViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSearchResultViewController.h"
#import "PMGoodsItem.h"
#import "DCGoodBaseViewController.h"
@interface PMSearchResultViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}

#pragma mark - Request

- (void)fetchData {
    [self requestMethod:GARequestMethodPOST URLString:API_Classification_sort parameters:@{@"pagenum":@(self.page),@"pagesize":@"10"} resKeyPath:@"result" resArrayClass:[PMGoodsItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];

    } failure:NULL];
}
- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMGoodsItem * goodsItem = (PMGoodsItem *)item;
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = goodsItem.goodId;
    vc.list_id  = goodsItem.list_id;
    [self.navigationController pushViewController:vc  animated:YES];
}
@end
