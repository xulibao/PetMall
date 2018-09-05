//
//  PMSpecialClearanceCell.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSpecialClearanceCell.h"
#import "DCRecommendItem.h"
// Views
#import "PMSpecialClearanceSubCell.h"
// Vendors
#import <MJExtension.h>

@interface PMSpecialClearanceCell()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 推荐商品数据 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;
@end
static NSString *const PMSpecialClearanceSubCellID = @"PMSpecialClearanceSubCell";

@implementation PMSpecialClearanceCell
#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 1;
        layout.itemSize = CGSizeMake(self.height * 0.55, self.height * 0.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[PMSpecialClearanceSubCell class] forCellWithReuseIdentifier:PMSpecialClearanceSubCellID];
    }
    return _collectionView;
}

- (NSMutableArray<DCRecommendItem *> *)countDownItem
{
    if (!_countDownItem) {
        _countDownItem = [NSMutableArray array];
    }
    return _countDownItem;
}

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CountDownShop.plist" ofType:nil]];
    _countDownItem = [DCRecommendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    
    _bottomLineView = [[UIView alloc] init];
//    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.height - 8, kMainBoundsWidth, 8);
}

#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _countDownItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PMSpecialClearanceSubCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMSpecialClearanceSubCellID forIndexPath:indexPath];
    cell.recommendItem = _countDownItem[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
    
}
@end
