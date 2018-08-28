//
//  SAGradientView.m
//  SnailAuction
//
//  Created by imeng on 24/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SAGradientView.h"

@implementation SAGradientView

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _gradientLayer = (id)self.layer;
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FD7248"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#FF5554"].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0);
        _gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    }
    return self;
}

@end
