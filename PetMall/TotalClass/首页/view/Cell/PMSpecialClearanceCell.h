//
//  PMSpecialClearanceCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMClearingModel;
@interface PMSpecialClearanceCell : UICollectionViewCell

@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, copy) void (^cellDidSelectItem)(PMClearingModel *model);
@end
