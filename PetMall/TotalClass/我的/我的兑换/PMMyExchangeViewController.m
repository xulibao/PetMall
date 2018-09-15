//
//  PMMyExchangeViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyExchangeViewController.h"
#import "PMCommonGoodsItem.h"

@interface PMMyExchangeViewController()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation PMMyExchangeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的兑换";
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
@end
