//
//  STCommonTableViewProtocol.h
//  OMan
//
//  Created by imeng
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

static CGFloat const STCommonTableItemUndefineFloat =  -1;

@protocol STCommonTableViewItemUpdateDelegate;

@protocol STCommonTableItem <NSObject>

- (UIImage *)image;
- (id)titleText;//NSAttributedString/NSString
- (id)descriptionText;//NSAttributedString/NSString
- (id)userInfo;

- (NSIndexPath *)indexPath;

- (void)addDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate;
- (void)removeDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate;

@end

@protocol STCommonTableRowItem <STCommonTableItem>

- (Class )cellClass;
- (NSString *)cellIdentifier;

- (UIViewController *)createDetailViewController;

@end

@protocol STCommonTableSectionItem <STCommonTableRowItem>

- (Class )headerClass;
- (Class )footerClass;

- (NSString *)headerIdentifier;
- (NSString *)footerIdentifier;

- (CGFloat)headerHeight;
- (CGFloat)footerHeight;

- (NSArray *)rows;

- (void)addRows:(NSArray<id<STCommonTableRowItem>> *)rows;
- (void)insertItems:(NSArray<id<STCommonTableRowItem>> *)items atIndex:(NSUInteger)index;
- (void)removeAllItems;
- (void)removeItemAtIndex:(NSUInteger)index;

@end

@protocol STCommonTableViewItemConfigProtocol <NSObject>

@required;
- (void)tableView:(UITableView *)tableView configViewWithData:(id<STCommonTableItem>)data AtIndexPath:(NSIndexPath *)indexPath;

@optional;

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withViewData:(id<STCommonTableRowItem>)viewData;
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath withViewData:(id<STCommonTableRowItem>)viewData;

- (void)setCellDelegate:(id)cellDelegate;

@end

@protocol STCommonTableViewCellDelegate <NSObject>

@end

@protocol STCommonTableViewItemUpdateDelegate <NSObject>

- (void)objectDidUpdate:(id)object;
- (void)objectDidExpired:(id)object;

@end

