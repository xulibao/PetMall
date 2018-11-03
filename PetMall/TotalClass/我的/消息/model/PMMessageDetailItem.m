//
//  PMMyCommentItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMessageDetailItem.h"
#import "PMMessageDetailCell.h"
@implementation PMMessageDetailItem
@synthesize cellClass = _cellClass;
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMMessageDetailCell class];
    }
    return _cellClass;
}

@end
