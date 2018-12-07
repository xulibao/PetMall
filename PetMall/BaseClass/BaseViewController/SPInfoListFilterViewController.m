//
//  SPInfoListFilterViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SPInfoListFilterViewController.h"
#import "SAUserInfoEntity.h"
@interface SPInfoListFilterModel()

@end

@implementation SPInfoListFilterModel

@end
@interface SPInfoListFilterViewController ()
@end

@implementation SPInfoListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopView];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutFilterView];
}

- (void)initSubviews {
    [super initSubviews];
    [self initFilterView];
}
- (BOOL)shouldHiddenSystemNavgation {
    return NO;
}
//子类重写
- (void)initTopView{
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-80, 44)];
    self.navigationItem.titleView = titleView;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth-80, 34)];
    searchBar.placeholder = @"搜索关键词";
    searchBar.delegate = self;
    searchBar.backgroundColor = kColorFAFAFA;
    searchBar.layer.cornerRadius = 5;
    searchBar.layer.masksToBounds = YES;
    UITextField  *seachTextFild = [searchBar valueForKey:@"searchField"];
    seachTextFild.backgroundColor = kColorFAFAFA;
    seachTextFild.textColor = [UIColor redColor];
    //修改搜索图标
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_search_goods"]];
    img.frame = CGRectMake(10, 0,20,20);
    seachTextFild.leftView = img;
    seachTextFild.leftViewMode = UITextFieldViewModeAlways;
    
    //修改字体大小
    seachTextFild.font = [UIFont systemFontOfSize:14];
//    [searchBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    
    UIButton * cancelBtn = [[UIButton alloc] init];
    cancelBtn.backgroundColor = kColorFAFAFA;
//    [titleView addSubview:cancelBtn];
    [cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn  setTitle:@"取消"  forState:UIControlStateNormal];
    [cancelBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(titleView);
//        make.right.mas_equalTo(-10);
//        make.left.mas_equalTo(10);
//        make.top.mas_equalTo(2);
//        make.bottom.mas_equalTo(-2);

//    }];
//    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(0);
//        make.width.mas_equalTo(50);
//        make.height.mas_equalTo(30);
//        make.top.mas_equalTo(0);
//    }];
    
}
#pragma mark - STBaseTableViewController

- (void)layoutTableView {
        self.tableView.y = CGRectGetMaxY(self.filterView.frame);
        self.tableView.height = self.view.height - self.filterView.height;
}

@end


@implementation SPInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView {
    CGFloat fliterViewY = 0;
    if (self.searchBar) {
        fliterViewY = 40;
    }
    SADropDownMenu *fliterView = [[SADropDownMenu alloc] initWithOrigin:CGPointMake(0, fliterViewY) andHeight:45];
    fliterView.delegate = self;
    fliterView.backgroundColor = [UIColor whiteColor];
    fliterView.layer.shadowColor = [UIColor blackColor].CGColor;
    fliterView.layer.shadowOffset = CGSizeMake(0, 1);
    fliterView.layer.shadowOpacity = .14f;
    fliterView.layer.shadowRadius = 3.f;
    self.filterView = fliterView;
    [self.view addSubview:fliterView];
    
    self.dataList = [NSMutableArray array];
    //综合
    SPInfoListFilterModel * filterModel = [[SPInfoListFilterModel alloc] init];
    [self.dataList addObject:filterModel];
    filterModel.title = @"综合";
    filterModel.imageSelectStr = @"home_shang_select";
    filterModel.imageNomalStr = @"home_xia_nomal";
     NSMutableArray * array = [NSMutableArray array];
    SAMenuRecordModel * model = [SAMenuRecordModel new];
    model.serveKey = @"compre";
    model.serveID = @"1";
    model.name = @"综合";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.serveKey = @"compre";
    model.serveID = @"2";
    model.name = @"最新上架";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.serveKey = @"compre";
    model.name = @"好评从高到低";
    model.serveID = @"3";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.serveKey = @"compre";
    model.name = @"评论数从高到低";
    model.serveID = @"4";
    [array addObject:model];
    filterModel.dataList= array;
    @weakify(filterModel)
    filterModel.tapClick = ^(BOOL isSelect){
        @strongify(filterModel)
        [self.filterView showOrDismissWithIndex:0];
    };
    filterModel.cellDidSelect = ^(SADropDownIndexPath *indexPath){
        @strongify(filterModel)
        SAMenuRecordModel * selectModel = filterModel.dataList[indexPath.row];
        
        [self.filterView showOrDismissWithIndex:indexPath.column];
        [self.filterParameters removeObjectForKey:@"price"];
        [self.filterParameters removeObjectForKey:@"volume"];
        [self.filterParameters setValue:selectModel.serveID forKey:selectModel.serveKey];
        [self requestDirectRecordArray:self.filterParameters];
    };
    //销量
    filterModel = [[SPInfoListFilterModel alloc] init];
//    filterModel.imageStr = @"home_shangxia_nomal";
    [self.dataList addObject:filterModel];
    filterModel.title = @"销量";
    filterModel.tapClick = ^(BOOL isSelect){
        if (isSelect) {
            [self.filterParameters removeObjectForKey:@"price"];
            [self.filterParameters setValue:@"1" forKey:@"volume"];
            
        }else{
            [self.filterParameters removeObjectForKey:@"volume"];
        }
        [self requestDirectRecordArray:self.filterParameters];


    };
    
    //价格
    filterModel = [[SPInfoListFilterModel alloc] init];
    filterModel.index = 2;
    [self.dataList addObject:filterModel];
    filterModel.title = @"价格";
    filterModel.imageNomalStr = @"home_shangxia_nomal";
    filterModel.imageSelectStr = @"home_shangxia_select";

    filterModel.dataList = [NSMutableArray array];
    filterModel.tapClick = ^(BOOL isSelect){
        if (isSelect) {
            [self.filterParameters setValue:@"2" forKey:@"price"];
        }else{
            [self.filterParameters setValue:@"1" forKey:@"price"];
        }
        [self.filterParameters removeObjectForKey:@"volume"];
        [self.filterParameters setValue:@"1" forKey:@"price"];
        [self requestDirectRecordArray:self.filterParameters];
    };
  
    self.filterView.delegate = self;
    self.filterView.dataSource = self;
}





- (NSInteger)numberOfColumnsInMenu:(SADropDownMenu *)menu {
    return self.dataList.count;
}



//点击tap
- (void)menu:(SADropDownMenu *)menu tabIndex:(NSInteger)currentTapIndex{
    SPInfoListFilterModel * model = self.dataList[currentTapIndex];
    if (model.tapClick) {
        model.tapClick(menu.isBtnSelected);
    }
    
}


- (NSInteger)menu:(SADropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    SPInfoListFilterModel * model = self.dataList[column];
    return model.dataList.count;
  
}

// 筛选segement标题
- (NSString *)menu:(SADropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    SPInfoListFilterModel * model = self.dataList[column];
    return model.title;
}

- (SPInfoListFilterModel *)menu:(SADropDownMenu *)menu modelForColumn:(NSInteger)column{
    SPInfoListFilterModel * model = self.dataList[column];
    return model;
}
- (SAMenuRecordModel *)menu:(SADropDownMenu *)menu modelForRowAtIndexPath:(SADropDownIndexPath *)indexPath{
    
    SPInfoListFilterModel * model = self.dataList[indexPath.column];
    return model.dataList[indexPath.row];
}

//- (SADropDownCollectionModel *)menu:(SADropDownMenu *)menu titleForRowAtIndexPath:(SADropDownIndexPath *)indexPath {
//
//    if (indexPath.column==0) {
//        return _data1[indexPath.row];
//    } else if (indexPath.column==1) {
//        return _data2[indexPath.row];
//    } else {
//        SADropDownCollectionModel *model = [[SADropDownCollectionModel alloc] init];
//        model.name = @"载货车";
//        return model;
//    }
//}
#pragma mark - mark SADropDownMenuDelegate 筛选代理
// 筛选
- (void)menuDidConfirm:(SADropDownMenu *)menu recordArray:(NSArray *)recordArray{
  
    [self requestDirectRecordArray:self.filterParameters];
}


- (void)menu:(SADropDownMenu *)menu didSelectRowAtIndexPath:(SADropDownIndexPath *)indexPath {
    SPInfoListFilterModel * model = self.dataList[indexPath.column];
    if (model.cellDidSelect) {
        model.cellDidSelect(indexPath);
    }
}

- (void)layoutFilterView {
    self.filterView.frame = (CGRect){CGPointZero, self.view.width, 40};
}


- (NSMutableDictionary *)filterParameters{
    
    if (_filterParameters == nil) {
        _filterParameters = [NSMutableDictionary dictionary];
    }
    return _filterParameters;
}

- (void)requestDirectRecordArray:(NSDictionary *)directParameters{
    //需要重写
    [self updateFilterWithParameters:self.filterParameters];
}
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
}

- (void)updateFilterWithParameters:(NSDictionary *)parameters {
    
}

@end
