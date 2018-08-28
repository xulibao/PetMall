//
//  SADropDownMenu.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SADropDownCollectionModel.h"
#import "SADropDownMenuCollectionFooterView.h"
#import "SAMenuRecordModel.h"
#import "SADropDownMenuTableCell.h"
@interface SADropDownIndexPath : NSObject

@property (nonatomic, assign) NSInteger column;
// 0 左边   1 右边
@property (nonatomic, assign) NSInteger leftOrRight;
// 左边行
@property (nonatomic, assign) NSInteger leftRow;
// 右边行
@property (nonatomic, assign) NSInteger row;

- (instancetype)initWithColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row;
+ (instancetype)indexPathWithCol:(NSInteger)col leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row;

@end

#pragma mark - data source protocol
@class SADropDownMenu;

@protocol SADropDownMenuDataSource <NSObject>

@required
// 返回相应tableView numberOfRowsInColumn
- (NSInteger)menu:(SADropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column;
//tableView cellForRow
- (SAMenuRecordModel *)menu:(SADropDownMenu *)menu modelForRowAtIndexPath:(SADropDownIndexPath *)indexPath;

- (NSString *)menu:(SADropDownMenu *)menu titleForColumn:(NSInteger)column;

- (SADropDownCollectionModel *)menu:(SADropDownMenu *)menu titleForRowAtIndexPath:(SADropDownIndexPath *)indexPath;

@optional
//default value is 1
- (NSInteger)numberOfColumnsInMenu:(SADropDownMenu *)menu;

/**
 * 是否需要显示为UICollectionView 默认为否
 */
- (BOOL)displayByCollectionViewInColumn:(NSInteger)column;

@end

#pragma mark - delegate
@protocol SADropDownMenuDelegate <NSObject>
@optional
- (void)menu:(SADropDownMenu *)menu tabIndex:(NSInteger)currentTapIndex;
- (void)menu:(SADropDownMenu *)menu didSelectRowAtIndexPath:(SADropDownIndexPath *)indexPath;

- (void)menuDidConfirm:(SADropDownMenu *)menu recordArray:(NSArray *)recordArray;

@end

#pragma mark - interface
@interface SADropDownMenu : UIView <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) id <SADropDownMenuDataSource> dataSource;
@property (nonatomic, weak) id <SADropDownMenuDelegate> delegate;

@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *separatorColor;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *qudongArray;
@property (nonatomic, strong) NSArray *ranliaoArray;
@property (nonatomic, strong) NSArray *paifangArray;
@property(nonatomic, strong) SADropDownMenuCollectionFooterView * footerView;
- (void)showOrDismissWithIndex:(NSInteger)index;

/**
 
 */
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height;
- (NSString *)titleForRowAtIndexPath:(SADropDownIndexPath *)indexPath;

@end

