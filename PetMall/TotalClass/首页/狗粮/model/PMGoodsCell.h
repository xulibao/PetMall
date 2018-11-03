//
//  PMGoodsCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/26.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMGoodsItem.h"

@protocol PMGoodsCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidAddCart:(PMGoodsItem *)item;
@end

@interface PMGoodsCell : STCommonTableViewCell

@property(nonatomic, strong) PMGoodsItem *item;

@property(nonatomic, weak) id<PMGoodsCellDelegate> cellDelegate;
@end

