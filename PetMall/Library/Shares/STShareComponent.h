//
//  STShareComponent.h
//  SnailTruck
//
//  Created by imeng on 8/4/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#ifndef STShareComponent_h
#define STShareComponent_h
#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

typedef NS_ENUM(NSInteger,SharePlatformType) {
    SharePlatformTypeForUndefine = -1,
    /** 微信朋友圈 */
    SharePlatformTypeForWechatTimeline = 1,
    /** 微信好友 */
    SharePlatformTypeForWeChat = 2,
    /** QQ */
    SharePlatformTypeForQQ = 3,
    /** QQ空间 */
    SharePlatformTypeForQQZone = 4,
    /** 微博 */
    SharePlatformTypeForWeibo = 5,
    /** 其他 */
    SharePlatformTypeForToOther = 6,
    /** 短信分享 */
    SharePlatformTypeForToSms,
};

extern SharePlatformType const SharePlatformTypeWithUMSocialPlatformType(UMSocialPlatformType UMType);

typedef void (^SocialRequestCompletionHandler)(id result,NSError *error);

#endif /* STShareComponent_h */
