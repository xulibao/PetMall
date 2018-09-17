//
//  PMMessageViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageViewController.h"
#import "PMMessageItem.h"
#import "PMMessageDetailViewController.h"
@interface PMMessageViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMessageViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    [self fetchData];
    self.tableView.mj_header.hidden = YES;
    //    self.viewModel.cellDelegate = self;
}
- (void)fetchData {
    self.dataArray = [NSMutableArray array];
    PMMessageItem * recommendItem = [PMMessageItem new];
    recommendItem.image_url = @"mine_tongzhi";
    recommendItem.goods_title = @"系统通知";
    recommendItem.nature = @"有新的优惠活动等你来参与";
    recommendItem.price = @"158";
    recommendItem.people_count = @"2";
    [_dataArray addObject:recommendItem];
    
    recommendItem = [PMMessageItem new];
    recommendItem.image_url = @"mine_kefu";
    recommendItem.goods_title = @"客服消息";
    recommendItem.nature = @"您反馈的问题已得到解决";
    recommendItem.price = @"158";
    recommendItem.people_count = @"2";
    [_dataArray addObject:recommendItem];
    
    recommendItem = [PMMessageItem new];
    recommendItem.image_url = @"common_photo";
    recommendItem.goods_title = @"达芙内江";
    recommendItem.nature = @"快来给爱宠挑选礼物吧，有更多优惠...";
    recommendItem.price = @"158";
    recommendItem.people_count = @"2";
    [_dataArray addObject:recommendItem];
    
 
    
    [self setItems:self.dataArray];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMMessageDetailViewController * vc = [PMMessageDetailViewController new];
    [self pushViewController:vc];
}



@end
