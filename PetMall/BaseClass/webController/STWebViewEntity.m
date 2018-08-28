//
//  STWebViewEntity.m
//  SnailTruck
//
//  Created by imeng on 2018/2/1.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STWebViewEntity.h"

@implementation STH5ViewConfig

- (BOOL)hasRightButton {
    return (self.rightButtonTitleText.length > 0 || self.rightButtonIconURL.length > 0);
}

#pragma mark - MJKeyValue
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"navigationBarTitleText" : @"navigationBar.titleText",
             @"rightButtonTitleText" : @"navigationBar.rightButton.titleText",
             @"rightButtonIconURL" : @"navigationBar.rightButton.iconURL",
             @"rightButtonAction" : @"navigationBar.rightButton.actionName"};
}

@end

@implementation STH5PayEntity

@end

@implementation STH5ShareEntity

#pragma mark - STShareProtocol
//分享的标题
- (NSString *)st_ShareTitle {
    return self.title;
}
//分享的内容
- (NSString *)st_ShareContent {
    return self.content;
}
//分享的网页地址
- (NSURL *)st_ShareURL {
    NSURL *url = [NSURL URLWithString:self.shareURL];
    return url;
}

//- (UIImage *)st_ShareImage;//分享的图片
//分享的图片URL
- (NSURL *)st_ShareImageURL {
    if ([self.shareImageURL containsString:@"logoic_launcher1.png"]) {
        self.shareImageURL = @"http://7xoaj5.com1.z0.glb.clouddn.com/logoic_launcher2.png";
    }
    NSURL *url = [NSURL URLWithString:self.shareImageURL];
    return url;
}

@end

