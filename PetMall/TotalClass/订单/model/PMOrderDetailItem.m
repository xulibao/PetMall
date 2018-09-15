//
//  PMOrderDetailItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailItem.h"
#import "PMOrderDetailCell.h"
#import "NSAttributedString+STAttributedString.h"

@implementation PMOrderDetailItem

@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMOrderDetailCell class];
    }
    return _cellClass;
}
//标签
- (NSArray<NSAttributedString*> *)tagsText {
    NSMutableArray *aTags = [NSMutableArray array];
    [aTags addObject:[@"退款" attributedStingWithAttributes:SADefaultNormalAttributes(13)]];
    return aTags;
}
@end
