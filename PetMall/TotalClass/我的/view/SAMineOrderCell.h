//
//  SAMineOrderCell.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMineModel.h"
#import "SABaseCell.h"
#import "SAPersonCenterModel.h"
typedef NS_ENUM(NSUInteger, SAMineOrderType) {
    SAMineOrderTypeAll = -1,           // 全部订单
    SAMineOrderTypeConfirming = 3,           // 待确认
    SAMineOrderTypePayment = 7,           // 待付款
    SAMineOrderTypeTransfer = 10,           // 待过户
    SAMineOrderTypeComplete = 12,           // 已完成
    SAMineOrderTypeFail = 6            // 已失败
};
@protocol SAMineOrderDelegate <NSObject>

- (void)mineOrderClickWithType:(SAMineOrderType)type;

@end

@interface SAMineOrderCell : SABaseCell

@property (nonatomic,strong) SAPersonCenterModel *model;

@property (nonatomic,weak) id <SAMineOrderDelegate>delegate;

@end
