//
//  SABillRecordViewController.h
//  SnailAuction
//
//  Created by imeng on 01/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAIndicatorSegmentViewController.h"
#import "SAInfoListViewController.h"
#import "PMOrderListCell.h"
typedef NS_ENUM(NSUInteger, PMOrderOrderType) {
    PMOrderOrderTypeAll = -1,           // 全部订单
    PMOrderOrderTypePayment = 7,           // 待付款
    PMOrderOrderTypeTransfer = 10,           // 待fahuo
    PMOrderOrderTypeComment = 12,           // 待评价
};

@interface PMOrderViewController : SAIndicatorSegmentViewController

@end

@interface PMOrderListViewController : SAInfoListViewController <PMOrderListCellDelegate>

@property(nonatomic, assign) PMOrderOrderType type;


@end
