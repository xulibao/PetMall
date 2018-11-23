//
//  PMMyExchangeCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/27.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMMyExchangeItem.h"

@class PMMyExchangeCell;
@protocol PMMyExchangeCellCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)PMMyExchangeCellDidClick:(PMMyExchangeCell *)cell;
@end

@interface PMMyExchangeCell : STCommonTableViewCell

@property(nonatomic, strong) PMMyExchangeItem *item;
@property(nonatomic, weak) id<PMMyExchangeCellCellDelegate> cellDelegate;
@end
