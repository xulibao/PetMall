//
//  STValueSlider.h
//  SnailTruck
//
//  Created by GhGh on 2018/1/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STValueSlider : UIView // 滑动块
@property (nonatomic,strong) UIImageView *leftSlideImageView;
@property (nonatomic,strong) UIImageView *rightSlideImageView;
@property(nonatomic,assign)CGFloat leftValue;
@property(nonatomic,assign)CGFloat rightValue;
@property(nonatomic,strong)UIView *pmgressbarView;
@property(nonatomic,assign)NSInteger totalSection; //视图要分成几部分
@property(nonatomic,assign)CGFloat maxValue; //最大值是多少
@property(nonatomic,assign)CGFloat minIntervalValue; //最小间隔值
@property(nonatomic,assign)CGFloat origWidth;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *lastLabel;

@property (nonatomic,copy) void (^callBack)(NSInteger minValue,NSInteger maxValue);

- (void)updateWithLeftValue:(NSInteger)leftValue rightValue:(NSInteger)rightValue;
@end
