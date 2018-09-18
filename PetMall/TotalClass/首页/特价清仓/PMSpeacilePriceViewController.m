//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSpeacilePriceViewController.h"
#import "PMCommonGoodsItem.h"

@interface PMSpeacilePriceViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMSpeacilePriceViewController
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
    imageView.image = IMAGE(@"12434342423422");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
}

#pragma mark - Request

- (void)fetchData {
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}

@end
