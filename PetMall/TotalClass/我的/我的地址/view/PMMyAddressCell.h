//
//  PMMyAddressCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "STCommonTableViewCell.h"
@class PMMyAddressItem;
@protocol PMMyAddressCellDelegate <STCommonTableViewCellDelegate>
- (void)PMMyAddressCellEdit:(PMMyAddressItem *)item;
@end
@interface PMMyAddressCell : STCommonTableViewCell

@property(nonatomic, weak) id<PMMyAddressCellDelegate> cellDelegate;

@end
