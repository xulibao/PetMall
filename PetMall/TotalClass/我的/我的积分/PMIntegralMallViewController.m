//
//  PMIntegralMallViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMIntegralMallViewController.h"
#import "PMIntegralMallItem.h"
#import "PMIntegralMallCell.h"
#import "PMIntegralMallDetailViewController.h"
#import "SAAlertController.h"
#import "PMIntegralResultViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PMIntegralMallViewController ()<PMIntegralMallCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) UIImageView *headerView;
@end

@implementation PMIntegralMallViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.cellDelegate = self;
    self.title = @"积分商城";
    [self fetchData];
    
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    self.headerView = imageView;
//    imageView.image = IMAGE(@"mine_integralMall");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    
    [self requestMethod:GARequestMethodPOST URLString:API_user_integralmall parameters:@{@"pagesize":@"10",@"pagenum":@(self.page)} success:^(__kindof SARequest *request, id responseObject) {
        NSString * img = responseObject[@"result"][@"img"];
        [self.headerView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[STNetworking host], img]] placeholderImage:IMAGE(@"mine_integralMall")];
        self.dataArray = [PMIntegralMallItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        [self setItems:self.dataArray];
    } failure:NULL];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMIntegralMallItem * mallItem = (PMIntegralMallItem *)item;
    PMIntegralMallDetailViewController * vc = [PMIntegralMallDetailViewController new];
    vc.goods_id = mallItem.integralMallId;
    vc.list_id = mallItem.list_id;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)PMIntegralMallCellDidClick:(PMIntegralMallCell *)cell{
    SAAlertController *alertController = [SAAlertController alertControllerWithTitle:nil
                                                                             message:@"确定用积分兑换此商品吗\n兑换将自动扣除相应积分"
                                                                      preferredStyle:SAAlertControllerStyleAlert];
    SAAlertAction *action = [SAAlertAction actionWithTitle:@"兑换" style:SAAlertActionStyleDefault handler:^(SAAlertAction *action) {
        PMIntegralMallDetailViewController * vc = [PMIntegralMallDetailViewController new];
        vc.goods_id = cell.item.integralMallId;
        vc.list_id = cell.item.list_id;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
    [alertController addAction:action];
    action = [SAAlertAction actionWithTitle:@"取消" style:SAAlertActionStyleCancel handler:^(SAAlertAction *action) {
    }];
    [alertController addAction:action];
    
    [alertController showWithAnimated:YES];
    
}
@end
