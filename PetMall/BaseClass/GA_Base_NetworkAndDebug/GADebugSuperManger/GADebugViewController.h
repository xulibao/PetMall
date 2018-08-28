//
//  GADebugViewController.h
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
#ifdef DEBUG
#import <UIKit/UIKit.h>
@interface GADebugViewController : UIViewController
+ (instancetype)sharedInstance;
//@property (assign, nonatomic) UIStatusBarStyle statusBarStyle;
//@property (assign, nonatomic) BOOL statusBarHidden;

@property (nonatomic, assign) BOOL hidden;
//- (void)showOverWindow;

@end
#endif
