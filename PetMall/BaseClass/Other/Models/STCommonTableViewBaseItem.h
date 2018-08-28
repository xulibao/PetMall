//
//  STCommonTableViewBaseItem.h
//  SnailAuction
//
//  Created by imeng on 2018/2/7.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STCommonTableViewProtocol.h"

@interface STCommonBaseTableItem : NSObject<STCommonTableItem>

@property(nonatomic, copy) UIImage *image;
@property(nonatomic, copy) NSObject *titleText;
@property(nonatomic, copy) NSObject *descriptionText;
@property(nonatomic, strong) id userInfo;

@property(nonatomic, copy) NSIndexPath *indexPath;

@property(nonatomic, copy, readonly) NSArray<id<STCommonTableViewItemUpdateDelegate>> *delegates;

- (void)addDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate;
- (void)removeDelegate:(id<STCommonTableViewItemUpdateDelegate>)delegate;

@end

@interface STCommonBaseTableRowItem : STCommonBaseTableItem<STCommonTableRowItem>

@property(nonatomic, assign) Class cellClass;

@property(nonatomic, copy) NSString *cellIdentifier;

@end

@interface STCommonBaseTableSectionItem : STCommonBaseTableItem<STCommonTableSectionItem>

@property(nonatomic, assign) Class cellClass;
@property(nonatomic, copy) NSString *cellIdentifier;

@property(nonatomic, assign) Class headerClass;
@property(nonatomic, assign) Class footerClass;

@property(nonatomic, copy) NSString *headerIdentifier;
@property(nonatomic, copy) NSString *footerIdentifier;

@property(nonatomic, assign) CGFloat headerHeight;
@property(nonatomic, assign) CGFloat footerHeight;

@property(nonatomic, copy) __kindof NSArray<id<STCommonTableRowItem>> *rows;

@end


