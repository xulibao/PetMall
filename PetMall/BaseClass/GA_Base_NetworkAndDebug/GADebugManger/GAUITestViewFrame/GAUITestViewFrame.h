//
//  GAUITestViewFrame.h
//  GHPlaceHolderSize
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GAUITestViewFrameConfig : NSObject

+ (GAUITestViewFrameConfig*) defaultConfig;

@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, assign) BOOL showArrow;
@property (nonatomic, assign) BOOL showText;


@property (nonatomic, assign) BOOL visible;
@property (nonatomic, assign) BOOL autoDisplay;
@property (nonatomic, assign) BOOL autoDisplaySystemView;
@property (nonatomic, strong) NSArray *visibleMemberOfClasses;
@property (nonatomic, strong) NSArray *visibleKindOfClasses;

@end

@interface GAUITestViewFrame : UIView

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, assign) CGFloat arrowSize;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *frameColor;
@property (nonatomic, assign) CGFloat frameWidth;

@property (nonatomic, assign) BOOL showArrow;
@property (nonatomic, assign) BOOL showText;

@end

@interface  UIView(GAUITestViewFrame)

- (void)showPlaceHolder;
- (void)showPlaceHolderWithAllSubviews;
- (void)showPlaceHolderWithAllSubviews:(NSInteger)maxDepth;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth;
- (void)showPlaceHolderWithLineColor:(UIColor*)lineColor backColor:(UIColor*)backColor arrowSize:(CGFloat)arrowSize lineWidth:(CGFloat)lineWidth frameWidth:(CGFloat)frameWidth frameColor:(UIColor*)frameColor;

- (void)hidePlaceHolder;
- (void)hidePlaceHolderWithAllSubviews;
- (void)removePlaceHolder;
- (void)removePlaceHolderWithAllSubviews;
- (GAUITestViewFrame *)getPlaceHolder;

@end