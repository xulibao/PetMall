//
//  ShareItem.m
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import "ShareItem.h"
#define IconY  20.0f
#define IconW  55.0f
#define IconH  55.0f
@implementation ShareItem


+ (instancetype)shareItemWithPlatformType:(SharePlatformType)platformType {
    
    return [[self alloc] initWithPlatformType:platformType];
}

- (instancetype)initWithPlatformType:(SharePlatformType)platformType {
    
    if (self = [super init]) {
        self.platformType = platformType;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setPlatformType:(SharePlatformType)platformType {
    
    _platformType = platformType;
    switch (platformType) {
        case SharePlatformTypeForQQ:
            [self setImage:[UIImage imageNamed:@"shareQQ"] forState:UIControlStateNormal];
            [self setTitle:@"QQ" forState:UIControlStateNormal];
            break;
        case SharePlatformTypeForQQZone:
            [self setImage:[UIImage imageNamed:@"shareQQZone"] forState:UIControlStateNormal];
            [self setTitle:@"QQ空间" forState:UIControlStateNormal];
            break;
        case SharePlatformTypeForWeChat:
            [self setImage:[UIImage imageNamed:@"shareWeChat"] forState:UIControlStateNormal];
            [self setTitle:@"微信" forState:UIControlStateNormal];
            break;
        case SharePlatformTypeForWechatTimeline:
            [self setImage:[UIImage imageNamed:@"shareWeChatTime"] forState:UIControlStateNormal];
            [self setTitle:@"朋友圈" forState:UIControlStateNormal];
            break;
        case SharePlatformTypeForToSms:
            [self setImage:[UIImage imageNamed:@"shareMessage"] forState:UIControlStateNormal];
            [self setTitle:@"信息" forState:UIControlStateNormal];
            break;
        default:
            break;
            
    }
    
    
    NSLog(@" 里面%ld",self.platformType);
    
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
   
    CGFloat iconX = (ShareItemWidth - IconW) * 0.5;
    CGFloat iconY = IconY;
    return CGRectMake(iconX, iconY, IconW, IconH);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0;
    CGFloat titleY = IconH + IconY;
    CGFloat titleW = ShareItemWidth;
    CGFloat titleH = ShareItemHeight -IconH - IconY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
