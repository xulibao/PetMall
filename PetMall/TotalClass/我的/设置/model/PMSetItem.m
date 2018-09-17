//
//  PMMyCommentItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSetItem.h"
#import "PMSetCell.h"
@implementation PMSetItem
@synthesize cellClass = _cellClass;
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMSetCell class];
    }
    return _cellClass;
}

@end
