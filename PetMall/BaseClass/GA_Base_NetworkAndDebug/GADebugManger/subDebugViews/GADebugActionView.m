//
//  GADebugActionView.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//

#import "GADebugActionView.h"
#define K_DebugView_UI_Screen_W  [[UIScreen mainScreen] bounds].size.width
#define K_DebugView_UI_Screen_H  [[UIScreen mainScreen] bounds].size.height
@implementation GADebugActionView

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.frame = CGRectMake(0, 0, K_DebugView_UI_Screen_W, K_DebugView_UI_Screen_H);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, K_DebugView_UI_Screen_W, K_DebugView_UI_Screen_H - 40 - 20)];
        [self addSubview:_contentView];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(0, K_DebugView_UI_Screen_H - 40, K_DebugView_UI_Screen_W, 40);
        [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        closeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closeBtn];
    }
    return self;
}

- (void)closeBtnClick:(id)sender{
    [self removeFromSuperview];
}

- (void) showOverWindow {
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *keyWindow = [app keyWindow];
    if (keyWindow) {
        [keyWindow addSubview:self];
    }
}

@end
