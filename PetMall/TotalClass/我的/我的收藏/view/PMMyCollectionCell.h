//
//  PMMyExchangeCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/27.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMMyCollectionItem.h"

@protocol PMMyCollectionCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidClickDeleteCollection:(PMMyCollectionItem *)item;
@end

@interface PMMyCollectionCell : STCommonTableViewCell
@property(nonatomic, weak) id<PMMyCollectionCellDelegate> cellDelegate;
@end
