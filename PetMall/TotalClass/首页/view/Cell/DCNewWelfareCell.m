//
//  DCNewWelfareCell.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/11/29.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCNewWelfareCell.h"

#import "DCNewWelfareLayout.h"
#import "DCGoodsHandheldCell.h"
#import "PMHomeModel.h"
@interface DCNewWelfareCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,DCNewWelfareLayoutDelegate>

/* collectionView */
@property (strong , nonatomic)UICollectionView *collectionView;

@end

static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";

@implementation DCNewWelfareCell

#pragma mark - lazyload
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView.frame = self.bounds;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self addSubview:_collectionView];
        
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderReusableView"]; //注册头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterReusableView"]; //注册尾部
    }
    return _collectionView;
}


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpBase];
    }
    return self;
}

#pragma mark - initialize
- (void)setUpBase
{
    self.backgroundColor = [UIColor clearColor];
    self.collectionView.backgroundColor = self.backgroundColor;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        return CGSizeMake(kMainBoundsWidth, 180);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DCGoodsHandheldCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsHandheldCellID forIndexPath:indexPath];
    cell.presaleModel = self.dataArray[indexPath.row];
    return cell;
    
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    if (kind == UICollectionElementKindSectionHeader) {
//        
//        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderReusableView" forIndexPath:indexPath];
//        return headerView;
//        
//    } else if (kind == UICollectionElementKindSectionFooter) {
//        
//        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"FooterReusableView" forIndexPath:indexPath];
//        footerView.backgroundColor = [UIColor clearColor];
//        return footerView;
//    }
//    
//    return [UICollectionReusableView new];
//}


#pragma mark - item点击
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellDidSellect) {
        self.cellDidSellect();
    }
}


#pragma mark - DCItemSortLayoutDelegate
#pragma mark - 底部高度
-(CGFloat)dc_HeightOfSectionFooterForIndexPath:(NSIndexPath *)indexPath {
    return 10;
}
#pragma mark - 头部高度
-(CGFloat)dc_HeightOfSectionHeaderForIndexPath:(NSIndexPath *)indexPath {
    return 0;
}


- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}
@end
