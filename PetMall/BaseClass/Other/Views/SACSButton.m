//
//  SACSButton.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SACSButton.h"

@implementation SACSButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitle:@"联系客服" forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTintColor:[UIColor whiteColor]];
        [self.titleLabel setFont:UIFontMake(18)];
    }
    return self;
}

@end
