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
@interface PMIntegralMallViewController ()<PMIntegralMallCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;

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
    imageView.image = IMAGE(@"mine_integralMall");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    
    [self requestMethod:GARequestMethodPOST URLString:API_user_integralmall parameters:@{@"pagesize":@"10",@"pagenum":@(self.page)} resKeyPath:@"result" resArrayClass:[PMIntegralMallItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
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
        [self requestPOST:API_Classification_purchase parameters:@{@"goods_id":cell.item.integralMallId,@"user_id":[SAApplication userID],@"list_id":cell.item.list_id,@"shul":@"1",@"type":@"2",@"flag":@"1"} success:^(__kindof SARequest *request, id responseObject) {
            [self showSuccess:responseObject[@"msg"]];
            PMIntegralResultViewController * vc = [PMIntegralResultViewController new];
            [self pushViewController:vc];
        } failure:NULL];
        
    }];
    [alertController addAction:action];
    action = [SAAlertAction actionWithTitle:@"取消" style:SAAlertActionStyleCancel handler:^(SAAlertAction *action) {
    }];
    [alertController addAction:action];
    
    [alertController showWithAnimated:YES];
    
}
@end
