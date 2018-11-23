//
//  PMMyExchangeViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyExchangeViewController.h"
#import "PMMyExchangeItem.h"
#import "PMMyExchangeCell.h"
#import "PMIntegralMallDetailViewController.h"
@interface PMMyExchangeViewController()<PMMyExchangeCellCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation PMMyExchangeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的兑换";
    self.viewModel.cellDelegate = self;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}



#pragma mark - Request

- (void)fetchData {
    [self requestMethod:GARequestMethodPOST URLString:API_user_myexchange parameters:@{@"user_id":[SAApplication userID], @"pagesize":@"10",@"pagenum":@(self.page)} resKeyPath:@"result" resArrayClass:[PMMyExchangeItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
}
- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMMyExchangeItem * mallItem = (PMMyExchangeItem *)item;
    PMIntegralMallDetailViewController * vc = [PMIntegralMallDetailViewController new];
    vc.goods_id = mallItem.exchangeId;
    vc.list_id = mallItem.list_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)PMMyExchangeCellDidClick:(PMMyExchangeCell *)cell{
    PMIntegralMallDetailViewController * vc = [PMIntegralMallDetailViewController new];
    vc.goods_id = cell.item.exchangeId;
    vc.list_id = cell.item.list_id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
