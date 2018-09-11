//
//  DCGoodBaseViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodBaseViewController.h"

// Controllers
#import "DCShareToViewController.h"
#import "DCToolsViewController.h"
#import "DCFeatureSelectionViewController.h"
#import "DCFillinOrderViewController.h"
//#import "DCLoginViewController.h"
// Models
#import "DCGoodCommentViewController.h"
// Views
#import "DCLIRLButton.h"
#import "DCCommentsItem.h"
#import "DCDetailShufflingHeadView.h" //头部轮播
#import "DCDetailGoodReferralCell.h"  //商品标题价格介绍
#import "DCDetailShowTypeCell.h"      //种类
#import "DCShowTypeOneCell.h"
#import "DCShowTypeTwoCell.h"
#import "DCShowTypeThreeCell.h"
#import "DCShowTypeFourCell.h"
#import "DCDetailServicetCell.h"      //服务
#import "DCDetailLikeCell.h"          //猜你喜欢
#import "DCDetailOverFooterView.h"    //尾部结束
#import "DCDeatilCustomHeadView.h"    //自定义头部
#import "DCCommentsCntCell.h"
#import "DCCommentHeaderView.h"
// Vendors
#import "AddressPickerView.h"
#import <WebKit/WebKit.h>
#import <MJRefresh.h>
#import <MJExtension.h>

// Categories
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"
// Others

@interface DCGoodBaseViewController ()<UITableViewDataSource,UITableViewDelegate,WKNavigationDelegate>

@property (strong, nonatomic) UIScrollView *scrollerView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) WKWebView *webView;
/* 选择地址弹框 */
@property (strong , nonatomic)AddressPickerView *adPickerView;
/* 滚回顶部按钮 */
@property (strong , nonatomic)UIButton *backTopButton;
/* 通知 */
@property (weak ,nonatomic) id dcObj;

@property(nonatomic, strong) NSArray *commentsItem;

@end

//header
static NSString *DCDetailShufflingHeadViewID = @"DCDetailShufflingHeadView";
static NSString *DCDeatilCustomHeadViewID = @"DCDeatilCustomHeadView";
//cell
static NSString *DCDetailGoodReferralCellID = @"DCDetailGoodReferralCell";

static NSString *DCShowTypeOneCellID = @"DCShowTypeOneCell";
static NSString *DCShowTypeTwoCellID = @"DCShowTypeTwoCell";
static NSString *DCShowTypeThreeCellID = @"DCShowTypeThreeCell";
static NSString *DCShowTypeFourCellID = @"DCShowTypeFourCell";

static NSString *DCDetailServicetCellID = @"DCDetailServicetCell";
static NSString *DCDetailLikeCellID = @"DCDetailLikeCell";
static NSString *DCCommentsCntCellID = @"DCCommentsCntCell";
//footer
static NSString *DCDetailOverFooterViewID = @"DCDetailOverFooterView";


static NSString *lastNum_;
static NSArray *lastSeleArray_;

@implementation DCGoodBaseViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.contentSize = CGSizeMake(ScreenW, (ScreenH) * 2);
        _scrollerView.pagingEnabled = YES;
        _scrollerView.scrollEnabled = NO;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH );
        _tableView.showsVerticalScrollIndicator = NO;
        [self.scrollerView addSubview:_tableView];
        
        //注册header
        //注册Cell
        [_tableView registerClass:[DCDetailGoodReferralCell class] forCellReuseIdentifier:DCDetailGoodReferralCellID];
        [_tableView registerClass:[DCShowTypeOneCell class] forCellReuseIdentifier:DCShowTypeOneCellID];
        [_tableView registerClass:[DCShowTypeTwoCell class] forCellReuseIdentifier:DCShowTypeTwoCellID];
        [_tableView registerClass:[DCShowTypeThreeCell class] forCellReuseIdentifier:DCShowTypeThreeCellID];
        [_tableView registerClass:[DCShowTypeFourCell class] forCellReuseIdentifier:DCShowTypeFourCellID];
//        [_tableView registerClass:[DCDetailLikeCell class] forCellReuseIdentifier:DCDetailLikeCellID];
//        [_tableView registerClass:[DCDetailPartCommentCell class] forCellWithReuseIdentifier:DCDetailPartCommentCellID];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCommentsCntCell class]) bundle:nil] forCellReuseIdentifier:DCCommentsCntCellID];

//        [_tableView registerClass:[DCDetailServicetCell class] forCellReuseIdentifier:DCDetailServicetCellID];

        
    }
    return _tableView;
}

- (WKWebView *)webView
{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        _webView.frame = CGRectMake(0,ScreenH , ScreenW, ScreenH);
        _webView.scrollView.contentInset = UIEdgeInsetsMake(DCTopNavH, 0, 0, 0);
        _webView.scrollView.scrollIndicatorInsets = _webView.scrollView.contentInset;
        [self.scrollerView addSubview:_webView];
    }
    return _webView;
}


#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpInit];
    
    [self setUpViewScroller];
    
    [self setUpGoodsWKWebView];
    
    [self setUpSuspendView];

    
    [self acceptanceNote];
    
    _commentsItem = [DCCommentsItem mj_objectArrayWithFilename:@"CommentData.plist"];

    [self setUpBottomButton];


}



- (void)setupNavgationBar {
    [super setupNavgationBar];
    
    UIColor *tintColor = [UIColor whiteColor];
    [self.navgationBar.leftBarButton setTintColor:tintColor];
    self.navgationBar.navigationBarBg.alpha = 0;
    self.navgationBar.titleLabel.alpha = 0;
    self.statusBarView.alpha = 0;
}

- (void)initSubviews {
    [super initSubviews];
}
- (BOOL)shouldInitSTNavgationBar {
    return YES;
}

#pragma mark - initialize
- (void)setUpInit
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = DCBGColor;
    self.tableView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;

    //初始化
    lastSeleArray_ = [NSArray array];
    lastNum_ = 0;
    
}

#pragma mark - 接受通知
- (void)acceptanceNote
{
    //分享通知
    WEAKSELF
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:SHAREALTERVIEW object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSelf selfAlterViewback];
        [weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
    }];
    

    //父类加入购物车，立即购买通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:SELECTCARTORBUY object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        if (lastSeleArray_.count != 0) {
            if ([note.userInfo[@"buttonTag"] isEqualToString:@"2"]) { //加入购物车（父类）
                
                [weakSelf setUpWithAddSuccess];
                
            }else if ([note.userInfo[@"buttonTag"] isEqualToString:@"3"]){//立即购买（父类）
                
                DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
                [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
            }
            
        }else {
            
            DCFeatureSelectionViewController *dcNewFeaVc = [DCFeatureSelectionViewController new];
            dcNewFeaVc.goodImageView = weakSelf.goodImageView;
            [weakSelf setUpAlterViewControllerWith:dcNewFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
        }
    }];

    //选择Item通知
    _dcObj = [[NSNotificationCenter defaultCenter]addObserverForName:SHOPITEMSELECTBACK object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        
        NSArray *selectArray = note.userInfo[@"Array"];
        NSString *num = note.userInfo[@"Num"];
        NSString *buttonTag = note.userInfo[@"Tag"];

        lastNum_ = num;
        lastSeleArray_ = selectArray;
        
        [weakSelf.tableView reloadData];
        
        if ([buttonTag isEqualToString:@"0"]) { //加入购物车
            
            [weakSelf setUpWithAddSuccess];
            
        }else if ([buttonTag isEqualToString:@"1"]) { //立即购买
            
            DCFillinOrderViewController *dcFillVc = [DCFillinOrderViewController new];
            [weakSelf.navigationController pushViewController:dcFillVc animated:YES];
        }
        
    }];
}

#pragma mark - 悬浮按钮
- (void)setUpSuspendView
{
    _backTopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_backTopButton];
    [_backTopButton addTarget:self action:@selector(ScrollToTop) forControlEvents:UIControlEventTouchUpInside];
    [_backTopButton setImage:[UIImage imageNamed:@"btn_UpToTop"] forState:UIControlStateNormal];
    _backTopButton.hidden = YES;
    _backTopButton.frame = CGRectMake(ScreenW - 50, ScreenH - 100, 40, 40);
}

#pragma mark - 记载图文详情
- (void)setUpGoodsWKWebView
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://royalcanin.tmall.com/?spm=a220o.1000855.w5003-17355747065.1.5257703eeUhds1&scene=taobao_shop"]];
    [self.webView loadRequest:request];
    
    //下拉返回商品详情View
    UIView *topHitView = [[UIView alloc] init];
    topHitView.frame = CGRectMake(0, -35, ScreenW, 35);
    DCLIRLButton *topHitButton = [DCLIRLButton buttonWithType:UIButtonTypeCustom];
    topHitButton.imageView.transform = CGAffineTransformRotate(topHitButton.imageView.transform, M_PI); //旋转
    [topHitButton setImage:[UIImage imageNamed:@"Details_Btn_Up"] forState:UIControlStateNormal];
    [topHitButton setTitle:@"下拉返回商品详情" forState:UIControlStateNormal];
    topHitButton.titleLabel.font = PFR12Font;
    [topHitButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [topHitView addSubview:topHitButton];
    topHitButton.frame = topHitView.bounds;
    
    [self.webView.scrollView addSubview:topHitView];
}

#pragma mark - <UItableViewDataSource>
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (2 == section) {
        return _commentsItem.count;
    }
    return  1;
}


#pragma mark - <UItableViewDelegate>
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *gridcell = nil;
//    DCUserInfo *userInfo = UserInfoData;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            DCDetailGoodReferralCell *cell = [tableView dequeueReusableCellWithIdentifier:DCDetailGoodReferralCellID forIndexPath:indexPath];
            cell.goodTitleLabel.text = _goodTitle;
            cell.goodPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_goodPrice];
//            cell.goodSubtitleLabel.text = _goodSubtitle;
         
            WEAKSELF
            cell.shareButtonClickBlock = ^{
//                [weakSelf setUpAlterViewControllerWith:[DCShareToViewController new] WithDistance:300 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:NO WithFlipEnable:NO];
            };
            gridcell = cell;
        }
    }else if (indexPath.section == 1){
            DCShowTypeOneCell *cell = [tableView dequeueReusableCellWithIdentifier:DCShowTypeOneCellID forIndexPath:indexPath];

            NSString *result = [NSString stringWithFormat:@"%@ %@件",[lastSeleArray_ componentsJoinedByString:@"，"],lastNum_];
            
            cell.leftTitleLable.text = (lastSeleArray_.count == 0) ? @"规格" : @"已选";
            cell.contentLabel.text = (lastSeleArray_.count == 0) ? @"请选择该商品属性" : result;
            gridcell = cell;
    }else if (indexPath.section == 2){
        DCCommentsCntCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCommentsCntCellID forIndexPath:indexPath];
        cell.commentsItem = _commentsItem[indexPath.row];
        gridcell = cell;
    }
    
    return gridcell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        DCDetailShufflingHeadView *headerView = [[DCDetailShufflingHeadView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, ScreenH * 0.55)];
        headerView.shufflingArray = _shufflingArray;
        return headerView;

    }else if (2 == section){
        DCCommentHeaderView *headerView = [[DCCommentHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 50)];
        headerView.callBack = ^{
            DCGoodCommentViewController * vc = [[DCGoodCommentViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        };
        headerView.comNum = @"1130";
        headerView.wellPer = @"98.5";
        return headerView;

    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view= [[UIView alloc] init];
    return view;
}
#pragma mark - item宽高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { //商品详情
        return   100;
    }else if (indexPath.section == 1){//商品属性选择
        return  44;
    }else if (indexPath.section == 2){//商品评价部分展示
        DCCommentsItem * item = _commentsItem[indexPath.row];
        return  item.cellHeight;
    }
    return 0;

}

#pragma mark - head宽高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        if (0 == section) {
            return ScreenH * 0.55;
        }else if (2 == section){
            return 50;
        }
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self scrollToDetailsPage]; //滚动到详情页面
    }else if (indexPath.section == 2 && indexPath.row == 0) {
        [self chageUserAdress]; //跟换地址
    }else if (indexPath.section == 1){ //属性选择
        DCFeatureSelectionViewController *dcFeaVc = [DCFeatureSelectionViewController new];
        dcFeaVc.lastNum = lastNum_;
        dcFeaVc.lastSeleArray = [NSMutableArray arrayWithArray:lastSeleArray_];
        dcFeaVc.goodImageView = _goodImageView;
        [self setUpAlterViewControllerWith:dcFeaVc WithDistance:ScreenH * 0.8 WithDirection:XWDrawerAnimatorDirectionBottom WithParallaxEnable:YES WithFlipEnable:YES];
    }
}


#pragma mark - 视图滚动
- (void)setUpViewScroller{
    WEAKSELF
    self.tableView.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(YES);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, ScreenH);
        } completion:^(BOOL finished) {
            [weakSelf.tableView.mj_footer endRefreshing];
        }];
    }];
    
    self.webView.scrollView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [UIView animateWithDuration:0.8 animations:^{
            !weakSelf.changeTitleBlock ? : weakSelf.changeTitleBlock(NO);
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.webView.scrollView.mj_header endRefreshing];
        }];
        
    }];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断回到顶部按钮是否隐藏
    _backTopButton.hidden = (scrollView.contentOffset.y > ScreenH) ? NO : YES;
}

#pragma mark - 点击事件
#pragma mark - 更换地址
- (void)chageUserAdress{
//    if (![[DCObjManager dc_readUserDataForKey:@"isLogin"] isEqualToString:@"1"]) {
//        DCLoginViewController *dcLoginVc = [DCLoginViewController new];
//        [self presentViewController:dcLoginVc animated:YES completion:nil];
//        return;
//    }
    _adPickerView = [AddressPickerView shareInstance];
    [_adPickerView showAddressPickView];
    [self.view addSubview:_adPickerView];
    
    WEAKSELF
    _adPickerView.block = ^(NSString *province,NSString *city,NSString *district) {
//        DCUserInfo *userInfo = UserInfoData;
//        NSString *newAdress = [NSString stringWithFormat:@"%@ %@ %@",province,city,district];
//        if ([userInfo.defaultAddress isEqualToString:newAdress]) {
//            return;
//        }
//        userInfo.defaultAddress = newAdress;
//        [userInfo save];
        [weakSelf.tableView reloadData];
    };
}

#pragma mark - 滚动到详情页面
- (void)scrollToDetailsPage
{
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        [[NSNotificationCenter defaultCenter]postNotificationName:SCROLLTODETAILSPAGE object:nil];
    });
}

#pragma mark - tableView滚回顶部
- (void)ScrollToTop
{
    if (self.scrollerView.contentOffset.y > ScreenH) {
        [self.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    }else{
        WEAKSELF
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.scrollerView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            [weakSelf.tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        }];
    }
    !_changeTitleBlock ? : _changeTitleBlock(NO);
}
#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton
{
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"detail_shoucang"];
    NSArray *imagesSel = @[@"detail_shoucang_selected"];
    CGFloat buttonW = ScreenW * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = ScreenW * 0.8 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR16Font;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}


#pragma mark - 点击工具条
- (void)toolItemClick
{
    [self setUpAlterViewControllerWith:[DCToolsViewController new] WithDistance:150 WithDirection:XWDrawerAnimatorDirectionTop WithParallaxEnable:NO WithFlipEnable:NO];
}

- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 1){
        NSLog(@"购物车");
        //        DCMyTrolleyViewController *shopCarVc = [[DCMyTrolleyViewController alloc] init];
        //        shopCarVc.isTabBar = YES;
        //        shopCarVc.title = @"购物车";
        //        [self.navigationController pushViewController:shopCarVc animated:YES];
    }else  if (button.tag == 2 || button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithFormat:@"%zd",button.tag],@"buttonTag", nil];
            [[NSNotificationCenter defaultCenter]postNotificationName:SELECTCARTORBUY object:nil userInfo:dict];
        });
    }
}

#pragma mark - 转场动画弹出控制器
- (void)setUpAlterViewControllerWith:(UIViewController *)vc WithDistance:(CGFloat)distance WithDirection:(XWDrawerAnimatorDirection)vcDirection WithParallaxEnable:(BOOL)parallaxEnable WithFlipEnable:(BOOL)flipEnable
{
    [self dismissViewControllerAnimated:YES completion:nil]; //以防有控制未退出
    XWDrawerAnimatorDirection direction = vcDirection;
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.parallaxEnable = parallaxEnable;
    animator.flipEnable = flipEnable;
    [self xw_presentViewController:vc withAnimator:animator];
    WEAKSELF
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}

#pragma mark - 加入购物车成功
- (void)setUpWithAddSuccess
{
//    [SVProgressHUD showSuccessWithStatus:@"加入购物车成功~"];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
//    [SVProgressHUD dismissWithDelay:1.0];
}

#pragma 退出界面
- (void)selfAlterViewback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObj];
}

@end
