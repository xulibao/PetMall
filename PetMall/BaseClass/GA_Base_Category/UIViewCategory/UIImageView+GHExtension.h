//
//  UIImageView+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/22.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (GHExtension)
// 快速创建
+ (UIImageView *)creatImageViewFrame:(CGRect)frame andImage:(UIImage *)image;
// 一行代码设置圆角,比layer层性能优秀
@property (nonatomic, assign) CGFloat aliCornerRadius;
@end


// 圆角使用方法

//UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
//imageView.image = [UIImage imageNamed:@"test1.jpg"];
//imageView.aliCornerRadius = 20;
//[self.view addSubview:imageView];