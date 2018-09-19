//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyGroupPurchaseViewController.h"
#import "PMCommonGoodsItem.h"
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
      self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item1{
    
    PMGroupPurchaserDetailViewController * vc = [PMGroupPurchaserDetailViewController new];
    PMCommonGoodsItem * item = self.dataArray[0];
    vc.goodTitle = @"包退通用牛肉泰迪贵宾金毛比熊幼犬成犬双拼狗粮 5斤10斤";
    vc.goodPrice = item.price;
    vc.goodTip= @"26人参团  还差4人";
    vc.goodSubtitle = @"参团立省7.2元";
    vc.shufflingArray = item.images;
    vc.goodImageView = item.image_url;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
