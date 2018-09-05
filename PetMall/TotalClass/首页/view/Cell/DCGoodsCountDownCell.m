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
#import "DCRecommendItem.h"
// Views
#import "DCGoodsSurplusCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

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
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0.1;
//        layout.itemSize = CGSizeMake(self.width * 0.5, self.height * 0.9);
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
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
    return 2;
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
    cell.recommendItem = _countDownItem[indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return CGSizeMake(kMainBoundsWidth * 0.5 - 0.1 , 179.5);
    }else{
        return CGSizeMake(kMainBoundsWidth / 3 - 0.2 , 180);
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"点击了计时商品%zd",indexPath.row);
    
}

@end
