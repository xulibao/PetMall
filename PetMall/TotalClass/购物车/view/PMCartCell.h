//
//  PMCartCell.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SABaseCell.h"
#import "DCRecommendItem.h"
@interface PMCartCell : SABaseCell

@property(nonatomic, strong) DCRecommendItem *item;

@property(nonatomic, copy) void (^calculateCallBack)(NSString * goodsCount,NSString *zt);
@end
