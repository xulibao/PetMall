//
//  GAToastTipsView.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 16/2/1.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
// 成功  失败  警告  三种形式
typedef NS_ENUM(NSInteger, GAToastTipsState)
{
    GAToastTipsStateNothing,
    GAToastTipsStateSucess,
    GAToastTipsStateWarning,
    GAToastTipsStateError,
};

// 水平方向
typedef NS_ENUM(NSInteger, GAToastHorizontalGravity)
{
    GAToastHorizontalGravityTop,
    GAToastHorizontalGravityCenter,
    GAToastHorizontalGravityBottom,
};
// 垂直方向
typedef NS_ENUM(NSInteger, GAToastVerticalGravity)
{
    GAToastVerticalGravityLeft,
    GAToastVerticalGravityCenter,
    GAToastVerticalGravityRight,
};
// 结构体
struct GAToastGravity {
    GAToastHorizontalGravity x;
    GAToastVerticalGravity y;
};
typedef struct GAToastGravity GAToastGravity;
// 位置
GAToastGravity ToastGravityMake(GAToastHorizontalGravity x, GAToastVerticalGravity y);

@interface GAToastTipsView : UIView
// 每个view上面只允许添加一个,默认添加时最新的Toast
+ (GAToastTipsView *)showWithContent:(NSString *)content state:(GAToastTipsState)state gravity:(GAToastGravity)gravity inView:(UIView *)view;
@end

// 如何使用
//[GAToastTipsView showWithContent:@"手机号码有误" state:GAToastTipsStateWarning gravity:ToastGravityMake(GAToastHorizontalGravityCenter, GAToastVerticalGravityCenter) inView:self.view];
//





