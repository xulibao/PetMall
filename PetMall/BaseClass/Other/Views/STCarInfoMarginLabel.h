//
//  STCarInfoMarginLabel.h
//  SnailTruck
//
//  Created by 唐欢 on 15/11/9.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STCarInfoMarginLabel : UIView
@property(nonatomic, strong)UILabel* contentLabel;
@property(nonatomic, assign)BOOL titleColoerType;
- (instancetype)initWithTitle:(NSString*)title font:(UIFont *)titleFont contents:(NSString *)contents font:(UIFont *)contentFont WithTitleWith:(CGFloat)titleWith;
- (instancetype)initWithTitle:(NSString*)title font:(UIFont *)titleFont titleColor:(UIColor *)titleColor contents:(NSString *)contents font:(UIFont *)contentFont WithTitleWith:(CGFloat)titleWith;
-(NSInteger)returnMaxWith;
@property(nonatomic ,assign)CGFloat contentWith;//内容的宽度

@end
