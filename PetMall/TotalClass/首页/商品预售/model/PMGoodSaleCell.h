//
//  PMGoodsCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMGoodSaleItem.h"

@protocol PMGoodSaleCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidAddCart:(PMGoodSaleItem *)item;
@end

@interface PMGoodSaleCell : STCommonTableViewCell

@property(nonatomic, strong) PMGoodSaleItem *item;

@property(nonatomic, weak) id<PMGoodSaleCellDelegate> cellDelegate;
@end

