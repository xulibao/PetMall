//
//  PMMessageDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageDetailViewController.h"
#import "PMMessageDetailItem.h"
@interface PMMessageDetailViewController ()
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMessageDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.mj_header.hidden = YES;
    [self fetchData];
}

- (void)refreshingAction {
    [self fetchData];
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark - Request

- (void)fetchData {
    if ([self.type integerValue] == 1) {
        self.title = @"系统通知";
        [self requestMethod:GARequestMethodPOST URLString:API_user_service parameters:@{@"user_id":[SAApplication userID]} resKeyPath:@"result" resArrayClass:[PMMessageDetailItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
            self.dataArray = responseObject;
            [self setItems:self.dataArray];
        } failure:NULL];
    }else{
        self.title = @"客服消息";
        [self requestMethod:GARequestMethodPOST URLString:API_user_customer parameters:@{@"user_id":[SAApplication userID]} resKeyPath:@"result" resArrayClass:[NSDictionary class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
            for (NSDictionary *dict in responseObject) {
                PMMessageDetailItem * item = [PMMessageDetailItem new];
                item.name = dict[@"content"];
                item.content = dict[@"fankui"];
                item.time = dict[@"time"];
                item.message_id = dict[@"id"];
                [self.dataArray addObject:item];
            }
            [self setItems:self.dataArray];
        } failure:NULL];
    }
  
}

@end
