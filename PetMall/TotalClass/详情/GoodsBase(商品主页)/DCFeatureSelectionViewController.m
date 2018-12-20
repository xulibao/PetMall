//
//  DCFeatureSelectionViewController.m
//  CDDStoreDemo
//
//  Created by apple on 2017/7/12.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCFeatureSelectionViewController.h"

// Controllers
#import "DCFillinOrderViewController.h"
// Models
//#import "DCFeatureItem.h"
#import "DCFeatureTitleItem.h"
#import "DCFeatureList.h"
// Views
#import "PPNumberButton.h"
#import "DCFeatureItemCell.h"
#import "DCFeatureHeaderView.h"
#import "DCCollectionHeaderLayout.h"
#import "DCFeatureChoseTopCell.h"
// Vendors
#import <MJExtension.h>
//#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "UIViewController+XWTransition.h"
// Categories

// Others

#define NowScreenH ScreenH * 0.66

@interface DCFeatureSelectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HorizontalCollectionLayoutDelegate,PPNumberButtonDelegate,UITableViewDelegate,UITableViewDataSource>

/* contionView */
@property (strong , nonatomic)UICollectionView *collectionView;
/* tableView */
@property (strong , nonatomic)UITableView *tableView;
/* 数据 */
@property (strong , nonatomic)NSArray <PMGoodDetailChoiceModel *> *featureAttr;
/* 商品选择结果Cell */
@property (weak , nonatomic)DCFeatureChoseTopCell *cell;
@property(nonatomic, strong) PMGoodDetailPriceModel *selectPriceModel;

@end

static NSInteger num_;

static NSString *const DCFeatureHeaderViewID = @"DCFeatureHeaderView";
static NSString *const DCFeatureItemCellID = @"DCFeatureItemCell";
static NSString *const DCFeatureChoseTopCellID = @"DCFeatureChoseTopCell";
@implementation DCFeatureSelectionViewController

#pragma mark - LazyLoad
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        DCCollectionHeaderLayout *layout = [DCCollectionHeaderLayout new];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        //自定义layout初始化
        layout.delegate = self;
        layout.lineSpacing = 8.0;
        layout.interitemSpacing = DCMargin;
        layout.headerViewHeight = 35;
        layout.footerViewHeight = 5;
        layout.itemInset = UIEdgeInsetsMake(0, DCMargin, 0, DCMargin);
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[DCFeatureItemCell class] forCellWithReuseIdentifier:DCFeatureItemCellID];//cell
        [_collectionView registerClass:[DCFeatureHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID]; //头部
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter"]; //尾部
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[DCFeatureChoseTopCell class] forCellReuseIdentifier:DCFeatureChoseTopCellID];
    }
    return _tableView;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpFeatureAlterView];
    
    [self setUpBase];
    
    [self setUpBottonView];
}

#pragma mark - initialize
- (void)setUpBase{
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    _featureAttr = self.choice;
    self.tableView.frame = CGRectMake(0, 0, ScreenW, 100);
    self.tableView.rowHeight = 100;
    self.collectionView.frame = CGRectMake(0, self.tableView.dc_bottom ,ScreenW , NowScreenH - 200);

    //默认选择第一个属性
//    for (PMGoodDetailChoiceModel * choiceModel in self.featureAttr) {
//        for (int i = 0; i < choiceModel.specifications.count; i++) {
//            PMGoodDetailSpecificationModel * model = choiceModel.specifications[i];
//            if (0 == i) {
//                model.isSelect = YES;
//            }
//        }
//    }
    [self configSelectPrice];
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)configSelectPrice{
    NSMutableString * signStr = [NSMutableString new];
    for (PMGoodDetailChoiceModel * choiceModel in self.featureAttr) {
        for (int i = 0; i < choiceModel.specifications.count; i++) {
            PMGoodDetailSpecificationModel * model = choiceModel.specifications[i];
            if (model.isSelect) {
                [signStr appendString:model.sign];
            }
        }
    }
    self.selectPriceModel = nil;
    for (PMGoodDetailPriceModel*priceModel in self.price) {
        if ([priceModel.list_fen isEqualToString:signStr]) {
            self.selectPriceModel = priceModel;
            return;
        }
    }

}
#pragma mark - 底部按钮
- (void)setUpBottonView
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonH = 50;
    CGFloat buttonW = ScreenW / titles.count;
    CGFloat buttonY = NowScreenH - buttonH;
    UIButton *buttton1;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *buttton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttton1 = buttton;
        [buttton setTitle:titles[i] forState:0];
        buttton.backgroundColor = ([SAApplication userID]) ? kColorFF3945 : [UIColor colorWithHexStr:@"#FFC3C7"];
        CGFloat buttonX = buttonW * i;
        buttton.tag = i;
        buttton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:buttton];
        [buttton addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UILabel *numLabel = [UILabel new];
    numLabel.text = @"数量";
    numLabel.font = PFR14Font;
    [self.view addSubview:numLabel];
    numLabel.frame = CGRectMake(DCMargin, NowScreenH - 190, 50, 22);
    
    [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(DCMargin);
        make.bottom.mas_equalTo(buttton1.mas_top).mas_offset(-50);
        make.height.mas_equalTo(22);
    }];
    
    PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake((kMainBoundsWidth - 75 -15), NowScreenH - 100 -22, 75, 22)];
    numberButton.shakeAnimation = YES;
    numberButton.minValue = 1;
    numberButton.inputFieldFont = 14;
    numberButton.increaseTitle = @"＋";
    numberButton.decreaseTitle = @"－";
    num_ = (_lastNum == 0) ?  1 : [_lastNum integerValue];
    numberButton.currentNumber = num_;
    numberButton.delegate = self;
    
    numberButton.resultBlock = ^(NSInteger num ,BOOL increaseStatus){
        num_ = num;
        if (self.selectPriceModel) {
            self.selectPriceModel.shul = [@(num_) stringValue];
        }
    };
    [self.view addSubview:numberButton];

}

#pragma mark - 底部按钮点击
- (void)buttomButtonClick:(UIButton *)button{
    if (!self.selectPriceModel) {//未选择全属性警告
        [self showWaring:@"请选择全属性"];
        return;
    }
    
    [self dismissFeatureViewControllerWithTag:button.tag];
    
}

#pragma mark - 弹出弹框
- (void)setUpFeatureAlterView
{
    XWInteractiveTransitionGestureDirection direction = XWInteractiveTransitionGestureDirectionDown;
    WEAKSELF
    [self xw_registerBackInteractiveTransitionWithDirection:direction transitonBlock:^(CGPoint startPoint){
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismissFeatureViewControllerWithTag:100];
        }];
    } edgeSpacing:0];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DCFeatureChoseTopCell *cell = [tableView dequeueReusableCellWithIdentifier:DCFeatureChoseTopCellID forIndexPath:indexPath];
    _cell = cell;
    cell.priceModel = self.selectPriceModel;
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:_goodImageView]];
    WEAKSELF
    cell.crossButtonClickBlock = ^{
        [weakSelf dismissFeatureViewControllerWithTag:100];
    };
    return cell;
}

#pragma mark - 退出当前界面
- (void)dismissFeatureViewControllerWithTag:(NSInteger)tag{
        if (self.selectPriceModel) {//当选择全属性才传递出去
            self.selectPriceModel.shul = @"1";
            self.selectPriceModel.Tag = [@(tag) stringValue];
            dispatch_sync(dispatch_get_global_queue(0, 0), ^{
                  [[NSNotificationCenter defaultCenter] postNotificationName:SHOPITEMSELECTBACK object:nil userInfo:@{@"price":self.selectPriceModel}];
            });
    }
    if (self.userChooseBlock) {
        self.userChooseBlock(tag);
    }
}



#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _featureAttr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _featureAttr[section].specifications.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DCFeatureItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DCFeatureItemCellID forIndexPath:indexPath];
    cell.content = _featureAttr[indexPath.section].specifications[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind  isEqualToString:UICollectionElementKindSectionHeader]) {
        DCFeatureHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:DCFeatureHeaderViewID forIndexPath:indexPath];
        headerView.choiceModel = _featureAttr[indexPath.section];
        return headerView;
    }else {

        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"UICollectionElementKindSectionFooter" forIndexPath:indexPath];
        return footerView;
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    PMGoodDetailChoiceModel * choiceModel = self.featureAttr[indexPath.section];
    PMGoodDetailSpecificationModel * model = choiceModel.specifications[indexPath.row];
    model.isSelect = !model.isSelect;
    [self configSelectPrice];
    //刷新tableView和collectionView
    [self.collectionView reloadData];
    [self.tableView reloadData];
}


#pragma mark - <HorizontalCollectionLayoutDelegate>
#pragma mark - 自定义layout必须实现的方法
- (NSString *)collectionViewItemSizeWithIndexPath:(NSIndexPath *)indexPath {
    PMGoodDetailChoiceModel * choiceModel = self.featureAttr[indexPath.section];
    PMGoodDetailSpecificationModel * model = choiceModel.specifications[indexPath.row];
    return model.last;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
