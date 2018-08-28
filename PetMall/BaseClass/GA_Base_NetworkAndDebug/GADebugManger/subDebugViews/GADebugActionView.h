//
//  GADebugActionView.h
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GADebugActionView : UIView
@property (nonatomic, strong, readonly) UIView *contentView;
- (void) showOverWindow;
- (void)closeBtnClick:(id)sender;
@end
