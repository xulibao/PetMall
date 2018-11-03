//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyGroupPurchaseViewController.h"
#import "PMHomeModel.h"
#import "PMGroupPurchaserDetailViewController.h"
@interface PMMyGroupPurchaseViewController()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation PMMyGroupPurchaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的团购";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}



#pragma mark - Request

- (void)fetchData {
    
    [self requestMethod:GARequestMethodPOST URLString:API_Dogfood_goupbuy parameters:@{@"user_id":[SAApplication userID]} resKeyPath:@"result" resArrayClass:[PMGroupModel class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
    
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    
    PMGroupPurchaserDetailViewController * vc = [PMGroupPurchaserDetailViewController new];
    PMGroupModel * goodsItem = (PMGroupModel *)item;
    vc.goods_id = goodsItem.groupId;
//    vc.list_id  = goodsItem.list_id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
