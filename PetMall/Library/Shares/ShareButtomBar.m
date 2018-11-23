//
//  ShareButtomBar.m
//  SnailTruck
//
//  Created by 木鱼 on 16/8/3.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "ShareButtomBar.h"

@interface ShareButtomBar ()

@property (nonatomic, strong) UIImageView *close;

@end

@implementation ShareButtomBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = kColorCellground;
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1.0f/[UIScreen mainScreen].scale)];
        line.backgroundColor = kColorSeperateLine;
        [self addSubview:line];
        
        self.close = [[UIImageView alloc] initWithImage:[self setBundleImage:@"images.bundle/tabbar_compose_background_icon_add"]];
        CGSize closeSize = self.close.size;
        self.close.frame = (CGRect){{([UIScreen mainScreen].bounds.size.width -closeSize.width) * 0.5 , (ButtomViewHeight - closeSize.height) * 0.5},closeSize};
        [self addSubview:self.close];
       
    }
    return self;
}

- (UIImage *)setBundleImage:(NSString *)imagePath{
    return [UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:imagePath]];
    
}

- (void)setIsRotate:(BOOL)isRotate {
    _isRotate = isRotate;
    
    if (isRotate) {
        
        [UIView animateWithDuration:0.25 animations:^{
            self.close.transform = CGAffineTransformMakeRotation(-M_PI_4);
        }];
        
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.close.transform = CGAffineTransformIdentity;
        }];
    }
}


@end
