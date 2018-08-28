//
//  SACommonTableModel.m
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STCommonTableViewModel.h"

@interface STCommonTableViewModel ()

@property(nonatomic, strong) STCommonBaseTableSectionItem *defaultSection;

@end

@implementation STCommonTableViewModel {
    NSMutableArray *p_dataSource;
}

- (instancetype)init {
    return [self initWithTableView:nil];
}

- (instancetype)initWithTableView:(__kindof UITableView *)tableView {
    self = [super init];
    p_dataSource = [NSMutableArray array];
    self.tableView = tableView;
    return self;
}

- (void)addSection:(id<STCommonTableSectionItem>)section {
    if ([section conformsToProtocol:@protocol(STCommonTableSectionItem)]) {
        [p_dataSource addObject:section];
    }
}

- (void)addRow:(id<STCommonTableRowItem>)row {
    NSInteger section = p_dataSource.count > 0 ? p_dataSource.count - 1 : 0;
    [self addRows:@[row] inSection:section];
}

- (void)addRows:(NSArray<id<STCommonTableRowItem>> *)rows inSection:(NSUInteger)section {
    id<STCommonTableSectionItem> sectionItem = nil;
    if (!p_dataSource.count) {
        sectionItem = self.defaultSection;
    } else {
        if (p_dataSource.count > section) {
            sectionItem = p_dataSource[section];
        }
    }
    NSUInteger row = [sectionItem rows].count;
    [self insertRows:rows atIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
}

- (void)insertRows:(NSArray<id<STCommonTableRowItem>> *)rows
       atIndexPath:(NSIndexPath *)indexPath {
    if (!rows) {
        return;
    }
    if (![rows isKindOfClass:[NSArray class]]) {
        NSAssert([rows isKindOfClass:[NSArray class]], @"rows 必须为数组.");
        return;
    }
    id<STCommonTableSectionItem> sectionItem = nil;
    if (!p_dataSource.count) {
        sectionItem = self.defaultSection;
    } else {
        if (p_dataSource.count > indexPath.section) {
            sectionItem = p_dataSource[indexPath.section];
        }
    }
    
    if ([sectionItem respondsToSelector:@selector(insertItems:atIndex:)]) {
        [sectionItem insertItems:rows atIndex:indexPath.row];
        [rows enumerateObjectsUsingBlock:^(id<STCommonTableRowItem>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.tableView registerClass:obj.cellClass forCellReuseIdentifier:obj.cellIdentifier];
        }];
    }
}

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath {
    id<STCommonTableSectionItem> sectionItem = nil;
    if (!p_dataSource.count) {
        sectionItem = self.defaultSection;
    } else {
        if (p_dataSource.count > indexPath.section) {
            sectionItem = p_dataSource[indexPath.section];
        }
    }
    
    if ([sectionItem respondsToSelector:@selector(removeItemAtIndex:)]) {
        [sectionItem removeItemAtIndex:indexPath.row];
    }
}

- (void)removeAllObjects {
    [p_dataSource enumerateObjectsUsingBlock:^(id<STCommonTableSectionItem>obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj respondsToSelector:@selector(removeAllItems)]) {
            [obj removeAllItems];
        }
    }];
    
    [p_dataSource removeAllObjects];
}

#pragma mark - Public

- (NSUInteger)numberOfSections {
    return p_dataSource.count;
}

- (NSUInteger)numberOfRowsInSection:(NSUInteger)section {
    return [self rowsAtSection:section].count;
}

- (id<STCommonTableSectionItem>)objectAtSection:(NSUInteger)section {
    if (section >= p_dataSource.count ) return nil; //规避越界
    
    id sectionItem = p_dataSource[section];
    
    if ([sectionItem conformsToProtocol:@protocol(STCommonTableSectionItem)]) {
        return sectionItem;
    } else {
        return nil;
    }
}

- (NSArray<id<STCommonTableRowItem>> *)rowsAtSection:(NSUInteger)section {
    id<STCommonTableSectionItem> sectionItem = [self objectAtSection:section];
    NSArray *sectionValue = [sectionItem respondsToSelector:@selector(rows)] ? [sectionItem rows] : nil;
    
    if ([sectionValue isKindOfClass:[NSArray class]]) { //判断类型
        return sectionValue;
    } else {
        return nil;
    }
}

- (id<STCommonTableRowItem>)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<id<STCommonTableRowItem>> *rows = [self rowsAtSection:indexPath.section];
    
    if (indexPath.row >= rows.count ) return nil; //规避越界
    
    id rowItem = rows[indexPath.row];
    
    if ([rowItem conformsToProtocol:@protocol(STCommonTableRowItem)]) {
        if ([rowItem respondsToSelector:@selector(setIndexPath:)]) {
            [rowItem setIndexPath:indexPath];
        }
        return rowItem;
    } else {
        NSAssert1(0, @"rowItem :%@ mastConform STCommonTableRowItem Protocol", rowItem);
        return nil;
    }
}

- (id<STCommonTableRowItem>)objectWithCell:(__kindof UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    return [self objectAtIndexPath:indexPath];
}

- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = nil;
    
    id<STCommonTableRowItem> rowItem = [self objectAtIndexPath:indexPath];
    
    
    if (rowItem.cellIdentifier && rowItem.cellIdentifier.length > 0) {
        //如果模型指定了 viewIdentifier 那么直接返回模型指定的 viewIdentifier
        cellIdentifier = rowItem.cellIdentifier;
    } else {
        //否则返回的 section 中的 cellIdentifier
        id<STCommonTableSectionItem> sectionItem = [self objectAtSection:indexPath.section];
        cellIdentifier = sectionItem.cellIdentifier;
    }
    return cellIdentifier;
}

- (NSString *)viewIdentifierForHeaderInSection:(NSUInteger)section {
    id<STCommonTableSectionItem> sectionItem = [self objectAtSection:section];
    return sectionItem.headerIdentifier;
}

- (NSString *)viewIdentifierForFooterInSection:(NSUInteger)section {
    id<STCommonTableSectionItem> sectionItem = [self objectAtSection:section];
    return sectionItem.footerIdentifier;
}

- (void)setTableView:(__kindof UITableView *)tableView {
    _tableView = tableView;
    if (tableView && !tableView.dataSource) {
        _tableView.dataSource = tableView.dataSource ? tableView.dataSource : self;
    }
    if (tableView && !tableView.delegate) {
        _tableView.delegate = tableView.delegate ? tableView.delegate : self;
    }
    
    // 保证一直存在tableFooterView，以去掉列表内容不满一屏时尾部的空白分割线
    _tableView.tableFooterView = tableView.tableFooterView ? tableView.tableFooterView : [[UIView alloc] init];
}

- (STCommonBaseTableSectionItem *)defaultSection {
    if (!_defaultSection) {
        _defaultSection = [[STCommonBaseTableSectionItem alloc] init];
    }
    if (![p_dataSource containsObject:_defaultSection]) {
        [p_dataSource addObject:_defaultSection];
    }
    return _defaultSection;
}

@end

@implementation STCommonTableViewModel (TableDataSource)

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.tableViewDataSource respondsToSelector:_cmd]) {
        return [self.tableViewDataSource tableView:tableView numberOfRowsInSection:section];
    }
    return [self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDataSource respondsToSelector:_cmd]) {
        return [self.tableViewDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }

    id object = [self objectAtIndexPath:indexPath];
    NSString *identifier = [self cellIdentifierAtIndexPath:indexPath];
    
    UITableViewCell <STCommonTableViewItemConfigProtocol>*cell = (id)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
//    if (!cell) {
//        cell = (id)[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:identifier?identifier:@"cell"];
//    }
    if ([cell respondsToSelector:@selector(tableView:configViewWithData:AtIndexPath:)]) {
        [cell tableView:tableView configViewWithData:object AtIndexPath:indexPath];
    }else {
        NSLog(@"%@", cell);
    }
    if (self.cellDelegate && [cell respondsToSelector:@selector(setCellDelegate:)]) {
        [cell setCellDelegate:self.cellDelegate];
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.tableViewDataSource respondsToSelector:_cmd]) {
        return [self.tableViewDataSource numberOfSectionsInTableView:tableView];
    }
    return [self numberOfSections];
}

//设置可删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableViewDataSource respondsToSelector:_cmd]) {
        return [self.tableViewDataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    return NO;
}

//左滑点击事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDataSource respondsToSelector:_cmd]) {
        return [self.tableViewDataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}
@end

@implementation STCommonTableViewModel (TableDelegate)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    id<UIScrollViewDelegate> delegate = self.tableViewDelegate;
    if ([delegate respondsToSelector:_cmd]) {
        [delegate scrollViewDidScroll:scrollView];
    };
}

#pragma mark - UITableViewDelegate

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell<STCommonTableViewItemConfigProtocol> *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    if ([cell respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:withViewData:)]) {
        id object = [self objectAtIndexPath:indexPath];
        [cell tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath withViewData:object];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell<STCommonTableViewItemConfigProtocol> *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
    if ([cell respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:withViewData:)]) {
        id object = [self objectAtIndexPath:indexPath];
        [cell tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath withViewData:object];
    }
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }

    NSString *identifier = [self cellIdentifierAtIndexPath:indexPath];
    
    return [tableView fd_heightForCellWithIdentifier:identifier cacheByKey:[NSString stringWithFormat:@"%@:%zd%zd", identifier,indexPath.section,indexPath.row] configuration:^(id cell) {
        id object = [self objectAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(tableView:configViewWithData:AtIndexPath:)]) {
            [cell tableView:tableView configViewWithData:object AtIndexPath:indexPath];
        }
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView heightForHeaderInSection:section];
    }

    id<STCommonTableSectionItem> object = [self objectAtSection:section];
    CGFloat height = [object respondsToSelector:@selector(headerHeight)] ? [object headerHeight] : tableView.sectionHeaderHeight;
    return height == STCommonTableItemUndefineFloat ? tableView.sectionHeaderHeight : height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView heightForFooterInSection:section];
    }

    id<STCommonTableSectionItem> object = [self objectAtSection:section];
    CGFloat height = [object respondsToSelector:@selector(footerHeight)] ? [object footerHeight] : tableView.sectionHeaderHeight;
    return height == STCommonTableItemUndefineFloat ? tableView.sectionFooterHeight : height;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    NSString *identifier = [self cellIdentifierAtIndexPath:indexPath];
    
    //fixbug 当TableView 使用 self-sizing-cells (iOS11 默认) (tableView.estimatedRowHeight = UITableViewAutomaticDimension)时，调用reloadData会造成 tableView 的 contentOffset 偏移问题。 见：https://stackoverflow.com/a/38729250
    // Hit cache
    if ([tableView.fd_keyedHeightCache existsHeightForKey:[NSString stringWithFormat:@"%@:%zd%zd", identifier,indexPath.section,indexPath.row]]) {
        return [self tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return tableView.estimatedRowHeight;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section {
//    return [self tableView:tableView heightForHeaderInSection:section];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
//    return [self tableView:tableView heightForFooterInSection:section];
//}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView viewForHeaderInSection:section];
    }
    id<STCommonTableSectionItem> object = [self objectAtSection:section];
    NSString * identifier = [self viewIdentifierForHeaderInSection:section];
    if (!identifier) {
        return nil;
    }
    
    UITableViewHeaderFooterView <STCommonTableViewItemConfigProtocol>*sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier?identifier:@"header"];
    if ([sectionHeaderView respondsToSelector:@selector(tableView:configViewWithData:AtIndexPath:)]) {
        [sectionHeaderView tableView:tableView configViewWithData:object AtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }else {
        NSLog(@"%@", sectionHeaderView);
    }
    
    return sectionHeaderView;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView viewForFooterInSection:section];
    }

    id<STCommonTableSectionItem> object = [self objectAtSection:section];
    NSString * identifier = [self viewIdentifierForFooterInSection:section];
    if (!identifier) {
        return nil;
    }
    
    UITableViewHeaderFooterView <STCommonTableViewItemConfigProtocol>*sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier?identifier:@"header"];
    if ([sectionHeaderView respondsToSelector:@selector(tableView:configViewWithData:AtIndexPath:)]) {
        [sectionHeaderView tableView:tableView configViewWithData:object AtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    }else {
        NSLog(@"%@", sectionHeaderView);
    }
    
    return sectionHeaderView;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    return YES;
}

//滑动删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

//滑动删除begin预处理
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

//滑动删除结束处理
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

//修改左滑的按钮的字
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath {
    if ([self.tableViewDelegate respondsToSelector:_cmd]) {
        return [self.tableViewDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexpath];
    }
    return @"删除";
}


@end

