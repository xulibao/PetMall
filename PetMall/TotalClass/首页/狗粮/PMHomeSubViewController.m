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

#import <SDCycleScrollView.h>
#import "SAButton.h"
#import "PMHomeSubModel.h"
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
    [self fetchData];
}
- (void)layoutTableView {
    
}
- (void)layoutFilterView {
}
- (void)initFilterView {
    
    [self requestPOST:API_Dogfood_specifications parameters:@{@"user_id":[SAApplication userID],@"zl":@"2"} success:^(__kindof SARequest *request, id responseObject) {
        self.subModel = [PMHomeSubModel mj_objectWithKeyValues:responseObject[@"result"]];
        [self fectchSubViews];
        
    } failure:NULL];
}

- (void)fectchSubViews{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 370)];
    headerView.backgroundColor = [UIColor whiteColor];
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
    
    CGFloat titel2W = 105;
    CGFloat titel2Margin = (kMainBoundsWidth - 3 *titel2W)/6 ;
    UIButton * titel2Btn;
    for (int i = 0; i < self.subModel.classification.count; i ++) {
        PMHomeSubNavigationModel * model = self.subModel.classification[i];
        NSInteger hangshu = i / 3;
        NSInteger lieshu = i % 3;
        CGFloat top = 10 + hangshu * (50 +titel2Margin);
        SAButton * btn = [[SAButton alloc] init];
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
    
    CGFloat fliterViewY = 325;
    SADropDownMenu *fliterView = [[SADropDownMenu alloc] initWithOrigin:CGPointMake(0, fliterViewY) andHeight:45];
    fliterView.delegate = self;
    fliterView.backgroundColor = [UIColor whiteColor];
    fliterView.layer.shadowColor = [UIColor blackColor].CGColor;
    fliterView.layer.shadowOffset = CGSizeMake(0, 1);
    fliterView.layer.shadowOpacity = .14f;
    fliterView.layer.shadowRadius = 3.f;
    self.filterView = fliterView;
    [headerView addSubview:fliterView];
    
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
        
        
    };
    
    self.filterView.delegate = self;
    self.filterView.dataSource = self;

}

- (void)fecthHeaderView{
   
    
}

- (void)refreshingAction {
    [self fetchData];
}

#pragma mark - Request
- (void)fetchData {
    [self requestMethod:GARequestMethodPOST URLString:API_Dogfood_condition parameters:@{@"pagenum":@(self.page),@"pagesize":@"10"} resKeyPath:@"result" resArrayClass:[PMGoodsItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];
    } failure:NULL];
 

}

- (void)cellDidAddCart:(PMGoodsItem *)item{
    [self requestPOST:API_Dogfood_cart parameters:@{@"goods_id":item.goodId,@"user_id":[SAApplication userID],@"type":@"1",@"list_id":item.list_id,@"shul":@"1"} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"加入购物车成功！"];
        
    } failure:NULL];
}

@end
