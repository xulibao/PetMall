//
//  DCNewWelfareCell.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/29.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//
//新人福利
#import <UIKit/UIKit.h>

@interface DCNewWelfareCell : UICollectionViewCell
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, copy) void(^cellDidSellect)(void);
@end
