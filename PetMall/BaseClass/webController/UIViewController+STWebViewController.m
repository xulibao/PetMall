//
//  UIViewController+STWebViewController.m
//  SnailTruck
//
//  Created by imeng on 2018/2/1.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "UIViewController+STWebViewController.h"
#import "STWebViewEntity.h"
//#import "ShareMainView.h"//分享
//#import "STUnifiedAcceptMoneyViewController.h"//支付
#import "STShareProtocol.h"

static NSString *const kDidShareFromApp = @"didShareFromApp";
static NSString *const kDidPayFromApp = @"didPayFromApp";

@implementation UIViewController (STWebViewController)

//登录
- (void)loginFromH5WithCallBack:(completionCallBack)callback{
    dispatch_async(dispatch_get_main_queue(), ^{
//        if (![SAAccount isLog]) {
//            STNavigationController *nav = [[STNavigationController alloc] init];
//            STLoginController *loginVc = [[STLoginController alloc] init];
//            [loginVc setLoginBlockCallBack: callback ? callback : nil];
//            UIViewController *vc = [STTabBarController sharedSTTabBarController].currtentController;
//            [nav addChildViewController:loginVc];
//            [vc presentViewController:nav animated:YES completion:nil];
//        }
    });
}

//关闭
- (void)closePageFromH5 {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

//分享
- (void)shareFromH5:(NSString *)data {
//    @weakify(self);
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSDictionary *parameter = [data mj_JSONObject];
//        STH5ShareEntity *share = [STH5ShareEntity mj_objectWithKeyValues:parameter];
//        ShareMainView *shareView = [ShareMainView shareMainViewWithPlatform:@[@(SharePlatformTypeForWeChat),@(SharePlatformTypeForWechatTimeline),@(SharePlatformTypeForQQ),@(SharePlatformTypeForQQZone)]];
//        ShareMainView *shareView = [ShareMainView shareMainViewWithPlatform:@[@(SharePlatformTypeForWeChat),@(SharePlatformTypeForWechatTimeline)]];
//
//        [shareView showWithShareObject:share presenteController:weak_self success:^(id result, NSError *error) {
//            if (error) {
//
//                UMSocialLogInfo(@"************Share fail with error %@*********",error);
//            }else{
//                if ([result isKindOfClass:[UMSocialShareResponse class]]) {
//                    UMSocialShareResponse *resp = result;
//                    SharePlatformType type = SharePlatformTypeWithUMSocialPlatformType(resp.platformType);
//                    
//                    if ([weak_self respondsToSelector:@selector(evaluateScriptMethod:parameter:)]) {
//                        id<STWebViewControllerJSCall>jscall = (id)weak_self;
//                    }
//                    id<STWebViewControllerJSCall>jscall = (id)weak_self;
//                    [jscall evaluateScriptMethod:kDidShareFromApp parameter:nil];
//                }
//            }
//        } cancle:nil];
//    });
}

//支付
- (void)payFromH5:(NSString *)data {
    @weakify(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        NSDictionary *parameter = [data mj_JSONObject];
//        STH5PayEntity *pay = [STH5PayEntity mj_objectWithKeyValues:parameter];
//
//        STUnifiedAcceptMoneyViewController *vc = [[STUnifiedAcceptMoneyViewController alloc] init];
//        // 支付
//        STUnifiedAcceptMoneyModel *moneyModel = [[STUnifiedAcceptMoneyModel alloc] init];
//        moneyModel.payType = kPayTypeNormal;
//        moneyModel.tradeNO = pay.orderID;
//        moneyModel.amount = pay.price;
//        moneyModel.productDescription = pay.orderDesc;
//        moneyModel.productName = pay.orderName;
//        moneyModel.orderType = kPayOrderTypeNone;
//        moneyModel.jumpToViewController = NSStringFromClass([weak_self class]);
//        vc.moneyModel = moneyModel;
//
//        [vc setPayTimeStrBlockCall:^(NSString *payTimeStr){
//            if ([weak_self respondsToSelector:@selector(evaluateScriptMethod:parameter:)]) {
//                id<STWebViewControllerJSCall>jscall = (id)weak_self;
//                [jscall evaluateScriptMethod:kDidPayFromApp parameter:nil];
//            }
//
//        }];
//        [weak_self.navigationController pushViewController:vc animated:YES];
    });
}
//打开URL
- (void)openURLFromH5:(NSString *)data {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if ([data isKindOfClass:[NSString class]]) {
//            if ([data containsString:@"tel:"]) {
//                MakePhoneTelprompt([data substringFromIndex:3]);
//            }else if ([data containsString:@"MyWallet"]){
//                SAMyWalletViewController *vc = [[SAMyWalletViewController alloc] init];
//                [self.navigationController pushViewController:vc animated:YES];
//            }else {
//                [self openGarouterURLFromH5:data];
//            }
//        }
//    });
}

- (void)openGarouterURLFromH5:(NSString *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSURL *url = [NSURL URLWithString:data];
        if (url && [[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    });
}

@end
