//
//  GAUITestViewFrameManager.h
//  GHPlaceHolderSize
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

typedef enum
{
    UITstColor_Red = 0,
    UITstColor_Black = 1,
    UITstColor_White = 2,
    UITstColor_Random = 3
    
}UITstColor;
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface GAUITestViewFrameManager : NSObject
/**
 *  单利管理
 */
+ (GAUITestViewFrameManager *)sharedInstance;
@property (nonatomic, assign)BOOL isOpenUITest;
/**
 * 直接显示所有子视图宽度 高度 以及 本身的宽高  view如果是空，则显示当前ViewController的所有尺寸
 */
- (void)testAllSubViews_UIWidthAndHeight:(UIView *)view withLineColor:(UITstColor)lineColor;
// 移除所有的线段
- (void)removeAllTestUILine:(UIView *)view;
@end
