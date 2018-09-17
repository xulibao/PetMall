//
//  PMMyCommentViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCommentViewController.h"
#import "PMMyCommentItem.h"
@interface PMMyCommentViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMyCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的评论";
    [self fetchData];
    self.tableView.mj_header.hidden = YES;
//    self.viewModel.cellDelegate = self;
}
- (void)fetchData {
    self.dataArray = [NSMutableArray array];
    PMMyCommentItem * recommendItem = [PMMyCommentItem new];
    recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
    recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
    recommendItem.nature = @"3.06kg  牛肉味";
    recommendItem.price = @"158";
    recommendItem.people_count = @"2";
    [_dataArray addObject:recommendItem];
    
    recommendItem = [PMMyCommentItem new];
    recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
    recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
    recommendItem.nature = @"3.06kg  牛肉味";
    recommendItem.price = @"158";
    recommendItem.people_count = @"2";
    [_dataArray addObject:recommendItem];
    
    [self setItems:self.dataArray];
}




@end
