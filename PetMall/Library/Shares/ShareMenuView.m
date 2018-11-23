//
//  ShareMenuView.m
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import "ShareMenuView.h"


@interface ShareMenuView ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIToolbar   *toolbar;
@property (nonatomic, strong) NSMutableArray *subButtons;
@end

@implementation ShareMenuView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backView = [[UIImageView alloc] init];
        
        self.toolbar = [[UIToolbar alloc] init];
        self.toolbar.barStyle = UIBarStyleDefault;
        [self.backView addSubview:self.toolbar];
        [self addSubview:self.backView];
        self.subButtons = [NSMutableArray array];
    }
    return self;
}


- (void)setBackGround:(UIView *)backGround {
    
    _backGround = backGround;
    self.backView.image = [self convertViewToImageWithView:self.backGround];
}

- (void)setIsMoveIn:(BOOL)isMoveIn {
    _isMoveIn = isMoveIn;
    
    if (isMoveIn) {
        [self moveInAnimation];
    }else{
        [self moveOutAnimation];
    }
}


- (void)moveInAnimation {
    [self.subButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ShareItem * item = obj;
        CGFloat x = item.frame.origin.x;
        CGFloat y = item.frame.origin.y;
        CGFloat width = item.frame.size.width;
        CGFloat height = item.frame.size.height;
        item.frame = CGRectMake(x, self.bounds.size.height + y, width, height);
        item.alpha = 0.0;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:25 options:UIViewAnimationOptionCurveEaseIn animations:^{
                item.alpha = 1;
                item.frame = CGRectMake(x, y, width, height);
            } completion:^(BOOL finished) {}];
        });
        
    }];
}

- (void)moveOutAnimation {
    [self.subButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ShareItem * item = obj;
        CGFloat x = item.frame.origin.x;
        CGFloat y = item.frame.origin.y;
        CGFloat width = item.frame.size.width;
        CGFloat height = item.frame.size.height;
        item.alpha = 1;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(idx * 0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.35 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:5 options:0 animations:^{
                item.alpha = 0.0;
                item.frame = CGRectMake(x, self.bounds.size.height + y, width, height);
            } completion:^(BOOL finished) {
            item.frame = CGRectMake(x, y, width, height);
            }];
        });
        
    }];
}

- (void)setPlatforms:(NSArray *)platforms {
    _platforms= platforms;
    
    CGFloat x = 35;
    int colow = 3;
    CGFloat margin = (MainWidth - colow * ShareItemWidth - 2 * x) / (colow- 1);


    for (int i =0; i < platforms.count; i++) {
        int col = i % colow;
        int row = i / colow;

        ShareItem *item = [ShareItem shareItemWithPlatformType:[platforms[i] integerValue]];
        CGFloat itemX = x + col * (ShareItemWidth + margin);
        CGFloat itemY = row * ShareItemHeight;
        item.frame = CGRectMake(itemX, itemY, ShareItemWidth, ShareItemHeight);
        [item addTarget:self action:@selector(clickItem:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:item];
        [self.subButtons addObject:item];
        
    }
   
}


- (void)clickItem:(ShareItem *)item {
    
    if ([self.delegate respondsToSelector:@selector(selectPlatform:)]) {
        [self.delegate selectPlatform:item];
    }
}



- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.backView.frame = self.bounds;
    self.toolbar.frame = self.bounds;
}


-(UIImage *)convertViewToImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [view drawViewHierarchyInRect:CGRectMake(0, kMainBoundsHeight- self.height, kMainBoundsWidth, self.height) afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end
