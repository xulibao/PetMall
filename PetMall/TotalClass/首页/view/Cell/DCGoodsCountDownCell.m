//
//  DCGoodsCountDownCell.m
//  CDDMall
//
//  Created by apple on 2017/6/5.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodsCountDownCell.h"

// Controllers

// Models
// Views
#import "DCGoodsSurplusCell.h"
// Vendors
#import <MJExtension.h>
#import "PMHomeModel.h"

@interface DCGoodsCountDownCell ()<UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>

/* collection */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 推荐商品数据 */
@property (strong , nonatomic)NSMutableArray<DCRecommendItem *> *countDownItem;
/* 底部 */
@property (strong , nonatomic)UIView *bottomLineView;

@end

static NSString *const DCGoodsSurplusCellID = @"DCGoodsSurplusCell";

@implementation DCGoodsCountDownCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_collectionView];
        _collectionView.frame = self.bounds;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[DCGoodsSurplusCell class] forCellWithReuseIdentifier:DCGoodsSurplusCellID];
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
    self.backgroundColor = [UIColor grayColor];
    self.collectionView.backgroundColor = self.backgroundColor;
    NSArray *countDownArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"CountDownShop.plist" ofType:nil]];
    _countDownItem = [DCRecommendItem mj_objectArrayWithKeyValuesArray:countDownArray];
    
    _bottomLineView = [[UIView alloc] init];
//    _bottomLineView.backgroundColor = DCBGColor;
    [self addSubview:_bottomLineView];
//    _bottomLineView.frame = CGRectMake(0, self.height - 8, kMainBoundsWidth, 8);
}

#pragma mark - Setter Getter Methods
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count > 2 ? 2 : 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (0 == section) {
        return 2;
    }else{
        return 3;
    }
//    return _countDownItem.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DCGoodsSurplusCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSurplusCellID forIndexPath:indexPath];
    cell.secondkillModel = self.dataArray[indexPath.section * 2+ indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return CGSizeMake(kMainBoundsWidth * 0.5  , 180);
    }else{
        return CGSizeMake(kMainBoundsWidth / 3  , 180);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DCRecommendItem *recommendItem = _countDownItem[indexPath.row];

    if (self.DCGoodsCountDownCellBlock) {
        self.DCGoodsCountDownCellBlock(recommendItem);
    }
    
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

@end
