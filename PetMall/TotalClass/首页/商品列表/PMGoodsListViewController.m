//
//  PMGoodsListViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGoodsListViewController.h"
#import "PMCommonGoodsItem.h"
@interface PMGoodsListViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMGoodsListViewController
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
@end
