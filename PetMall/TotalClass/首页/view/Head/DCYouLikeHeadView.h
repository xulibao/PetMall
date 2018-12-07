//
//  DCYouLikeHeadView.h
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DCLIRLButton.h"
typedef enum : NSUInteger {
    PMHeaderDetailTypeCountDown , // 倒计时
    PMHeaderDetailTypeMore, // 更多
} PMHeaderDetailType;
@interface DCYouLikeHeadView : UICollectionReusableView

@property (strong , nonatomic)UILabel *titleLabel;

@property(nonatomic, assign) PMHeaderDetailType type;
@property(nonatomic, copy) void(^more)(void);

@end
