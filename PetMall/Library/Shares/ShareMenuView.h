//
//  ShareMenuView.h
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareItem.h"
#define MainWidth        [UIScreen mainScreen].bounds.size.width
#define MainHeight       [UIScreen mainScreen].bounds.size.height

@protocol ShareMenuViewDelegate <NSObject>

@optional
- (void)selectPlatform:(ShareItem *)item;

@end

@interface ShareMenuView : UIView

@property (nonatomic, strong) NSArray *platforms;
@property (nonatomic,   weak) id <ShareMenuViewDelegate> delegate;
@property (nonatomic, strong) UIView * backGround;
@property (nonatomic, assign) BOOL isMoveIn;

@end
