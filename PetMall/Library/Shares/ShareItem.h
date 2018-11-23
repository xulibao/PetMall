//
//  ShareItem.h
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STShareComponent.h"

#define ShareItemWidth  80.0f
#define ShareItemHeight 120.0f

@interface ShareItem : UIButton

@property (nonatomic, assign) SharePlatformType platformType;

+ (instancetype)shareItemWithPlatformType:(SharePlatformType)platformType;

@end
