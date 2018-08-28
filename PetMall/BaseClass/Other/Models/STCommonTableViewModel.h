//
//  SACommonTableModel.h
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCommonTableViewProtocol.h"
#import "STCommonTableViewBaseItem.h"

@interface STCommonTableViewModel : NSObject

- (instancetype)initWithTableView:(__kindof UITableView *)tableView NS_DESIGNATED_INITIALIZER;

@property(nonatomic, weak) __kindof UITableView *tableView;

@property(nonatomic, weak) id <UITableViewDataSource> tableViewDataSource;
@property(nonatomic, weak) id <UITableViewDelegate> tableViewDelegate;
@property(nonatomic, weak) id <STCommonTableViewCellDelegate> cellDelegate;

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfRowsInSection:(NSUInteger)section;
- (id<STCommonTableSectionItem>)objectAtSection:(NSUInteger)section;
- (NSArray<STCommonTableRowItem> *)rowsAtSection:(NSUInteger)section;
- (id<STCommonTableRowItem>)objectAtIndexPath:(NSIndexPath *)indexPath ;
- (id<STCommonTableRowItem>)objectWithCell:(__kindof UITableViewCell *)cell;
- (NSString *)cellIdentifierAtIndexPath:(NSIndexPath *)indexPath ;
- (NSString *)viewIdentifierForHeaderInSection:(NSUInteger)section;
- (NSString *)viewIdentifierForFooterInSection:(NSUInteger)section;

- (void)addSection:(id<STCommonTableSectionItem>)section;

- (void)addRows:(NSArray<id<STCommonTableRowItem>> *)rows inSection:(NSUInteger)section;
- (void)addRow:(id<STCommonTableRowItem>)row;

- (void)insertRows:(NSArray<id<STCommonTableRowItem>> *)rows
        atIndexPath:(NSIndexPath *)indexPath;

- (void)removeObjectAtIndexPath:(NSIndexPath *)indexPath;

- (void)removeAllObjects;

@end

@interface STCommonTableViewModel (TableDataSource) <UITableViewDataSource>

@end

@interface STCommonTableViewModel (TableDelegate) <UITableViewDelegate>

@end

