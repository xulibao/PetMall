//
//  AppDelegate.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//
#import "WXPayClient.h"
#import "WeiXinConfiging.h"
#import "AppDelegate.h"
#import "GADebugWindow.h" // debug 框架
#import "ShareManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //微信 - 支付使用
    [WXApi registerApp:WXAppId];
    //注册友盟分享
    [ShareManager resgisterShareBusiness];
    // 初始化app
    SAApplication *app = [SAApplication sharedApplication];
    _window = app.window;
    [_window makeKeyAndVisible];
    return YES;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
#ifdef DEBUG
    // debug 框架
    if (KOpen_DebugView) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [GADebugWindow show];
        });
    }
#endif
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
