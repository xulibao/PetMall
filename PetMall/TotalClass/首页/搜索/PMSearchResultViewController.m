//
//  PMSearchResultViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSearchResultViewController.h"
#import "PMGoodsItem.h"
#import "PMGoodsCell.h"
#import "DCGoodBaseViewController.h"
@interface PMSearchResultViewController ()<PMGoodsCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.filterParameters.count == 0) {
        [self.filterParameters setValue:@(self.page) forKey:@"pagenum"];
        [self.filterParameters setValue:@(10) forKey:@"pagesize"];
        [self.filterParameters setValue:[SAApplication sharedApplication].userType forKey:@"type"];
        
    }
    if(self.keyword){
        self.searchBar.text = self.keyword;
        [self.filterParameters setValue:self.keyword forKey:@"search"];
    }
   
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}

#pragma mark - Request

- (void)fetchData {
    NSString * url;
    if (self.isClassic) {
        url = API_Classification_search;
    }else{
        url = API_Classification_sort;
    }
    [self requestMethod:GARequestMethodPOST URLString:url parameters:self.filterParameters resKeyPath:@"result" resArrayClass:[PMGoodsItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
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
- (void)cellDidAddCart:(PMGoodsItem *)item{
    [self requestPOST:API_Dogfood_cart parameters:@{@"goods_id":item.goodId,@"user_id":[SAApplication userID],@"type":@"1",@"list_id":item.list_id,@"shul":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"加入购物车成功！"];
    } failure:NULL];
}
- (void)updateFilterWithParameters:(NSDictionary *)parameters {
    [self.filterParameters setValue:@(self.page) forKey:@"pagenum"];
    [self.filterParameters setValue:@(10) forKey:@"pagesize"];
    [self.filterParameters setValue:[SAApplication sharedApplication].userType forKey:@"type"];
    [self fetchData];
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchBar.text.length > 0) {
         [self.filterParameters setValue:searchBar.text forKey:@"search"];
    }else{
        [self.filterParameters removeObjectForKey:@"search"];
    }
   
    [self fetchData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.filterParameters setValue:searchBar.text forKey:@"search"];
    [self fetchData];
}
@end
