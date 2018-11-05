//
//  PMCommonGoodsCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "PMHomeModel.h"

@protocol PMGoodsGroupCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidAddGroup:(PMGroupModel *)item;
@end

@interface PMGoodsGroupCell : STCommonTableViewCell

@property(nonatomic, strong) PMGroupModel *item;

@property(nonatomic, weak) id<PMGoodsGroupCellDelegate> cellDelegate;

@end
