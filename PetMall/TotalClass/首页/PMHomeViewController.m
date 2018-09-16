//
//  PMHomeViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMHomeViewController.h"
#import "STHomeVCTopView.h"
#import "DCGridItem.h"
#import "DCRecommendItem.h"
/* cell */
#import "DCGoodsCountDownCell.h" //倒计时商品
#import "DCNewWelfareCell.h"     //新人福利
#import "DCGoodsHandheldCell.h"  //掌上专享
#import "DCExceedApplianceCell.h"//不止
#import "DCGoodsYouLikeCell.h"   //猜你喜欢商品
#import "DCGoodsGridCell.h"      //10个选项
#import "PMSpecialClearanceCell.h"
/* head */
#import "DCSlideshowHeadView.h"  //轮播图
#import "DCCountDownHeadView.h"  //倒计时标语
#import "DCYouLikeHeadView.h"    //猜你喜欢等头部标语
/* foot */
#import "DCTopLineFootView.h"    //热点
#import "DCOverFootView.h"       //结束
#import "DCScrollAdFootView.h"   //底滚动广告
#import <UIImageView+WebCache.h>
#import "DCGoodBaseViewController.h"
#import "PMLogisticsInformationViewController.h"
#import "PMTimeLimitViewController.h"
#import "PMSearchViewController.h"
#import "YWAddressDataTool.h"
#import "STCoverView.h"
/* cell */
static NSString *const DCGoodsCountDownCellID = @"DCGoodsCountDownCell";
static NSString *const DCNewWelfareCellID = @"DCNewWelfareCell";
static NSString *const DCGoodsHandheldCellID = @"DCGoodsHandheldCell";
static NSString *const DCGoodsYouLikeCellID = @"DCGoodsYouLikeCell";
static NSString *const DCGoodsGridCellID = @"DCGoodsGridCell";
static NSString *const DCExceedApplianceCellID = @"DCExceedApplianceCell";
static NSString *const PMSpecialClearanceCellID = @"PMSpecialClearanceCell";

/* head */
static NSString *const DCSlideshowHeadViewID = @"DCSlideshowHeadView";
static NSString *const DCCountDownHeadViewID = @"DCCountDownHeadView";
static NSString *const DCYouLikeHeadViewID = @"DCYouLikeHeadView";
/* foot */
static NSString *const DCTopLineFootViewID = @"DCTopLineFootView";
static NSString *const DCOverFootViewID = @"DCOverFootView";
static NSString *const DCScrollAdFootViewID = @"DCScrollAdFootView";
@interface PMHomeViewController ()
@property(nonatomic, strong) STHomeVCTopView *topView;

@end

@implementation PMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fecthNavTopView];
    self.statusBarView.backgroundColor = [UIColor whiteColor];
    self.navgationBar.navigationBarBg.backgroundColor = [UIColor whiteColor];
    
    PMHomeListViewController *vc0 = [[PMHomeListViewController alloc] init];
    vc0.title = @"首页";

    PMHomeListViewController *vc1 = [[PMHomeListViewController alloc] init];
    vc1.title = @"狗粮";
    
    PMHomeListViewController *vc2 = [[PMHomeListViewController alloc] init];
    vc2.title = @"零食";
    
    PMHomeListViewController *vc3 = [[PMHomeListViewController alloc] init];
    vc3.title = @"玩具";
    PMHomeListViewController *vc4 = [[PMHomeListViewController alloc] init];
    vc4.title = @"出行";
    PMHomeListViewController *vc5 = [[PMHomeListViewController alloc] init];
    vc5.title = @"医疗";
    self.viewControllers = @[vc0,
                             vc1,
                             vc2,
                             vc3,
                             vc4,
                             vc5
                             ];
    
}

#pragma mark - 导航栏处理
- (void)fecthNavTopView{
   self.topView = [[STHomeVCTopView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, 44)];
    @weakify(self)
    self.topView.searchClick = ^{
        @strongify(self)
        PMSearchViewController * vc = [[PMSearchViewController alloc ] init];
        [self presentViewController:vc animated:YES completion:^{
            
        }];
    };
    [self.navgationBar addSubview:_topView];

}



@end

@interface PMHomeListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) NSMutableArray *bannersArray;

@property(nonatomic, strong) NSMutableArray *recommendArray;


@property(nonatomic, strong) NSMutableArray *goodsArray;

/* 10个属性 */
@property (strong , nonatomic)NSMutableArray<DCGridItem *> *gridItem;

/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray *youLikeItem;

@property(nonatomic, strong) UIView *youhuiView;
@property(nonatomic, strong) UIView *coverBtn;
@end

@implementation PMHomeListViewController
- (NSMutableArray *)recommendArray{
    if (_recommendArray == nil) {
        _recommendArray =  @[@"http://gfs8.gomein.net.cn/T1LnWvBsAg1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CLLvBQbv1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1CCx_B5CT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T17QxvB7b_1RCvBVdK.jpg",@"http://gfs8.gomein.net.cn/T17CWsBmKT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1nabsBCxT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T199_gBCDT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1H.VsBKZT1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1JRW_BmLT1RCvBVdK.jpg"];
        
    }
    return _recommendArray;
}
- (NSMutableArray *)bannersArray{
    if (_bannersArray == nil) {
        _bannersArray =  @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"];

    }
    return _bannersArray;
}
- (NSMutableArray *)goodsArray{
    if (_goodsArray == nil) {
        _goodsArray = @[@"http://gfs5.gomein.net.cn/T1blDgB5CT1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1loYvBCZj1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs1.gomein.net.cn/T1w5bvB7K_1RCvBVdK.jpg",@"http://gfs6.gomein.net.cn/T1L.VvBCxv1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1joLvBKhT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1AoVvB7_v1RCvBVdK.jpg"];
    }
    return _goodsArray;
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    [self setUpBase];
    [self setUpGoodsData];
    [self setUpGIFRrfresh];
    
}
#pragma mark - 设置头部header
- (void)setUpGIFRrfresh
{
    [self.collectionView reloadData];
//    self.collectionView.mj_header = [DCHomeRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(setUpRecData)];
}

#pragma mark - 刷新
- (void)setUpRecData
{
//    WEAKSELF
//    [DCSpeedy dc_callFeedback]; //触动
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ //手动延迟
//        [weakSelf.collectionView.mj_header endRefreshing];
//    });
}

- (void)setUpGoodsData
{
    _gridItem = [DCGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
}

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, kMainBoundsWidth, kMainBoundsHeight - 64 -44-44);
        _collectionView.showsVerticalScrollIndicator = NO;        //注册
        [_collectionView registerClass:[DCGoodsCountDownCell class] forCellWithReuseIdentifier:DCGoodsCountDownCellID];
        [_collectionView registerClass:[DCGoodsHandheldCell class] forCellWithReuseIdentifier:DCGoodsHandheldCellID];
        [_collectionView registerClass:[DCGoodsYouLikeCell class] forCellWithReuseIdentifier:DCGoodsYouLikeCellID];
        [_collectionView registerClass:[DCGoodsGridCell class] forCellWithReuseIdentifier:DCGoodsGridCellID];
        [_collectionView registerClass:[DCExceedApplianceCell class] forCellWithReuseIdentifier:DCExceedApplianceCellID];
        [_collectionView registerClass:[DCNewWelfareCell class] forCellWithReuseIdentifier:DCNewWelfareCellID];
        [_collectionView registerClass:[PMSpecialClearanceCell class] forCellWithReuseIdentifier:PMSpecialClearanceCellID];
        
        
        [_collectionView registerClass:[DCTopLineFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID];
        [_collectionView registerClass:[DCOverFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID];
        [_collectionView registerClass:[DCScrollAdFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCScrollAdFootViewID];
        
        [_collectionView registerClass:[DCYouLikeHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID];
        [_collectionView registerClass:[DCSlideshowHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID];
        [_collectionView registerClass:[DCCountDownHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID];
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) { //10属性
        return _gridItem.count;
    }else if (section == 1 || section == 2 ) { //广告福利  倒计时  掌上专享
        return 1;
    }else if (3 == section){
        return self.youLikeItem.count;
    }else if (section == 4) { //推荐
        return 1;
    }

    return 0;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.section == 0) {//10
        DCGoodsGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsGridCellID forIndexPath:indexPath];
        cell.gridItem = _gridItem[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
        
    }else if (indexPath.section == 1) {//倒计时
        DCGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsCountDownCellID forIndexPath:indexPath];
        gridcell = cell;
        
    }
    else if (indexPath.section == 2) {//广告福利
        DCNewWelfareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCNewWelfareCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else if (indexPath.section == 3) {//团购活动
        DCGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsYouLikeCellID forIndexPath:indexPath];
        cell.lookSameBlock = ^{
            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
        };
        cell.youLikeItem = _youLikeItem[indexPath.row];
        gridcell = cell;
        
    }
    else if (indexPath.section == 4) {//特价清仓
        PMSpecialClearanceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PMSpecialClearanceCellID forIndexPath:indexPath];
        gridcell = cell;
    }
    else {//猜你喜欢
        DCGoodsYouLikeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsYouLikeCellID forIndexPath:indexPath];
        cell.lookSameBlock = ^{
            NSLog(@"点击了第%zd商品的找相似",indexPath.row);
        };
        cell.youLikeItem = _youLikeItem[indexPath.row];
        gridcell = cell;
    }
    return gridcell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == 0) {
            DCSlideshowHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCSlideshowHeadViewID forIndexPath:indexPath];
            headerView.imageGroupArray = self.bannersArray;
            reusableview = headerView;
        }else if (indexPath.section == 1){
            DCCountDownHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCCountDownHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }else if (indexPath.section == 2){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.titleLabel.text = @"潮品预售";
            reusableview = headerView;
        }else if (indexPath.section == 3){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.titleLabel.text = @"团购活动";
            reusableview = headerView;
        }else if (indexPath.section == 4){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            headerView.titleLabel.text = @"特价清仓";
            reusableview = headerView;
        }else if (indexPath.section == 5){
            DCYouLikeHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCYouLikeHeadViewID forIndexPath:indexPath];
            reusableview = headerView;
        }
        
    }
    if (kind == UICollectionElementKindSectionFooter) {
        if (indexPath.section == 0) {
            DCTopLineFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCTopLineFootViewID forIndexPath:indexPath];
            footview.DCTopLineFootViewCallBack = ^{
                [self showYouHui];
            };
            reusableview = footview;
        }
//        else if (indexPath.section == 5) {
//            DCOverFootView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:DCOverFootViewID forIndexPath:indexPath];
//            reusableview = footview;
//        }
    }
    
    return reusableview;
}

//这里我为了直观的看出每组的CGSize设置用if 后续我会用简洁的三元表示
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {//9宫格组
        return CGSizeMake(kMainBoundsWidth/5, kMainBoundsWidth/5 + 10);
    }
    if (indexPath.section == 1) {//计时
        return CGSizeMake(kMainBoundsWidth, 360);
    }
    if (indexPath.section == 2) {//广告
        return CGSizeMake(kMainBoundsWidth, 360);
    }
    if (indexPath.section == 3) {//
            return CGSizeMake(kMainBoundsWidth, 155);
    }
    if (indexPath.section == 4) {//推荐组
        return CGSizeMake(kMainBoundsWidth, 190);
    }
 
    return CGSizeZero;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            layoutAttributes.size = CGSizeMake(kMainBoundsWidth, kMainBoundsWidth * 0.38);
        }else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 4){
            layoutAttributes.size = CGSizeMake(kMainBoundsWidth * 0.5, kMainBoundsWidth * 0.24);
        }else{
            layoutAttributes.size = CGSizeMake(kMainBoundsWidth * 0.25, kMainBoundsWidth * 0.35);
        }
    }
    return layoutAttributes;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return CGSizeMake(kMainBoundsWidth, 149); //图片滚动的宽高
    }else{
        return CGSizeMake(kMainBoundsWidth, 44);  //推荐适合的宽高

    }
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(kMainBoundsWidth, 85);  //Top头条的宽高
    }
    return CGSizeZero;
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
 
    if (indexPath.section == 0) {//10

        PMTimeLimitViewController * vc = [[PMTimeLimitViewController alloc] init];
        [self pushViewController:vc];
        NSLog(@"点击了10个属性第%zd",indexPath.row);
    }else if (indexPath.section == 5){
        NSLog(@"点击了推荐的第%zd个商品",indexPath.row);
        
        DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
        DCRecommendItem * item = _youLikeItem[indexPath.row];
        vc.goodTitle = item.main_title;
        vc.goodPrice = item.price;
        vc.goodSubtitle = item.goods_title;
        vc.shufflingArray = item.images;
        vc.goodImageView = item.image_url;
        
        [self.navigationController pushViewController:vc  animated:YES];
    }
}



#pragma mark - collectionView滚回顶部
- (void)ScrollToTop
{
    [self.collectionView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}
- (UIView *)youhuiView{
    if (_youhuiView == nil) {
        _youhuiView = [[UIView alloc] init];

        UIImageView * imageView = [UIImageView new];
        imageView.image = IMAGE(@"home_youhui");
        [_youhuiView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_youhuiView);
        }];
        
        UIButton * cancelBtn = [UIButton new];
        [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [cancelBtn setImage:IMAGE(@"home_youhui_closed") forState:UIControlStateNormal];
        [_youhuiView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_offset(0);
            make.bottom.mas_equalTo(imageView.mas_top).mas_offset(0);
        }];
        
        UIButton * linquBtn = [UIButton new];
        [linquBtn setTitle:@"点击领取" forState:UIControlStateNormal];
        [linquBtn setTitleColor:[UIColor colorWithHexStr:@"#D54931"] forState:UIControlStateNormal];
        linquBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [linquBtn addTarget:self action:@selector(linquBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_youhuiView addSubview:linquBtn];
        [linquBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(imageView).mas_offset(-5);
            make.centerX.mas_equalTo(imageView);
        }];
        
        UILabel * label = [UILabel new];
        label.text = @"满299元使用";
        label.textColor = [UIColor colorWithHexString:@"#D54931"];
        label.font = [UIFont systemFontOfSize:16];
        [imageView addSubview:label];
        UILabel * label1 = [UILabel new];
        label1.text = @"100";
        label1.textColor = [UIColor colorWithHexString:@"#D54931"];
        label1.font = [UIFont boldSystemFontOfSize:50];
        [imageView addSubview:label1];
        
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(linquBtn.mas_top).mas_equalTo(-20);
            make.centerX.mas_equalTo(imageView);
        }];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(label1.mas_top).mas_equalTo(-5);
            make.centerX.mas_equalTo(imageView);
        }];

    }
    return _youhuiView;
}

- (void)showYouHui{
    self.coverBtn = [[STCoverView alloc] initWithSuperView:kWindow complete:^(UIView *cover) {
        [cover removeFromSuperview];
        [self.youhuiView removeFromSuperview];
    }];
    
    [self.coverBtn addSubview:self.youhuiView];
    [self.youhuiView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.coverBtn);
    }];
    @weakify(self)
//    self.youhuiView.cancel = ^{
//        @strongify(self)
//        [self.coverBtn removeFromSuperview];
//        [self.youhuiView removeFromSuperview];
////        self.shareView.transform = CGAffineTransformMakeTranslation(0, 0);
//    };
    
}
- (void)linquBtnClick{
    
}

- (void)cancelBtnClick{
    [self.coverBtn removeFromSuperview];
    [self.youhuiView removeFromSuperview];
}
@end
