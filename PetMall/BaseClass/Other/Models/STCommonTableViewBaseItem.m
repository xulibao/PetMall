//
//  STCommonTableViewBaseItem.m
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"

@interface STCommonBaseTableItem () {
    NSHashTable<id<STCommonTableViewItemUpdateDelegate>> *p_delegates;
}

@end

@implementation STCommonBaseTableItem

- (instancetype)init {
    self = [super init];
    if (self) {
        p_delegates = [NSHashTable weakObjectsHashTable];
    }
    return self;
}

- (NSObject *)descriptionText {
    return _descriptionText;
}

- (UIImage *)image {
    return _image;
}

- (NSIndexPath *)indexPath {
    return _indexPath;
}

- (NSObject *)titleText {
    return _titleText;
}

- (id)userInfo {
    return _userInfo;
}

- (NSArray<id<STCommonTableViewItemUpdateDelegate>> *)delegates {
    @synchronized(p_delegates) {
        return [p_delegates allObjects];
    }
}

- (void)addDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate {
    @synchronized(p_delegates) {
        [p_delegates addObject:delegate];
    }
}

- (void)removeDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate {
    @synchronized(p_delegates) {
        [p_delegates removeObject:delegate];
    }
}

@end

@implementation STCommonBaseTableRowItem
@synthesize cellClass = _cellClass;

- (Class)cellClass {
    return _cellClass;
}

- (NSString *)cellIdentifier {
    if (!_cellIdentifier) {
        if (self.cellClass) {
            _cellIdentifier = [NSStringFromClass(self.cellClass) stringByAppendingString:@"identifier"];
        }
    }
    return _cellIdentifier;
}

- (UIViewController *)createDetailViewController {
    return nil;
}


- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
}

@end

@interface STCommonBaseTableSectionItem ()

@end

@implementation STCommonBaseTableSectionItem {
    NSMutableArray <id<STCommonTableRowItem>> *p_rows;
}
@synthesize cellClass = _cellClass;

- (instancetype)init
{
    self = [super init];
    if (self) {
        _headerHeight = STCommonTableItemUndefineFloat;
        _footerHeight = STCommonTableItemUndefineFloat;
    }
    return self;
}

- (Class)footerClass {
    return _footerClass;
}

- (NSString *)footerIdentifier {
    return _footerIdentifier;
}

- (Class)headerClass {
    return _headerClass;
}

- (NSString *)headerIdentifier {
    return _headerIdentifier;
}

- (NSArray *)rows {
    return self.p_rows;
}

- (Class)cellClass {
    return _cellClass;
}

- (NSString *)cellIdentifier {
    return _cellIdentifier;
}

- (UIViewController *)createDetailViewController {
    return nil;
}

- (void)addRows:(NSArray<id<STCommonTableRowItem>>*)rows {
    [self.p_rows addObjectsFromArray:rows];
}

- (void)setRows:(__kindof NSArray<__kindof STCommonBaseTableRowItem *> *)rows {
    p_rows = [NSMutableArray arrayWithArray:rows];
}

- (void)insertItems:(NSArray<id<STCommonTableRowItem>> *)items atIndex:(NSUInteger)index {
    if (items.count > 0) {
        [self.p_rows insertObjects:items atIndex:index];
    }
}

- (void)removeAllItems {
    [p_rows removeAllObjects];
}

- (void)removeItemAtIndex:(NSUInteger)index {
    if (index < p_rows.count) {
        [p_rows removeObjectAtIndex:index];
    }
}

- (void)setCellClass:(Class)cellClass {
    _cellClass = cellClass;
    _cellIdentifier = [NSStringFromClass(cellClass) stringByAppendingString:@"identifier"];
}

- (NSMutableArray *)p_rows {
    if (!p_rows) {
        p_rows = [NSMutableArray array];
    }
    return p_rows;
}

@end


