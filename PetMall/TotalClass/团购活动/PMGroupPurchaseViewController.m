//
//  PMGroupPurchaseViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGroupPurchaseViewController.h"
#import "PMGroupPurchaserDetailViewController.h"
#import "PMHomeModel.h"
#import "DCSlideshowHeadView.h"
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
    
}


#pragma mark - Request

- (void)fetchData {
    [self requestPOST:API_Dogfood_presale parameters:@{@"pagenum":@(self.page),@"pagesize":@(10),@"fenl":@"3"} success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = [PMGroupModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
        [self setItems:self.dataArray];
        DCSlideshowHeadView * header = [[DCSlideshowHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 190)];
        NSMutableArray * imageArray = [@[] mutableCopy];
        for (NSDictionary *imgDic in responseObject[@"result"][@"img"]) {
            [imageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host], imgDic[@"img"]]];
        }
        header.imageGroupArray = imageArray;
//        [imageView setImageWithURL:[NSURL URLWithString:imageStr] placeholder:IMAGE(@"tuangou_header")];
        self.tableView.tableHeaderView = header;
        self.tableView.mj_header.hidden = YES;
    } failure:NULL];
    
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item1{
    
    PMGroupPurchaserDetailViewController * vc = [PMGroupPurchaserDetailViewController new];
//    PMCommonGoodsItem * item = self.dataArray[0];
//    vc.goodTitle = @"包退通用牛肉泰迪贵宾金毛比熊幼犬成犬双拼狗粮 5斤10斤";
//    vc.goodPrice = item.price;
//    vc.goodTip= @"26人参团  还差4人";
//    vc.goodSubtitle = @"参团立省7.2元";
    [self.navigationController pushViewController:vc animated:YES];
}
@end
