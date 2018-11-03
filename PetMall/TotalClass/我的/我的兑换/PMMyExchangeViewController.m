//
//  PMMyExchangeViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyExchangeViewController.h"
#import "PMMyExchangeItem.h"

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
    [self requestMethod:GARequestMethodPOST URLString:API_user_myexchange parameters:@{@"pagesize":@"10",@"pagenum":@(self.page)} resKeyPath:@"result" resArrayClass:[PMMyExchangeItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
}
@end
