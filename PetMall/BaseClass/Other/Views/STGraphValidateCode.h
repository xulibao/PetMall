//
//  STGraphValidateCode.h
//  SnailTruck
//
//  Created by 唐欢 on 15/12/2.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STGraphValidateCode : UIControl

/**
 *  图形验证码的文字
 */
@property (nonatomic, readonly) NSString *validateCode;

/**
 *  是否需要随机生成背景视图，default为NO， 默认的backgroundColor为whiteColor
 */
@property (nonatomic, assign) IBInspectable BOOL needGenerateBackgroundColor;

/**
 *  生成障碍线条的最多条数 默认最多5条(在0-maxLineNumbers这个范围随机生成线条条数)
 */
@property (nonatomic, assign) IBInspectable NSInteger maxLineNumbers;


- (void)changeCode;
@end

