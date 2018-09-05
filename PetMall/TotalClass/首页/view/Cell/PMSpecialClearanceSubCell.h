//
//  PMSpecialClearanceSubCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DCRecommendItem;

@interface PMSpecialClearanceSubCell : UICollectionViewCell
/* 推荐商品数据 */
@property (strong , nonatomic)DCRecommendItem *recommendItem;
@end
