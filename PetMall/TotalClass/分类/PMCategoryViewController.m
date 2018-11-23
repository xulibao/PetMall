//
//  PMCategoryViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//
#define tableViewH  95

#import "DCRecommendItem.h"
#import "DCGoodBaseViewController.h"

#import "PMCategoryViewController.h"

// Models
#import "DCClassMianItem.h"
#import "DCCalssSubItem.h"
#import "DCClassGoodsItem.h"
// Views
#import "DCClassCategoryCell.h"
#import "DCGoodsSortCell.h"
#import "DCBrandSortCell.h"
#import "DCBrandsSortHeadView.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface PMCategoryViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* collectionViw */
@property (strong , nonatomic)UICollectionView *collectionView;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
/* 语音按钮 */
@property (strong , nonatomic)UIButton *voiceButton;

/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray *youLikeItem;
/* 左边数据 */
@property (strong , nonatomic)NSMutableArray<DCClassMianItem *> *titleItem;
/* 右边数据 */
@property (strong , nonatomic)NSMutableArray<DCCalssSubItem *> *mainItem;

@property(nonatomic, assign) NSInteger tableSelect;

@end

static NSString *const DCClassCategoryCellID = @"DCClassCategoryCell";
static NSString *const DCBrandsSortHeadViewID = @"DCBrandsSortHeadView";
static NSString *const DCGoodsSortCellID = @"DCGoodsSortCell";
static NSString *const DCBrandSortCellID = @"DCBrandSortCell";

@implementation PMCategoryViewController

#pragma mark - LazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 0 , tableViewH, kMainBoundsHeight - 64-44);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DCClassCategoryCell class] forCellReuseIdentifier:DCClassCategoryCellID];
    }
    return _tableView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 6; //X
        layout.minimumLineSpacing = 20;  //Y
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.frame = CGRectMake(95, 0, kMainBoundsWidth - tableViewH, kMainBoundsHeight - 64 -44);
        //注册Cell
        [_collectionView registerClass:[DCGoodsSortCell class] forCellWithReuseIdentifier:DCGoodsSortCellID];
        [_collectionView registerClass:[DCBrandSortCell class] forCellWithReuseIdentifier:DCBrandSortCellID];
        //注册Header
        [_collectionView registerClass:[DCBrandsSortHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     _youLikeItem = [DCRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setUpNav];
    [self setUpTab];
    [self setUpData];
}

#pragma mark - initizlize
- (void)setUpTab{
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.backgroundColor = DCBGColor;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - 加载数据
- (void)setUpData{
    [self requestPOST:API_Classification_fication parameters:@{@"type":[SAApplication sharedApplication].userType} success:^(__kindof SARequest *request, id responseObject) {
        self.titleItem = [DCClassMianItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.tableView reloadData];
        //默认选择第一行（注意一定要在加载完数据之后）
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        self.tableSelect = 1;
        [self fecthItems:[self.titleItem firstObject]];
    } failure:NULL];
}

#pragma mark - 设置导航条
- (void)setUpNav{
    
    _topSearchView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, kMainBoundsWidth-10, 30)];
    _topSearchView.backgroundColor = kColorFAFAFA;
    self.navigationItem.titleView = _topSearchView;
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setTitle:@"搜索关键词" forState:UIControlStateNormal];
    [_searchButton setTitleColor:[UIColor colorWithHexStr:@"#C2C2C2"] forState:UIControlStateNormal];
    _searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [_searchButton adjustsImageWhenHighlighted];
    _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 10, 0, 0);
    _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_topSearchView addSubview:_searchButton];
    
//    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(15);
//        make.height.mas_equalTo(@(32));
//        make.centerY.mas_equalTo(self.navigationItem.titleView);
//        
//    }];
//    
    [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.topSearchView);
        make.height.mas_equalTo(self.topSearchView);
        make.width.mas_equalTo(100);
    }];
}

- (void)fecthItems:(DCClassMianItem *)item{
    [self requestPOST:API_Classification_ficationa parameters:@{@"pid":item.cate_id} success:^(__kindof SARequest *request, id responseObject) {
        self.mainItem = [DCCalssSubItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"]];
        [self.collectionView reloadData];
    } failure:NULL];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCClassCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:DCClassCategoryCellID forIndexPath:indexPath];
    cell.titleItem = _titleItem[indexPath.row];
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DCClassMianItem *item = self.titleItem[indexPath.row];
    self.tableSelect = indexPath.row;
    [self fecthItems:item];
 
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _mainItem.count;
}

#pragma mark - <UICollectionViewDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    DCGoodsSortCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCGoodsSortCellID forIndexPath:indexPath];
    cell.subItem = _mainItem[indexPath.row];
    gridcell = cell;
    return gridcell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        DCBrandsSortHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCBrandsSortHeadViewID forIndexPath:indexPath];
        DCClassMianItem * item = self.titleItem[self.tableSelect];
        headerView.headTitle = item;
        reusableview = headerView;
    }
    return reusableview;
}
#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        return CGSizeMake((kMainBoundsWidth - tableViewH - 6 * 4)/3, (kMainBoundsWidth - tableViewH - 6 * 4)/3 + 20);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kMainBoundsWidth, 50);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DCCalssSubItem * item = _mainItem[indexPath.row];
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = item.cate_id;
//    vc.list_id  = item.list_id;
    [self.navigationController pushViewController:vc  animated:YES];
}


#pragma mark - 搜索点击
- (void)searchButtonClick
{
    
}

#pragma mark - 语音点击
- (void)voiceButtonClick
{
    
}

#pragma mark - 消息点击
- (void)messButtonBarItemClick
{
    
}
@end
