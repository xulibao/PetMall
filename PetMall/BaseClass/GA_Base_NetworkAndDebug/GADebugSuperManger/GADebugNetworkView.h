//
//  GADebugNetworkView.h
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
// 网络请求
#ifdef DEBUG
#import "GADebugActionView.h"

@interface GADebugNetworkView : GADebugActionView

@end

#endif

/*
 说明，需要在项目的网络工具类中添加单例代码。
 #import "GADebugManager.h"
 @property (nonatomic, strong) GADebugNetworkModel *networkRequestModel;
 */
