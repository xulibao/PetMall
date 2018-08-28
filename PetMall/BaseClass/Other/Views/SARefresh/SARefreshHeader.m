//
//  SARefreshHeader.m
//  SnailTruck
//
//  Created by imeng on 02/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SARefreshHeader.h"
#import <SDWebImage/UIImage+GIF.h>

@implementation SARefreshHeader

/** 初始化 */
- (void)prepare {
    [super prepare];
//    self.backgroundColor = [UIColor whiteColor];
    self.stateLabel.font = UIFontMake(12);
    [self setTitle:@"正在刷新数据" forState:MJRefreshStateRefreshing];
//    YYImage *image = [YYImage imageNamed:@"refresh_Header_icon"];
    UIImage *image = [UIImage sd_animatedGIFWithData:[NSData dataNamed:@"refresh_Header_icon"]];
    
    self.gifView.image = image;
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
