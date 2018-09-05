//
//  STHomeVCTopView.h
//  SnailTruck
//
//  Created by GhGh on 16/6/2.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface STHomeVCTopView : UIView
//- (void)homePageViewWillAppear; // 展示的时候
@property(nonatomic, copy)NSString *messageCount; // 消息数目
@property(nonatomic, copy)void(^cityChanged)(); // 城市发生了更改
@end


@interface STHomeVCTopViewMessageBtn : UIButton
@property(nonatomic, copy)NSString *messageCount; // 消息数目
@end
