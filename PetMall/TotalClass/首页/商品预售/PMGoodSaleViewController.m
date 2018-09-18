//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleViewController.h"
#import "PMCommonGoodsItem.h"

@interface PMGoodSaleViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMGoodSaleViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"潮品预售";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    imageView.image = IMAGE(@"123123313111111");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}

@end
