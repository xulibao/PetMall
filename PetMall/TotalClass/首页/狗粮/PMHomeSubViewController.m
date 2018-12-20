//
//  PMHomeSubViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMHomeSubViewController.h"
#import "PMGoodsItem.h"
#import "PMGoodsCell.h"
#import "DCGoodBaseViewController.h"
#import <SDCycleScrollView.h>
#import "SAButton.h"
#import "PMHomeSubModel.h"
#import "PMSubHeaderView.h"
#import <SDWebImage/UIButton+WebCache.h>
@interface PMHomeSubViewController ()<SDCycleScrollViewDelegate,PMGoodsCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *bannersArray;
@property(nonatomic, strong) NSArray *titleArray1;
@property(nonatomic, strong) NSArray *titleArray2;
@property(nonatomic, strong) PMHomeSubModel *subModel;
/* 轮播图 */
@property (strong , nonatomic)SDCycleScrollView *cycleScrollView;
@end

@implementation PMHomeSubViewController

- (NSArray *)titleArray1{
    if (_titleArray1 == nil) {
        _titleArray1 = @[@"肉质零食",
                         @"磨牙洁齿",
                         @"罐头湿粮",
                         @"特色零食",
                         ];
    }
    return _titleArray1;
}
- (NSArray *)titleArray2{
    return @[@"牛肉",
             @"鸡肉",
             @"鸭肉",
             @"鱼肉",
             @"火腿肠",
             @"其他",
             ];
}
- (NSMutableArray *)bannersArray{
    if (_bannersArray == nil) {
        _bannersArray =  [@[] mutableCopy];
        
    }
    return _bannersArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel.cellDelegate = self;
    self.tableView.tag = 10000;
    if (self.filterParameters.count == 0) {
        [self.filterParameters setValue:@(self.page) forKey:@"pagenum"];
        [self.filterParameters setValue:@(10) forKey:@"pagesize"];
        [self.filterParameters setValue:[SAApplication sharedApplication].userType forKey:@"type"];

    }
    [self fetchData];
}
//- (void)layoutTableView {
//
//}
//- (void)layoutFilterView {
//}
- (void)initFilterView {
    NSMutableDictionary *dict = [@{@"zl":self.zl,@"type":[SAApplication sharedApplication].userType} mutableCopy];
    if ([SAApplication userID]) {
        [dict setValue:[SAApplication userID] forKey:@"user_id"];
    }
    [self requestPOST:API_Dogfood_specifications parameters:dict success:^(__kindof SARequest *request, id responseObject) {
        self.subModel = [PMHomeSubModel mj_objectWithKeyValues:responseObject[@"result"]];
        [self fectchSubViews];
        
    } failure:NULL];
}

- (void)fectchSubViews{
    int navCount = self.subModel.navigation.count / 4  + 1;
    int classiCount = self.subModel.classification.count / 3 + 1;
    CGFloat headH = navCount * 15 + 10 + classiCount * 50 + 10 + 150 +55;
    PMSubHeaderView * headerView = [[PMSubHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, headH)];
    headerView.backgroundColor = [UIColor whiteColor];
    headerView.userInteractionEnabled = YES;
    self.tableView.tableHeaderView = headerView;

    //轮播图
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 150) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    for (PMHomeSubNavigationModel * model in self.subModel.Broadcast) {
        [self.bannersArray addObject:model.img];
    }
    _cycleScrollView.imageURLStringsGroup = self.bannersArray;
    [headerView addSubview:_cycleScrollView];
    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(kMainBoundsWidth);
        make.height.mas_equalTo(150);
    }];
    CGFloat titelW = 50;
    CGFloat titelMargin = (kMainBoundsWidth - self.titleArray1.count *titelW)/8 ;
    UIButton * titelBtn;
    for (int i = 0; i < self.subModel.navigation.count; i ++) {
        PMHomeSubNavigationModel * model = self.subModel.navigation[i];
        UIButton * btn = [[UIButton alloc] init];
        titelBtn = btn;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:model.cate_title forState:UIControlStateNormal];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.cycleScrollView.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(titelMargin + i *(titelMargin * 2 + titelW));
                make.width.mas_equalTo(titelW);
                make.height.mas_equalTo(15);
            }];
    }
    CGFloat top;
    CGFloat titel2W = 105;
    CGFloat titel2Margin = (kMainBoundsWidth - 3 *titel2W)/6 ;
    UIButton * titel2Btn;
    for (int i = 0; i < self.subModel.classification.count; i ++) {
        PMHomeSubNavigationModel * model = self.subModel.classification[i];
        NSInteger hangshu = i / 3;
        NSInteger lieshu = i % 3;
        top = 10 + hangshu * (50 +titel2Margin);
        SAButton * btn = [[SAButton alloc] init];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        titel2Btn = btn;
        btn.backgroundColor = kColorEEEEEE;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.spacingBetweenImageAndTitle = 5;
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setTitle:model.cate_title forState:UIControlStateNormal];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [btn setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal placeholder:IMAGE(@"home_121312")];
        btn.imageView.size = CGSizeMake(50, 50);
//        [btn sd_setImageWithURL:[NSURL URLWithString:model.img] forState:UIControlStateNormal];
 
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(titelBtn.mas_bottom).mas_offset(top);
                make.left.mas_equalTo(titel2Margin + lieshu *(titel2Margin * 2 + titel2W));
                make.width.mas_equalTo(titel2W);
                make.height.mas_equalTo(50);
            }];
    }
//    headerView.height = top + 50;
//    CGFloat fliterViewY =  headerView.height + 10;
//    if (self.subModel.classification.count > 3) {
//        fliterViewY = 325;
//    }else{
//        fliterViewY = 225;
//    }
    SADropDownMenu *fliterView = [[SADropDownMenu alloc] initWithOrigin:CGPointMake(0, 0) andHeight:45];
    headerView.tableView = fliterView.tableView;
    fliterView.delegate = self;
    fliterView.backgroundColor = [UIColor whiteColor];
    fliterView.layer.shadowColor = [UIColor blackColor].CGColor;
    fliterView.layer.shadowOffset = CGSizeMake(0, 1);
    fliterView.layer.shadowOpacity = .14f;
    fliterView.layer.shadowRadius = 3.f;
    self.filterView = fliterView;
    [headerView addSubview:fliterView];
    [fliterView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        if (titel2Btn) {
            make.top.mas_equalTo(titel2Btn.mas_bottom).mas_offset(10);
        }else{
            make.top.mas_equalTo(titelBtn.mas_bottom).mas_offset(10);
        }
        make.left.right.mas_equalTo(headerView);
        make.height.mas_equalTo(45);
    }];

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
    model.serveID = @"3";
    model.name = @"好评从高到低";
    [array addObject:model];
    model = [SAMenuRecordModel new];
    model.serveKey = @"compre";
    model.serveID = @"4";
    model.name = @"评论数从高到低";
    [array addObject:model];
    filterModel.dataList= array;
    @weakify(filterModel)
    filterModel.tapClick = ^(BOOL isSelect){
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

- (void)btnClick:(SAButton *)btn{
    PMHomeSubNavigationModel * model = self.subModel.classification[btn.tag];
    [self.filterParameters setValue:model.pid forKey:@"lzl"];
    [self requestDirectRecordArray:self.filterParameters];
}

- (void)fecthHeaderView{
   
 
}

- (void)refreshingAction{
    [self fetchData];
}

#pragma mark - Request
- (void)fetchData{
    [self requestMethod:GARequestMethodPOST URLString:API_Dogfood_condition parameters:self.filterParameters resKeyPath:@"result" resArrayClass:[PMGoodsItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
}

- (void)cellDidAddCart:(PMGoodsItem *)item{
    if ([SAApplication needSignTool]){
        return;
    }
    
    [self requestPOST:API_Dogfood_cart parameters:@{@"goods_id":item.goodId,@"user_id":[SAApplication userID],@"type":@"1",@"list_id":item.list_id,@"shul":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"加入购物车成功！"];
    } failure:NULL];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 10000) {
        PMGoodsItem * goodsItem = self.dataArray[indexPath.row];
        DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
        vc.goods_id = goodsItem.goodId;
        vc.list_id  = goodsItem.list_id;
        [self.navigationController pushViewController:vc  animated:YES];
    }
}

//- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
//
//}

- (void)requestDirectRecordArray:(NSDictionary *)directParameters{
    //需要重写
    [self updateFilterWithParameters:self.filterParameters];
}

- (void)updateFilterWithParameters:(NSDictionary *)parameters {
    [self.filterParameters setValue:@(self.page) forKey:@"pagenum"];
    [self.filterParameters setValue:@(10) forKey:@"pagesize"];
    [self.filterParameters setValue:[SAApplication sharedApplication].userType forKey:@"type"];
    [self fetchData];
    
}

@end
