//
//  DCFeatureChoseTopCell.h
//  CDDStoreDemo
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMGoodDetailModel.h"
@interface DCFeatureChoseTopCell : UITableViewCell

@property(nonatomic, strong) PMGoodDetailPriceModel *priceModel;
/* 图片 */
@property (strong , nonatomic)UIImageView *goodImageView;
/** 取消点击回调 */
@property (nonatomic, copy) dispatch_block_t crossButtonClickBlock;
@end
