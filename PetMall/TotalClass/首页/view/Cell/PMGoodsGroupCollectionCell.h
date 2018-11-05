//
//  DCGoodsYouLikeCell.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMHomeModel.h"

@interface PMGoodsGroupCollectionCell : UICollectionViewCell

/* 推荐数据 */
@property (strong , nonatomic)PMGroupModel *groupModel;
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;

/**  */
@property (nonatomic, copy) void(^callBack)(PMGroupModel *groupModel);

@end
