//
//  PMIntegralMallCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/27.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMIntegralMallItem.h"
@class PMIntegralMallCell;
@protocol PMIntegralMallCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)PMIntegralMallCellDidClick:(PMIntegralMallCell *)cell;
@end

@interface PMIntegralMallCell : STCommonTableViewCell

@property(nonatomic, strong) PMIntegralMallItem *item;
@property(nonatomic, weak) id<PMIntegralMallCellDelegate> cellDelegate;

@end
