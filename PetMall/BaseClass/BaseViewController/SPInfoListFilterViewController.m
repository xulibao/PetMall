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
@property(nonatomic, strong) UISearchBar *searchBar;
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
    model.name = @"综合";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.name = @"最新上架";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.name = @"好评从高到低";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.name = @"评论数从高到低";
    [array addObject:model];
    filterModel.dataList= array;
    @weakify(filterModel)
    filterModel.tapClick = ^{
        @strongify(filterModel)
        [self.filterView showOrDismissWithIndex:0];
    };
    filterModel.cellDidSelect = ^(SADropDownIndexPath *indexPath){
        @strongify(filterModel)
 
        [self.filterView showOrDismissWithIndex:indexPath.column];
    };
    //销量
    filterModel = [[SPInfoListFilterModel alloc] init];
//    filterModel.imageStr = @"home_shangxia_nomal";
    [self.dataList addObject:filterModel];
    filterModel.title = @"销量";
    filterModel.tapClick = ^{
        
        
    };
    filterModel.cellDidSelect = ^(SADropDownIndexPath *indexPath){
    };
    
    //价格
    filterModel = [[SPInfoListFilterModel alloc] init];
    filterModel.index = 2;
    [self.dataList addObject:filterModel];
    filterModel.title = @"价格";
    filterModel.imageNomalStr = @"home_shangxia_nomal";
    filterModel.imageSelectStr = @"home_shangxia_select";

    filterModel.dataList = [NSMutableArray array];
    filterModel.tapClick = ^{
//            @strongify(filterModel2)
        
    };
        
//    filterModel2.cellDidSelect = ^(SADropDownIndexPath *indexPath){
//            @strongify(filterModel2)
//
//
//    };
  
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
        model.tapClick();
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
  
    [self requestDirectRecordArray:[self directParameters]];
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


- (NSMutableDictionary *)directParameters{
    NSMutableDictionary * directParameters = [NSMutableDictionary dictionary];
    return directParameters;
}


- (void)requestDirectRecordArray:(NSDictionary *)directParameters{
    //需要重写
    self.filterParameters = directParameters;
    [self updateFilterWithParameters:self.filterParameters];
}

- (void)updateFilterWithParameters:(NSDictionary *)parameters {}

@end
