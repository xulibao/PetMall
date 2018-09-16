//
//  PMSearchViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSearchViewController.h"
#import "PMSearchResultViewController.h"
#import <MJRefresh/MJRefresh.h>
#define PYSEARCH_SEARCH_HISTORY_CACHE_PATH [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"MLSearchhistories.plist"] // 搜索历史存储路径
@interface PMSearchViewController ()<UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tagsView;
@property (nonatomic, strong) UIView *headerView;
/** 搜索历史 */
@property (nonatomic, strong) NSMutableArray *searchHistories;
/** 搜索历史缓存保存路径, 默认为PYSEARCH_SEARCH_HISTORY_CACHE_PATH(PYSearchConst.h文件中的宏定义) */
@property (nonatomic, copy) NSString *searchHistoriesCachePath;
/** 搜索历史记录缓存数量，默认为20 */
@property (nonatomic, assign) NSUInteger searchHistoriesCount;
/** 搜索建议（推荐）控制器 */
//@property (nonatomic, weak) MLSearchResultsTableViewController *searchSuggestionVC;


@end

@implementation PMSearchViewController
//
//- (MLSearchResultsTableViewController *)searchSuggestionVC
//{
//    if (!_searchSuggestionVC) {
//        MLSearchResultsTableViewController *searchSuggestionVC = [[MLSearchResultsTableViewController alloc] initWithStyle:UITableViewStylePlain];
//        __weak typeof(self) _weakSelf = self;
//        searchSuggestionVC.didSelectText = ^(NSString *didSelectText) {
//
//            if ([didSelectText isEqualToString:@""]) {
//                [self.searchBar resignFirstResponder];
//            }
//            else
//            {
//                // 设置搜索信息
//                _weakSelf.searchBar.text = didSelectText;
//
//                // 缓存数据并且刷新界面
//                [_weakSelf saveSearchCacheAndRefreshView];
//            }
//
//
//        };
//        searchSuggestionVC.view.frame = CGRectMake(0, 64, self.view.mj_w, self.view.mj_h);
//        searchSuggestionVC.view.backgroundColor = [UIColor whiteColor];
//
//        [self.view addSubview:searchSuggestionVC.view];
//        [self addChildViewController:searchSuggestionVC];
//        _searchSuggestionVC = searchSuggestionVC;
//    }
//    return _searchSuggestionVC;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tagsArray = @[@"全犬通用狗粮", @"金属狗笼子", @"狗狗外出背包", @"狗狗外出背包", @"全自动饮水器", @"玩具飞盘"];
    
    self.searchHistories = [@[@"狗食",
                             @"狗狗洗澡用具",
                             @"小猫食",
                             @"狗窝豪华窝",
                              @"猫狗拉绳",
                              @"猫毛线玩具"
                              ] mutableCopy];
    self.searchHistoriesCount = 20;

    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-64-20, 44)];
    titleView.backgroundColor = kColorFAFAFA;
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"搜索关键词";
    searchBar.delegate = self;
    searchBar.backgroundColor = kColorFAFAFA;
    searchBar.layer.cornerRadius = 12;
    searchBar.layer.masksToBounds = YES;
    [searchBar.layer setBorderWidth:8];
    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
     UIButton * cancelBtn = [[UIButton alloc] init];
    cancelBtn.backgroundColor = kColorFAFAFA;
    [self.view addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn  setTitle:@"取消"  forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.top.mas_equalTo(30);
        make.right.mas_equalTo(cancelBtn.mas_left);
        make.height.mas_equalTo(40);
        
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(30);
    }];

    
    self.headerView = [[UIView alloc] init];
    self.headerView.mj_x = 0;
    self.headerView.mj_y = 0;
    self.headerView.mj_w = kScreenWidth;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, kScreenWidth-20, 30)];
    titleLabel.text = @"最近搜索";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [self.headerView addSubview:titleLabel];
      UIButton * cleaarBtn = [[UIButton alloc] init];
    [cleaarBtn addTarget:self action:@selector(emptySearchHistoryDidClick) forControlEvents:UIControlEventTouchUpInside];
    [cleaarBtn setImage:IMAGE(@"home_delete") forState:UIControlStateNormal];
    [self.headerView addSubview:cleaarBtn];
    [cleaarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-15);
    }];

    self.tagsView = [[UIView alloc] init];
    self.tagsView.mj_x = 10;
    self.tagsView.mj_y = titleLabel.mj_y+30;
    self.tagsView.mj_w = kScreenWidth-20;
    
    [self.headerView addSubview:self.tagsView];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(searchBar.mas_bottom).mas_offset(10);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
//    self.tableView.tableFooterView = footView;
    [self tagsViewWithTag];
    
}

- (void)tagsViewWithTag{
    CGFloat allLabelWidth = 0;
    CGFloat allLabelHeight = 0;
    int rowHeight = 0;
    
    for (int i = 0; i < self.searchHistories.count; i++) {
        
        
        if (i != self.searchHistories.count-1) {
            
            CGFloat width = [self getWidthWithTitle:self.searchHistories[i+1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        else
        {
            
            CGFloat width = [self getWidthWithTitle:self.searchHistories[self.searchHistories.count-1] font:[UIFont systemFontOfSize:14]];
            if (allLabelWidth + width+10 > self.tagsView.frame.size.width) {
                rowHeight++;
                allLabelWidth = 0;
                allLabelHeight = rowHeight*40;
            }
        }
        
        UILabel *rectangleTagLabel = [[UILabel alloc] init];
        // 设置属性
        rectangleTagLabel.userInteractionEnabled = YES;
        rectangleTagLabel.font = [UIFont systemFontOfSize:14];
        rectangleTagLabel.textColor = [UIColor whiteColor];
        rectangleTagLabel.backgroundColor = [UIColor lightGrayColor];
        rectangleTagLabel.text = self.searchHistories[i];
        rectangleTagLabel.textAlignment = NSTextAlignmentCenter;
        [rectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
        
        CGFloat labelWidth = [self getWidthWithTitle:self.searchHistories[i] font:[UIFont systemFontOfSize:14]];
        
        rectangleTagLabel.layer.cornerRadius = 5;
        [rectangleTagLabel.layer setMasksToBounds:YES];
        
        rectangleTagLabel.frame = CGRectMake(allLabelWidth, allLabelHeight, labelWidth, 25);
        [self.tagsView addSubview:rectangleTagLabel];
        
        allLabelWidth = allLabelWidth+10+labelWidth;
    }
    
    self.tagsView.mj_h = rowHeight*40+40;
    self.headerView.mj_h = self.tagsView.mj_y+self.tagsView.mj_h+10;
    self.tableView.tableHeaderView = self.headerView;

}

/** 选中标签 */
- (void)tagDidCLick:(UITapGestureRecognizer *)gr{
    PMSearchResultViewController * vc = [PMSearchResultViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)cancelDidClick
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 视图完全显示 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // 弹出键盘
    [self.searchBar becomeFirstResponder];
}

/** 视图即将消失 */
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 回收键盘
    [self.searchBar resignFirstResponder];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.tableView.tableFooterView.hidden = self.tagsArray.count == 0;
    return self.tagsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    cell.textLabel.textColor = [UIColor grayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSString * titleStr = [NSString stringWithFormat:@"%ld  %@",(indexPath.row +1), self.tagsArray[indexPath.row]];
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
    NSRange range = [titleStr rangeOfString:[@(indexPath.row +1) stringValue]];
    UIColor * strColor;
    if (indexPath.row == 0) {
        strColor = kColorFF5554;
    }else if (indexPath.row == 1) {
        strColor = [UIColor colorWithHexStr:@"#FF9639"];
    }else if (indexPath.row == 2) {
        strColor = [UIColor colorWithHexStr:@"#E9C000"];
    }else{
        strColor = [UIColor colorWithHexStr:@"#999999"];
    }
    [attrStr addAttributes:@{NSForegroundColorAttributeName:strColor} range:range];
    cell.textLabel.attributedText = attrStr;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.tagsArray.count != 0) {
        
        return @"热门搜索";
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth-10, 60)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:view.frame];
    titleLabel.text = @"热门搜索";
    titleLabel.font = [UIFont systemFontOfSize:14];
    [titleLabel sizeToFit];
    [view addSubview:titleLabel];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PMSearchResultViewController * vc = [PMSearchResultViewController new];
    [self presentViewController:vc animated:YES completion:nil];
 
}

- (CGFloat)getWidthWithTitle:(NSString *)title font:(UIFont *)font {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1000, 0)];
    label.text = title;
    label.font = font;
    [label sizeToFit];
    return label.frame.size.width+10;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 滚动时，回收键盘
    [self.searchBar resignFirstResponder];
}

- (NSMutableArray *)searchHistories
{
    
    if (!_searchHistories) {
        self.searchHistoriesCachePath = PYSEARCH_SEARCH_HISTORY_CACHE_PATH;
        _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
        
    }
    return _searchHistories;
}

- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath
{
    _searchHistoriesCachePath = [searchHistoriesCachePath copy];
    // 刷新
    self.searchHistories = nil;
    
    [self.tableView reloadData];
}

/** 进入搜索状态调用此方法 */
- (void)saveSearchCacheAndRefreshView
{
    UISearchBar *searchBar = self.searchBar;
    // 回收键盘
    [searchBar resignFirstResponder];
    // 先移除再刷新
    [self.searchHistories removeObject:searchBar.text];
    [self.searchHistories insertObject:searchBar.text atIndex:0];
    
    // 移除多余的缓存
    if (self.searchHistories.count > self.searchHistoriesCount) {
        // 移除最后一条缓存
        [self.searchHistories removeLastObject];
    }
    // 保存搜索信息
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    
    [self.tableView reloadData];
}


- (void)cancelBtnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/** 点击清空历史按钮 */
- (void)emptySearchHistoryDidClick{
    // 移除所有历史搜索
    [self.searchHistories removeAllObjects];
    // 移除数据缓存
    [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
    [self tagsViewWithTag];
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    PMSearchResultViewController * vc = [PMSearchResultViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)resultResult{
    
}
@end
