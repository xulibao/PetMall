//
//  PMSpeacilePriceCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/12/19.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMSpeacilePriceItem.h"
@class PMSpeacilePriceCell;
@protocol PMSpeacilePriceCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidAddCart:(PMSpeacilePriceCell *)cell;
@end
@interface PMSpeacilePriceCell : STCommonTableViewCell
@property(nonatomic, strong) PMSpeacilePriceItem *item;
@property(nonatomic, weak) id<PMSpeacilePriceCellDelegate> cellDelegate;
@end
