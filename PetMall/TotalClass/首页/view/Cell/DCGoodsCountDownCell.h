//
//  DCGoodsCountDownCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRecommendItem.h"

@interface DCGoodsCountDownCell : UICollectionViewCell
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, copy) void (^DCGoodsCountDownCellBlock)(DCRecommendItem *item);
@end
