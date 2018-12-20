//
//  PMTimeLimitCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/12/18.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMTimeLimitItem.h"

@class PMTimeLimitCell;
@protocol PMTimeLimitCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)PMTimeLimitCellDidClick:(PMTimeLimitCell *)cell;
@end
@interface PMTimeLimitCell : STCommonTableViewCell
@property(nonatomic, strong) PMTimeLimitItem *item;
@property(nonatomic, weak) id<PMTimeLimitCellDelegate> cellDelegate;

@end
