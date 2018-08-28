//
//  SAInfoListFilterViewController.m
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAInfoListFilterViewController.h"
@interface SAInfoListFilterViewController ()<SADropDownMenuDataSource,SADropDownMenuDelegate,STMenuRecordViewDelegate>

@property (nonatomic,strong) NSMutableArray * data1;
@property (nonatomic,strong) NSMutableArray * data2;
@property (nonatomic,strong) NSMutableArray * data3;

@end

@implementation SAInfoListFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutFilterView];
}

- (void)initSubviews {
    [super initSubviews];
    [self initFilterView];
    [self initRecordView];
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


@implementation SAInfoListFilterViewController (SubclassingHooks)

- (void)initFilterView {
    SADropDownMenu *fliterView = [[SADropDownMenu alloc] initWithOrigin:CGPointMake(0, 20) andHeight:45];
    fliterView.delegate = self;
    fliterView.backgroundColor = [UIColor whiteColor];
    fliterView.layer.shadowColor = [UIColor blackColor].CGColor;
    fliterView.layer.shadowOffset = CGSizeMake(0, 1);
    fliterView.layer.shadowOpacity = .14f;
    fliterView.layer.shadowRadius = 3.f;
    self.filterView = fliterView;
    NSMutableArray * array = [NSMutableArray array];
    SADropDownCollectionModel * model = [[SADropDownCollectionModel alloc] init];
    model.name = @"4x2";
    model.serveKey = @"drive";
    model.serveID = @"1";
    [array addObject:model];

    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"6x2";
    model.serveKey = @"drive";
    model.serveID = @"2";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"6x4";
    model.serveKey = @"drive";
    model.serveID = @"3";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"6x6";
    model.serveKey = @"drive";
    model.serveID = @"4";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"8x2";
    model.serveKey = @"drive";
    model.serveID = @"5";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"8x4";
    model.serveKey = @"drive";
    model.serveID = @"6";
    [array addObject:model];
    self.filterView.qudongArray = array;
    
    array = [NSMutableArray array];
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"柴油";
    model.serveKey = @"fuel";
    model.serveID = @"1";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"天然气";
    model.serveKey = @"fuel";
    model.serveID = @"2";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"纯电动";
    model.serveKey = @"fuel";
    model.serveID = @"3";
    [array addObject:model];
    self.filterView.ranliaoArray = array;
    
    
    array = [NSMutableArray array];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国一";
    model.serveKey = @"emission";
    model.serveID = @"5";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国二";
    model.serveKey = @"emission";
    model.serveID = @"3";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国三";
    model.serveKey = @"emission";
    model.serveID = @"1";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国四";
    model.serveKey = @"emission";
    model.serveID = @"2";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国五";
    model.serveKey = @"emission";
    model.serveID = @"4";
    [array addObject:model];
    
    model = [[SADropDownCollectionModel alloc] init];
    model.name = @"国六";
    model.serveKey = @"emission";
    model.serveID = @"6";
    [array addObject:model];
    self.filterView.paifangArray = array;
    [self.view addSubview:fliterView];
    
    
    NSMutableArray * data1 = [NSMutableArray array];
    self.data1 = data1;
    NSMutableArray * data2 = [NSMutableArray array];
    self.data2 = data2;
    NSMutableArray * data3 = [NSMutableArray array];
    self.data3 = data3;
//    [fliterView addTarget:self
//                action:@selector(pageControlValueChanged:)
//      forControlEvents:UIControlEventValueChanged];
    self.filterView.delegate = self;
    self.filterView.dataSource = self;
}

- (void)initRecordView{
    STMenuRecordView * recordView = [[STMenuRecordView alloc] init];
    recordView.frame = CGRectMake(0, CGRectGetMaxY(self.filterView.frame), kMainBoundsWidth, 0);
    [self.view addSubview:recordView];
    self.recordView = recordView;
    recordView.delegate = self;
    recordView.backgroundColor = [UIColor colorWithHexStr:@"#F3F3F3"];
}



- (NSInteger)numberOfColumnsInMenu:(SADropDownMenu *)menu {
    
    return 3;
}

-(BOOL)displayByCollectionViewInColumn:(NSInteger)column{
    if (column == 2) {
        return YES;
    }
    return NO;
}


//点击tap
- (void)menu:(SADropDownMenu *)menu tabIndex:(NSInteger)currentTapIndex{
    switch (currentTapIndex) {
        case 0:{
            if (self.data1.count == 0) {
                [self requestMethod:GARequestMethodGET
                          URLString:API_dictionaries_getAllModel parameters:nil resKeyPath:@"data"
                      resArrayClass:[SAMenuRecordModel class] retry:YES
                            success:^(__kindof SARequest *request, id responseObject) {
                                self.data1 = responseObject;
                                [self.filterView showOrDismissWithIndex:currentTapIndex];
                                
                            } failure:NULL];
            }else{
                // 车型标签是否被删除
                BOOL isHaveTag =  NO;
                for (SAMenuRecordModel *model in self.recordView.recordArray) {
                    if ([model.serveKey isEqualToString:@"modelId"]) {
                        isHaveTag = YES;
                        break;
                    }
                }
                if (!isHaveTag) {
                    for (SAMenuRecordModel *model in self.data1) {
                        model.isSelect = NO;
                    }
                }
                [self.filterView showOrDismissWithIndex:currentTapIndex];
            }
        }
            break;
        case 1:{
//            SACarBandVc * vc = [[SACarBandVc alloc] init];
//            vc.callBack = ^(SAMenuRecordModel *model) {
//                [self checkUpdateSelectModel:model];
//            };
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            // 数据整理
            [self dropDownViewCheckData:self.filterView.qudongArray];
            [self dropDownViewCheckData:self.filterView.ranliaoArray];
            [self dropDownViewCheckData:self.filterView.paifangArray];
            BOOL isHasMileage = NO;
            BOOL isHasCarAge = NO;
            for (SAMenuRecordModel *model in self.recordView.recordArray) {
                if ([model.serveKey isEqualToString:@"mileageEnd"]) {
                    isHasMileage = YES;
                    [self.filterView.footerView.mileageSlider updateWithLeftValue:[model.serveSubID integerValue] rightValue:[model.serveID integerValue]];
                }else if ([model.serveKey isEqualToString:@"carAgeEnd"]){
                    isHasCarAge = YES;
                     [self.filterView.footerView.yearSlider updateWithLeftValue:[model.serveSubID integerValue] rightValue:[model.serveID integerValue]];
                }
            }
            if (!isHasCarAge) {
                [self.filterView.footerView.yearSlider updateWithLeftValue:0 rightValue:100000];
            }
            if (!isHasMileage) {
                  [self.filterView.footerView.mileageSlider updateWithLeftValue:0 rightValue:100000];
            }
            
            [self.filterView showOrDismissWithIndex:currentTapIndex];
        }
            break;
        default:
            break;
    }
    
}
- (void)dropDownViewCheckData:(NSArray *)array{
    for (SADropDownCollectionModel *dropDownModel in array) {
        if (self.recordView.recordArray.count > 0) {
            for (SAMenuRecordModel *recordModel in self.recordView.recordArray) {
                if ([recordModel.serveID isEqualToString:dropDownModel.serveID] && [recordModel.serveKey isEqualToString:dropDownModel.serveKey]) {
                    dropDownModel.isSelect = YES;
                    break;
                }else{
                    dropDownModel.isSelect = NO;
                }
            }
        }else{
            dropDownModel.isSelect = NO;
        }
    }
}

- (NSInteger)menu:(SADropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column{
    
    if (column==0) {
        return _data1.count;
    } else if (column==1){
        
        return _data2.count;
        
    } else if (column==2){
        
        return 9;
    }
    
    return 0;
}

// 筛选segement标题
- (NSString *)menu:(SADropDownMenu *)menu titleForColumn:(NSInteger)column{
    
    switch (column) {
        case 0:
            return @"车型";
            break;
        case 1: return @"品牌";
            break;
        case 2: return @"筛选";
            break;
        default:
            return nil;
            break;
    }
}

- (SAMenuRecordModel *)menu:(SADropDownMenu *)menu modelForRowAtIndexPath:(SADropDownIndexPath *)indexPath{
    if (indexPath.column==0) {
        return _data1[indexPath.row];
    } else if (indexPath.column==1) {
        return _data2[indexPath.row];
    }else{
        return nil;
    }
}

- (SADropDownCollectionModel *)menu:(SADropDownMenu *)menu titleForRowAtIndexPath:(SADropDownIndexPath *)indexPath {
    
    if (indexPath.column==0) {
        return _data1[indexPath.row];
    } else if (indexPath.column==1) {
        
        return _data2[indexPath.row];
        
    } else {
        SADropDownCollectionModel *model = [[SADropDownCollectionModel alloc] init];
        model.name = @"载货车";
        return model;
    }
}
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
    if (indexPath.column == 0) {
        SAMenuRecordModel * selectModel = self.data1[indexPath.row];
        selectModel.isSelect = YES;
        for (SAMenuRecordModel *model in self.data1) {
            model.serveKey = @"modelId";
            if (![selectModel isEqual:model]) {
                model.isSelect = NO;
            }
        }
        [self.filterView showOrDismissWithIndex:indexPath.column];
        
        // 检测是否要替换
        [self checkUpdateSelectModel:selectModel];
    } else if(indexPath.column == 1){
        
    } else{ 
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
