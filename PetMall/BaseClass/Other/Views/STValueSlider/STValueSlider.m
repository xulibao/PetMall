//
//  STValueSlider.m
//  SnailTruck
//
//  Created by GhGh on 2018/1/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STValueSlider.h"
const NSInteger kExtendLength = 5;
@implementation STValueSlider
//重写该方法后可以让超出父视图范围的子视图响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configSubView];
    }
    return self;
}

- (void)configSubView{
    self.leftValue = 0;
    self.rightValue = CGFLOAT_MAX;
    self.origWidth = self.width;
    self.width = self.width + kExtendLength;
    // 进度条view
    UIView *valueBg = [[UIView alloc] initWithFrame:CGRectMake(0, 15, self.width, 7.f)];
    valueBg.layer.cornerRadius = 3.5;
    valueBg.clipsToBounds = YES;
    valueBg.backgroundColor = kColorBGGay;
    [self addSubview:valueBg];
    
    //进度条颜色
    self.pmgressbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, 0, 7.f)];
    [self.pmgressbarView setBackgroundColor:kColorBGRed];
    [self addSubview:self.pmgressbarView];
    
    //左滑块
    UIImageView *leftSlideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    leftSlideImageView.centerY = valueBg.centerY;
    leftSlideImageView.centerX = 0;
    leftSlideImageView.image = IMAGE(@"icon_sliderBtn");
    self.leftSlideImageView = leftSlideImageView;
    [self addSubview:leftSlideImageView];
    //左滑块添加滑动手势
    UIPanGestureRecognizer *leftPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(leftSliderMove:)];
    [leftPanRecognizer setMinimumNumberOfTouches:1];
    [leftPanRecognizer setMaximumNumberOfTouches:1];
    [leftSlideImageView setUserInteractionEnabled:YES];
    [leftSlideImageView addGestureRecognizer:leftPanRecognizer];
    
    
    //右滑块
    UIImageView *rightSlideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    rightSlideImageView.centerY = valueBg.centerY;
    rightSlideImageView.centerX = self.width;
    rightSlideImageView.image = IMAGE(@"icon_sliderBtn");
    self.rightSlideImageView = rightSlideImageView;
    [self addSubview:rightSlideImageView];
    //右滑块添加滑动手势
    UIPanGestureRecognizer *rightPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(rightSliderMove:)];
    [rightSlideImageView setUserInteractionEnabled:YES];
    [rightSlideImageView addGestureRecognizer:rightPanRecognizer];
    [self updateData];
}

-(void)setTotalSection:(NSInteger)totalSection{
    _totalSection = totalSection;
    //刻度值
    for (int i = 0; i < totalSection + 1; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * self.origWidth / totalSection, 30, self.origWidth / totalSection, 20)];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = kColorTextGay;
        if (i == totalSection) {
            self.lastLabel = label;
            label.centerX = i* self.origWidth / totalSection;
            label.width = self.origWidth / totalSection + 4 *kExtendLength;
            label.text = @"不限";
        }else{
            label.centerX = i* self.origWidth / totalSection;
            label.text = [@(i * self.maxValue / totalSection) stringValue];
        }
    }
}

-(void)leftSliderMove:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.leftSlideImageView];
    CGFloat x =  self.leftSlideImageView.center.x + point.x;
    NSLog(@"left pint x : --------- %f",x);
    if(x > self.width){
        x = self.width;
    }else if (x< 0 ){
        x = 0;
    }
    self.leftValue = [self x2price:ceilf(x)];
    self.leftSlideImageView.center = CGPointMake(ceilf(x), self.leftSlideImageView.center.y);
    
    if (self.rightValue-self.leftValue <= self.minIntervalValue) {
        self.rightValue = self.leftValue + self.minIntervalValue;
        self.rightSlideImageView.center = CGPointMake([self price2x:self.rightValue], self.rightSlideImageView.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self];
    [self updateData];
}

- (void)rightSliderMove:(UIPanGestureRecognizer *)pan{
    CGPoint point = [pan translationInView:self.rightSlideImageView];
    CGFloat x =  self.rightSlideImageView.center.x + point.x;
    NSLog(@"right pint x : --------- %f",x);
    if(x > self.width){
        x = self.width;
    }else if (x< 0 ){
        x = 0;
    }
    self.rightValue = [self x2price:ceilf(x)];
    NSLog(@"rightValue : --------- %f",self.rightValue);

    self.rightSlideImageView.center = CGPointMake(ceilf(x), self.rightSlideImageView.center.y);
    
    if (self.rightValue-self.leftValue <= self.minIntervalValue ) {
        self.leftValue = (self.rightValue - self.minIntervalValue) < 0 ? 0 : (self.rightValue - self.minIntervalValue);
        self.leftSlideImageView.center = CGPointMake([self price2x:self.leftValue], self.leftSlideImageView.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self];
    [self updateData];
}

- (void)updateData{
    //    [resultLabel setText:[NSString stringWithFormat:@"%.0f~%.0f",leftValue,rightValue]];
    //
    CGRect progressRect = CGRectMake(self.leftSlideImageView.center.x, self.pmgressbarView.frame.origin.y, self.rightSlideImageView.center.x - self.leftSlideImageView.center.x, self.pmgressbarView.frame.size.height);
    self.pmgressbarView.frame = progressRect;
    //    self.rightValue = self.rightValue + 1;
    //    if (self.rightSlideImageView.centerX >= self.width) {
    //        self.rightValue = 100000; // 在最右侧的时候
    //    }
    if (self.callBack) {
        self.callBack(self.leftValue,self.rightValue);
    }
}
- (UILabel *)topLabel{
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 150, 20)];
        _topLabel.alpha = 0.0;
        _topLabel.font = [UIFont systemFontOfSize:14];
        _topLabel.textColor = [UIColor blackColor];
        [self addSubview:_topLabel];
    }
    return _topLabel;
}
- (void)updateWithLeftValue:(NSInteger)leftValue rightValue:(NSInteger)rightValue{
    self.leftValue = leftValue;
    self.rightValue = rightValue;
    CGFloat leftX = [self price2x:leftValue];
    CGFloat rightX = [self price2x:rightValue];
    //    if (leftValue == self.maxValue) {
    //        leftX = self.width - kExtendLength;
    //        rightX = self.width;
    //    }
    self.leftSlideImageView.center = CGPointMake(leftX,self.leftSlideImageView.center.y);
    self.rightSlideImageView.center = CGPointMake(rightX,self.rightSlideImageView.center.y);
    [self updateData];
}

//坐标->数字
- (NSInteger)x2price:(CGFloat)x{
    NSInteger price = 0.f;
    if(x <= self.origWidth * self.totalSection /self.totalSection){
        price = (x * self.maxValue)/self.origWidth;
        self.topLabel.text = [NSString stringWithFormat:@"%.1f & %.1fd & %ldf",self.origWidth, self.maxValue,self.totalSection];
    }else{
        price = 10000;
    }
    return price;
}

//数字->坐标
- (CGFloat)price2x:(CGFloat)price{
    NSLog(@"price=====%f",price);
    CGFloat x;
    if (price <= self.maxValue) {
        x = price * self.origWidth / self.maxValue;
    }else{
        x = self.width;
    }
    return x;
}
@end
