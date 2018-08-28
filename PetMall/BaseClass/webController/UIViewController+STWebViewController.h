//
//  UIViewController+STWebViewController.h
//  SnailTruck
//
//  Created by imeng on 2018/2/1.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol STWebViewControllerJSCall<JSExport>

/**
 native调用web功能
 */
- (void)evaluateScriptMethod:(NSString *)method parameter:(id)parameter;

/**
 web调用native功能
 */
- (void)loginFromH5; // 登录
- (void)closePageFromH5; // 关闭
- (void)shareFromH5:(NSString *)data;//分享
- (void)payFromH5:(NSString *)data;//支付
- (void)openURLFromH5:(NSString *)data;//打开URL
- (void)openGarouterURLFromH5:(NSString *)data;//打开URL
- (void)onClickImage:(NSString *)data;//点击图片打开

@end


typedef void(^completionCallBack)();

@interface UIViewController (STWebViewController)

//登陆
- (void)loginFromH5WithCallBack:(completionCallBack)callback;
//关闭
- (void)closePageFromH5;
//分享
- (void)shareFromH5:(NSString *)data ;
//支付
- (void)payFromH5:(NSString *)data;
//打开URL
- (void)openURLFromH5:(NSString *)data;

- (void)openGarouterURLFromH5:(NSString *)data;

@end
