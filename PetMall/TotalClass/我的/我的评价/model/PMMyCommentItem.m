//
//  PMMyCommentItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCommentItem.h"
#import "PMMyCommentCell.h"
@implementation PMMyCommentItem
@synthesize cellClass = _cellClass;
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMMyCommentCell class];
    }
    return _cellClass;
}

@end
