//
//  STMenuSelectRecordBtn.m
//  SnailTruck
//
//  Created by 唐欢 on 16/5/28.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STMenuSelectRecordBtn.h"

@implementation STMenuSelectRecordBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.alignmentStatus = kAlignmentStatusCenter;
    }
    return self;
}
@end
