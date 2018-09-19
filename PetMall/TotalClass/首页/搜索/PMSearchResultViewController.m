//
//  PMSearchResultViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSearchResultViewController.h"
#import "PMCommonGoodsItem.h"
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
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}
- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item1{
    PMCommonGoodsItem * item = self.dataArray[0];
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goodTitle = item.main_title;
    vc.goodPrice = item.price;
    vc.goodSubtitle = item.goods_title;
    vc.shufflingArray = item.images;
    vc.goodImageView = item.image_url;
    
    [self.navigationController pushViewController:vc  animated:YES];
}
@end
