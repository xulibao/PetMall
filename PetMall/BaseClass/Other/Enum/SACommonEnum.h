//
//  SACommonEnum.m
//  SnailAuction
//
//  Created by imeng on 05/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

//拍卖状态 {1.预展中(竞拍未开始) 2.竞拍中 3.待确认(竞拍结束)6. 交易失败 7.待付款 10.待过户 12.交易完成
//0 全部 ，1.预展中(竞拍未开始) ,2.竞拍中
typedef NS_ENUM(NSUInteger, SAAuctionStatus) {
    SAAuctionStatusAll = 0,
    SAAuctionStatusNotBegin = 1,
    SAAuctionStatusInProgress = 2,
};

