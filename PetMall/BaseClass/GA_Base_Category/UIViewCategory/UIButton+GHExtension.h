//
//  UIButton+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (GHExtension)
// 可以用这个给重复点击加间 - 防止重复点击，默认是 1 秒
//@property (nonatomic, assign) NSTimeInterval custom_acceptEventInterval;
+ (UIButton *)creatButtonFrame:(CGRect)frame title:(NSString *)title andNormalImage:(UIImage *)normalImage withHightImage:(UIImage *)hightImage;
/** 延迟时间 秒*/
//@property(nonatomic)NSTimeInterval ga_acceptEventInterval;
@end
