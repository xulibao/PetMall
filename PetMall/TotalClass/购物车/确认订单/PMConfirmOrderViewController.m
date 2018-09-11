//
//  PMConfirmOrderViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMConfirmOrderViewController.h"
#import "PMConfirmOrderHeaderView.h"
#import "PMConfirmOrderCell.h"
@interface PMConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) PMConfirmOrderHeaderView *headerView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMConfirmOrderViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        DCRecommendItem *recommendItem = [[DCRecommendItem alloc] init];
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        recommendItem = [[DCRecommendItem alloc] init];
        [_dataArray addObject:recommendItem];
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO猫粮 抗敏美毛系列全 全新包装营养配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        [_dataArray addObject:recommendItem];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 49) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PMConfirmOrderCell class] forCellReuseIdentifier:@"PMConfirmOrderCellID"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (PMConfirmOrderHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[PMConfirmOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 77)];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
}


#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PMConfirmOrderCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMConfirmOrderCellID" forIndexPath:indexPath];
    DCRecommendItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 94;
}
@end
