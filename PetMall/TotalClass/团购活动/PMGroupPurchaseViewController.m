//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGroupPurchaseViewController.h"
#import "PMCommonGoodsItem.h"
#import "PMGroupPurchaserDetailViewController.h"
@interface PMGroupPurchaseViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PMGroupPurchaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"团购活动";
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}
- (void)initSubviews{
    [super initSubviews];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
    imageView.image = IMAGE(@"tuangou_header");
    self.tableView.tableHeaderView = imageView;
    self.tableView.mj_header.hidden = YES;
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
