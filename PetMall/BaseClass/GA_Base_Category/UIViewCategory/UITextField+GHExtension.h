//
//  UITextField+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (GHExtension)
+ (UITextField *)creatTextFieldFrame:(CGRect)frame andPlaceTitle:(NSString *)placeTitle;
/** 占位文字颜色 */
@property (nonatomic, strong) UIColor *ga_placeholderColor;
@end
