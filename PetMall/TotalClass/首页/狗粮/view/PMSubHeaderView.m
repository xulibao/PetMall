//
//  PMSubHeaderView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/11/28.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import "PMSubHeaderView.h"

@implementation PMSubHeaderView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView * view = [super hitTest:point withEvent:event];
    CGPoint hitPoint = [self convertPoint:point toView:self.tableView];
    if ([self.tableView pointInside:hitPoint withEvent:event]) {
        return self.tableView;
    }else{
        return [super hitTest:point withEvent:event];
    }
}
@end
