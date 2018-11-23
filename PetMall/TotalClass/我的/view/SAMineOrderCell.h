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
#import "PMOrderDetailItem.h"
#import "PMOrderListItem.h"

@protocol SAMineOrderDelegate <NSObject>

- (void)mineOrderClickWithType:(PMOrderOrderType)type;

@end

@interface SAMineOrderCell : SABaseCell

@property (nonatomic,strong) SAPersonCenterModel *model;

@property (nonatomic,weak) id <SAMineOrderDelegate>delegate;

@end
