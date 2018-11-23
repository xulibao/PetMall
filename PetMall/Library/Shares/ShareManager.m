//
//  STShare.m
//  SnailTruck
//
//  Created by 木鱼 on 15/11/20.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "ShareManager.h"
#import "UIWindow+GAExtension.h"
#import "WXApi.h"

@implementation ShareManager

+ (void)resgisterShareBusiness
{
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:YOUMENG_APPKEY];

    [self configUSharePlatforms];

    [self confitUShareSettings];

    //友盟获得微信授权
//    [UMSocialWechatHandler setWXAppId:Share_WeiXin_APPID appSecret:Share_WeiXin_AppSecret url:SHAREHTML];
//    //友盟获得QQ授权
//    [UMSocialQQHandler setQQWithAppId:Share_QQ_APPID appKey:Share_QQ_APPKEY url:SHAREHTML];
////    [UMSocialSinaHandler openSSOWithRedirectURL:nil];
//    [UMSocialQQHandler setSupportWebView:YES];
    
    
}

+ (void)confitUShareSettings {
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
    
}

+ (void)configUSharePlatforms
{
    /*
     设置微信的appKey和appSecret
     [微信平台从U-Share 4/5升级说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_1
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:Share_WeiXin_APPID appSecret:Share_WeiXin_AppSecret redirectURL:SHAREHTML];
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:Share_WeiXin_APPID appSecret:Share_WeiXin_AppSecret redirectURL:SHAREHTML];
    
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     [QQ/QZone平台集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_3
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:Share_QQ_APPID/*设置QQ平台的appID*/  appSecret:Share_QQ_APPKEY redirectURL:SHAREHTML];
    
    /*
     设置新浪的appKey和appSecret
     [新浪微博集成说明]http://dev.umeng.com/social/ios/%E8%BF%9B%E9%98%B6%E6%96%87%E6%A1%A3#1_2
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

+ (void)shareWithPlatformType:(SharePlatformType)platformType title:(NSString *)title shareText:(NSString *)text image:(id)image shareUrl:(NSString *)url  location:(CLLocation *)location presenteController:(UIViewController *)viewController completion:(SocialRequestCompletionHandler)completion
{
//    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeWeb;
    
    //    if(url!=nil&&[url hasPrefix:@"http://"]){
    //        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    //    }else{
    //        [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://www.baidu.com";
    //    }
    //    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    if (url != nil && [url length] > 0) {
//        [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
//        [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
//        [UMSocialData defaultData].extConfig.qqData.url = url;
//        [UMSocialData defaultData].extConfig.qzoneData.url = url;
//        
//    } else {
//        NSAssert(0, @"分享 URL 不能为空");
//    }
//    
//    if (text!=nil) {
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = title;
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = title;
//        [UMSocialData defaultData].extConfig.qqData.title = title;
//        [UMSocialData defaultData].extConfig.qzoneData.title = title;
//    }else{
//        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"";
//        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"";
//        [UMSocialData defaultData].extConfig.qqData.title = @"";
//        [UMSocialData defaultData].extConfig.qzoneData.title = @"";
//    }
    
    
    UMSocialPlatformType platform;
    
    switch (platformType) {
    
        case SharePlatformTypeForQQ:
        {
            [self clickInfoForActivePage:1 andVC:viewController];
            platform = UMSocialPlatformType_QQ;
        }
            break;
        case SharePlatformTypeForQQZone:
        {
            [self clickInfoForActivePage:2 andVC:viewController];
            platform = UMSocialPlatformType_Qzone;
        }
            break;
        case SharePlatformTypeForWeChat:
        {
            [self clickInfoForActivePage:3 andVC:viewController];
            platform = UMSocialPlatformType_WechatSession;
        }
            break;
        case SharePlatformTypeForWechatTimeline:
        {
            [self clickInfoForActivePage:4 andVC:viewController];
            platform = UMSocialPlatformType_WechatTimeLine;
        }
            break;
            
        case SharePlatformTypeForToSms:{
            [self clickInfoForActivePage:0 andVC:viewController];
        
            if (viewController == nil) {
                viewController = [[[UIApplication sharedApplication].delegate window] current_Controller];
            }
            // 邀请好友 - 短信
            platform = UMSocialPlatformType_Sms;
            image = nil;
        }
            break;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL = image;// @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:text thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [[UMSocialManager defaultManager] shareToPlatform:platform messageObject:messageObject currentViewController:viewController completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        completion ? completion(data,error) : nil;
//        [self alertWithError:error];
    }];
    
//    [UMSocialConfig setFinishToastIsHidden:NO position:UMSocialiToastPositionCenter];
//    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[platform] content:text image:image location:location urlResource:nil presentedController:viewController completion:completion];
}

#pragma mark - 点击统计事件 - 仅仅是统计积分抽奖页面Statistics
+ (void)clickInfoForActivePage:(NSInteger)index andVC:(UIViewController *)vcString
{
    if ([NSStringFromClass([vcString class]) isEqualToString:@"STInvitationFriendsViewController"])
    {
        NSArray *allStatistics = @[InviteFriendShareDuanXin,InviteFriendShareQQ,InviteFriendShareQQKongJian,InviteFriendShareWeiXin,InviteFriendSharePengYouQuan];
        if (index < 5) {
            [STHelpTools event:allStatistics[index] attributes:[NSDictionary dictionary] isNeedUserId:NO andIsNeedCity:NO];
        }
    }
}


@end
