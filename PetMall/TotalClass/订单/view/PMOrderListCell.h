//
//  SAOrderListCell.h
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMOrderListItem.h"
@protocol PMOrderListCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)PMOrderListCellClick;
@end
@interface PMOrderListCell : STCommonTableViewCell

@property(nonatomic, strong) PMOrderListItem *item;
@property(nonatomic, weak) <PMOrderListCellDelegate> cellDelegate;
@end
