//
//  STTopSelectBtn.h
//  SnailTruck
//
//  Created by th on 15/10/28.
//  Copyright © 2015年 GhGh. All rights reserved.
//
/**
 *  图标在上，文本在下按钮的图文间隔比例（0-1），默认0.8
 */
#define fl_buttonTopRadio 0.8
/**
 *  图标在下，文本在上按钮的图文间隔比例（0-1），默认0.5
 */
#define fl_buttonBottomRadio 0.5

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AlignmentStatus) {
    // 正常
    kAlignmentStatusNormal,
    // 图标和文本位置变化
    kAlignmentStatusLeft,// 左对齐
    kAlignmentStatusCenter,// 居中对齐
    kAlignmentStatusRight,// 右对齐
    kAlignmentStatusTop,// 图标在上，文本在下(居中)
    kAlignmentStatusBottom, // 图标在下，文本在上(居中)
};
@interface STTopSelectBtn : UIButton

@property(nonatomic, assign)AlignmentStatus alignmentStatus;


@end
