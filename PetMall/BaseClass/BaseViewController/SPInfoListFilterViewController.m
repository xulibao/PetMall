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

@property(nonatomic, copy) NSString *title;
@property(nonatomic, strong) NSMutableArray *dataList;
@property(nonatomic, assign) BOOL isShuaiXuan;
@property(nonatomic, copy) void (^tapClick)();

@property(nonatomic, copy) void (^cellDidSelect)(SADropDownIndexPath *indexPath);

@end

@implementation SPInfoListFilterModel

@end
@interface SPInfoListFilterViewController ()<SADropDownMenuDataSource,SADropDownMenuDelegate,STMenuRecordViewDelegate>
@property(nonatomic, copy) NSString *modelId;

@end

@implementation SPInfoListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutFilterView];
}

- (void)initSubviews {
    [super initSubviews];
    [self initFilterView];
//    [self initRecordView];
}

#pragma mark - STBaseTableViewController

- (void)layoutTableView {
    if (self.recordView.recordArray.count > 0) {
        self.recordView.hidden = NO;
        self.recordView.frame = CGRectMake(0, CGRectGetMaxY(self.filterView.frame) + 5, kMainBoundsWidth, self.recordView.height);
        CGFloat tableHeight = self.view.height - self.filterView.height - self.recordView.height;
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.recordView.frame), kMainBoundsWidth, tableHeight);
    }else{
        self.recordView.hidden = YES;
        self.tableView.y = CGRectGetMaxY(self.filterView.frame);
        self.tableView.height = self.view.height - self.filterView.height;
    }
}

@end


@implementation SPInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView {
    SADropDownMenu *fliterView = [[SADropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:45];
    fliterView.delegate = self;
    fliterView.backgroundColor = [UIColor whiteColor];
    fliterView.layer.shadowColor = [UIColor blackColor].CGColor;
    fliterView.layer.shadowOffset = CGSizeMake(0, 1);
    fliterView.layer.shadowOpacity = .14f;
    fliterView.layer.shadowRadius = 3.f;
    self.filterView = fliterView;
    [self.view addSubview:fliterView];
    
    self.dataList = [NSMutableArray array];
    //销量
    SPInfoListFilterModel * filterModel = [[SPInfoListFilterModel alloc] init];
    [self.dataList addObject:filterModel];
    filterModel.title = @"销量";
    filterModel.dataList = [NSMutableArray array];
    @weakify(filterModel)
    filterModel.tapClick = ^{
        @strongify(filterModel)
        [self.filterView showOrDismissWithIndex:0];
    };
    filterModel.cellDidSelect = ^(SADropDownIndexPath *indexPath){
        @strongify(filterModel)
        SAMenuRecordModel * selectModel = filterModel.dataList[indexPath.row];
        self.modelId = selectModel.serveID;
        selectModel.isSelect = YES;
        for (SAMenuRecordModel *model in filterModel.dataList) {
            model.serveKey = @"nModelsId";
            if (![selectModel isEqual:model]) {
                model.isSelect = NO;
            }
        }
        [self.filterView showOrDismissWithIndex:indexPath.column];
        // 检测是否要替换
        [self checkUpdateSelectModel:selectModel];
    };
    //价格
    filterModel = [[SPInfoListFilterModel alloc] init];
    [self.dataList addObject:filterModel];
    filterModel.title = @"价格";
    filterModel.tapClick = ^{
        
        
    };
    filterModel.cellDidSelect = ^(SADropDownIndexPath *indexPath){
    };
    
    //筛选
    SPInfoListFilterModel * filterModel3 = [[SPInfoListFilterModel alloc] init];
    
        filterModel3.index = 3;
        //所属公司
        SPInfoListFilterModel * filterModel2 = [[SPInfoListFilterModel alloc] init];
        filterModel2.index = 2;
        [self.dataList addObject:filterModel2];
        filterModel2.title = @"所属公司";
        filterModel2.dataList = [NSMutableArray array];
        @weakify(filterModel2)
        filterModel2.tapClick = ^{
            @strongify(filterModel2)
           
        };
        
        filterModel2.cellDidSelect = ^(SADropDownIndexPath *indexPath){
            @strongify(filterModel2)
            
            
        };
  
    self.filterView.delegate = self;
    self.filterView.dataSource = self;
}

- (void)initTopView{
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
//    self.searchBar = searchBar;
    
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
    for (SAMenuRecordModel *selectModel in recordArray) {
        SAMenuRecordModel *replaceModel;
        int replaceIndex = 0;
        BOOL isNoReplacement = NO;
        for (int i = 0; i < self.recordView.recordArray.count; i++) {
            SAMenuRecordModel *model = self.recordView.recordArray[i];
            if ([model.serveKey isEqualToString:selectModel.serveKey]) {
                if ([model.serveID isEqualToString:selectModel.serveID] && [model.serveSubID isEqualToString:selectModel.serveSubID]) {//如果选择条件一样 返回
                    isNoReplacement = YES;
                    break;
                }else{
                    replaceModel = selectModel;
                    replaceIndex = i;
                    break;
                }
            }
        }
        if (!isNoReplacement) {
            if (replaceModel) {
                [self.recordView.recordArray replaceObjectAtIndex:replaceIndex withObject:replaceModel];
                
            }else{
                [self.recordView.recordArray addObject:selectModel];
            }
        }
      
    }
    self.recordView.recordArray = self.recordView.recordArray;
    [self requestDirectRecordArray:[self directParameters]];
}


- (void)menu:(SADropDownMenu *)menu didSelectRowAtIndexPath:(SADropDownIndexPath *)indexPath {
    SPInfoListFilterModel * model = self.dataList[indexPath.column];
    if (model.cellDidSelect) {
        model.cellDidSelect(indexPath);
    }
}

- (void)checkUpdateSelectModel:(SAMenuRecordModel *)selectModel{
    SAMenuRecordModel *replaceModel;
    int replaceIndex = 0;
    for (int i = 0; i < self.recordView.recordArray.count; i++) {
        SAMenuRecordModel *model = self.recordView.recordArray[i];
        if ([model.serveKey isEqualToString:selectModel.serveKey]) {
            if ([model.serveID isEqualToString:selectModel.serveID]) {//如果选择条件一样 返回
                return;
            }else{
                replaceModel = selectModel;
                replaceIndex = i;
                break;
            }
        }
    }
    if (replaceModel) {
        [self.recordView.recordArray replaceObjectAtIndex:replaceIndex withObject:replaceModel];
    }else{
        [self.recordView.recordArray addObject:selectModel];
    }
    self.recordView.recordArray = self.recordView.recordArray;
    [self requestDirectRecordArray:[self directParameters]];
}

- (void)layoutFilterView {
    self.filterView.frame = (CGRect){CGPointZero, self.view.width, 40};
}

#pragma - mark STMenuRecordViewDelegate 标签代理
- (void)menuRecordView:(STMenuRecordView *)view didSelectBtn:(STMenuSelectRecordBtn *)btn{
    NSMutableArray * tempArray = [@[] mutableCopy];
    [self.recordView.recordArray enumerateObjectsUsingBlock:^(SAMenuRecordModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([model isEqual:btn.model]) {
            [tempArray addObject:model];
        }
    }];
    
    [tempArray enumerateObjectsUsingBlock:^(SAMenuRecordModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.recordView.recordArray removeObject:model];
    }];
    self.recordView.recordArray = self.recordView.recordArray;
    [self requestDirectRecordArray:[self directParameters]];
}

- (void)menuRecordViewDeleteAll:(STMenuRecordView *)view{
    [self.recordView.recordArray removeAllObjects];
    self.recordView.recordArray = self.recordView.recordArray;
    [self requestDirectRecordArray:[self directParameters]];
    
}

- (NSMutableDictionary *)directParameters{
    NSMutableDictionary * directParameters = [NSMutableDictionary dictionary];
    for (SAMenuRecordModel * model in self.recordView.recordArray) {
        if (model.serveKey && model.serveID) {
            [directParameters setObject:model.serveID forKey:model.serveKey];
        }
        if (model.serveSubID && model.serveSubKey) {
            [directParameters setObject:model.serveSubID forKey:model.serveSubKey];
        }
    }
    return directParameters;
}


- (void)requestDirectRecordArray:(NSDictionary *)directParameters{
    //需要重写
    self.filterParameters = directParameters;
    [self updateFilterWithParameters:self.filterParameters];
}

- (void)updateFilterWithParameters:(NSDictionary *)parameters {}

@end
