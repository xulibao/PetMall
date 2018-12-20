//
//  SAOrderListCell.h
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMOrderListItem.h"
@class PMOrderListCell;
@protocol PMOrderListCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)PMOrderListCellClickRefund:(PMOrderListCell *)cell;
- (void)PMOrderListCellClickPay:(PMOrderListCell *)cell;
- (void)PMOrderListCellClickCancle:(PMOrderListCell *)cell;
- (void)PMOrderListCellClickConfirm:(PMOrderListCell *)cell;
- (void)PMOrderListCellClickComment:(PMOrderListCell *)cell;


@end
@interface PMOrderListCell : STCommonTableViewCell

@property(nonatomic, strong) PMOrderItem *item;
@property(nonatomic, weak) <PMOrderListCellDelegate> cellDelegate;
@end
