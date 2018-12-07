//
//  PMMyCollectionViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCollectionViewController.h"
#import "PMMyCollectionItem.h"
#import "PMMyCollectionCell.h"
#import "DCGoodBaseViewController.h"
@interface PMMyCollectionViewController ()<PMMyCollectionCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收藏";
    self.viewModel.cellDelegate = self;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}

#pragma mark - Request

- (void)fetchData {
    
    [self requestMethod:GARequestMethodPOST URLString:API_user_collection parameters:@{@"user_id":[SAApplication userID],@"pagesize":@"10",@"pagenum":@(self.page)} resKeyPath:@"result" resArrayClass:[PMMyCollectionItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
}


- (void)cellDidClickDeleteCollection:(PMMyCollectionItem *)item{
    [self requestPOST:API_user_collectiondel parameters:@{@"user_id":[SAApplication userID],@"goods_id":item.collectionId} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:responseObject[@"msg"]];
        [self fetchData];
    } failure:NULL];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMMyCollectionItem * selectItem = (PMMyCollectionItem *)item;
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = selectItem.collectionId;
    vc.list_id  = selectItem.list_id;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
