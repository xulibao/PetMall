//
//  PMHomeSubViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMHomeSubViewController.h"
#import "PMCommonGoodsItem.h"
#import <SDCycleScrollView.h>
#import "SAButton.h"
@interface PMHomeSubViewController ()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *bannersArray;
@property(nonatomic, strong) NSArray *titleArray1;
@property(nonatomic, strong) NSArray *titleArray2;
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
        _bannersArray =  @[@"http://gfs5.gomein.net.cn/T1obZ_BmLT1RCvBVdK.jpg",@"http://gfs9.gomein.net.cn/T1C3J_B5LT1RCvBVdK.jpg",@"http://gfs5.gomein.net.cn/T1CwYjBCCT1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1u8V_B4ET1RCvBVdK.jpg",@"http://gfs7.gomein.net.cn/T1zODgB5CT1RCvBVdK.jpg"];
        
    }
    return _bannersArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self fecthHeaderView];
    [self fetchData];
}
- (void)layoutTableView {
    
}
- (void)layoutFilterView {

}
- (void)initFilterView {
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 370)];
    headerView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = headerView;
    //轮播图
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 150) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    _cycleScrollView.imageURLStringsGroup = self.bannersArray;
    [headerView addSubview:_cycleScrollView];
    
    CGFloat titelW = 50;
    CGFloat titelMargin = (kMainBoundsWidth - self.titleArray1.count *titelW)/8 ;
    UIButton * titelBtn;
    for (int i = 0; i < 4; i ++) {
        UIButton * btn = [[UIButton alloc] init];
        titelBtn = btn;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitle:self.titleArray1[i] forState:UIControlStateNormal];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [headerView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_cycleScrollView.mas_bottom).mas_offset(10);
                make.left.mas_equalTo(titelMargin + i *(titelMargin * 2 + titelW));
                make.width.mas_equalTo(titelW);
                make.height.mas_equalTo(15);
            }];
    }
    
    CGFloat titel2W = 105;
    CGFloat titel2Margin = (kMainBoundsWidth - 3 *titel2W)/6 ;
        UIButton * titel2Btn;
    for (int i = 0; i < self.titleArray2.count; i ++) {
        NSInteger hangshu = i / 3;
        NSInteger lieshu = i % 3;
        CGFloat top = 10 + hangshu * (50 +titel2Margin);
        SAButton * btn = [[SAButton alloc] init];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        titel2Btn = btn;
        btn.spacingBetweenImageAndTitle = 5;
        btn.backgroundColor = kColorEEEEEE;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setImage:IMAGE(@"home_121312") forState:UIControlStateNormal];
        [btn setTitle:self.titleArray2[i] forState:UIControlStateNormal];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
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
    self.dataArray = [PMCommonGoodsItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    [self setItems:self.dataArray];
}

@end
