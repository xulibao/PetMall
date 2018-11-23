//
//  ShareManager.h
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareItem.h"
#import "STShareComponent.h"

@interface ShareManager : NSObject
@property (nonatomic,copy) SocialRequestCompletionHandler completion;
/** platformType:平台类型 title:标题 text:分享文字 image:分享图片  url:分享URL location:地址坐标 viewController:控制器 */
+ (void)shareWithPlatformType:(SharePlatformType)platformType title:(NSString *)title shareText:(NSString *)text image:(id)image shareUrl:(NSString *)url  location:(CLLocation *)location presenteController:(UIViewController *)viewController completion:(SocialRequestCompletionHandler)completion;

/** 注册友盟分享 */
+ (void)resgisterShareBusiness;

//+(void)showSuccess:(BaseResp *)resp;
@end
