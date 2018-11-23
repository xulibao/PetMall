//
//  STShareComponent.m
//  SnailTruck
//
//  Created by imeng on 2017/10/15.
//  Copyright © 2017年 GhGh. All rights reserved.
//
#import "STShareComponent.h"

SharePlatformType const SharePlatformTypeWithUMSocialPlatformType(UMSocialPlatformType UMType) {
    switch (UMType) {
            /** 微信朋友圈 */
        case UMSocialPlatformType_WechatTimeLine:
            return SharePlatformTypeForWechatTimeline;
            /** 微信好友 */
        case UMSocialPlatformType_WechatSession:
            return SharePlatformTypeForWeChat;
            /** QQ */
        case UMSocialPlatformType_QQ:
            return SharePlatformTypeForQQ;
            /** QQ空间 */
        case UMSocialPlatformType_Qzone:
            return SharePlatformTypeForQQZone;
            /** 微博 */
        case UMSocialPlatformType_Sina:
            return SharePlatformTypeForWeibo;
            /** 其他 */
        case UMSocialPlatformType_UnKnown:
            return SharePlatformTypeForToOther;
            /** 短信分享 */
        case UMSocialPlatformType_Sms:
            return SharePlatformTypeForToSms;
        default:
            return SharePlatformTypeForUndefine;
    }
};
