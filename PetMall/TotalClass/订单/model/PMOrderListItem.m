//
//  SAOrderListItem.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//
#import "PMOrderListCell.h"
#import "NSAttributedString+STAttributedString.h"

#import "PMOrderListItem.h"

@implementation PMOrderListItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMOrderListCell class];
    }
    return _cellClass;
}

//标签
- (NSArray<NSAttributedString*> *)tagsText {
    NSMutableArray *aTags = [NSMutableArray array];
    NSString *string = [NSString stringWithFormat:@"确认收货"];
    [aTags addObject:[string attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
    [aTags addObject:[@"评价" attributedStingWithAttributes:SADefaultHighlightedAttributes(13)]];
    return aTags;
}
@end
