//
//  STWebViewController.h
//  SnailTruck
//
//  Created by GhGh on 2017/5/24.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "STBaseNonSystemNavViewController.h"

@interface STWebViewController : STBaseNonSystemNavViewController
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *jumpUrl;
@property (nonatomic, copy) NSString *webTitle;
@property (nonatomic, assign) BOOL isNotContainUserId;
@property (nonatomic, assign) BOOL isNotShowRightBtn;
@end


