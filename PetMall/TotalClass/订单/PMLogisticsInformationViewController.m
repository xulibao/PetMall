//
//  PMLogisticsInformationViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/13.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMLogisticsInformationViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "OKLogisticsView.h"
#import "OKLogisticModel.h"
@interface PMLogisticsInformationViewController ()<BMKMapViewDelegate,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic, strong) BMKMapView* mapView;
@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong)  OKLogisticsView * logis;
@property (nonatomic,strong) NSMutableArray * dataArry;
@property(nonatomic, strong) UIButton *backBtn;

@property(nonatomic, strong) UIView *coverView;
@end

@implementation PMLogisticsInformationViewController
- (NSMutableArray *)dataArry {
    if (!_dataArry) {
        _dataArry = [NSMutableArray array];
    }
    return _dataArry;
}
-(void)initSubviews{
    [super initSubviews];
    BMKMapView* mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    UIView *coverView = [[UIView alloc] initWithFrame:mapView.bounds];
    coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    self.coverView =coverView;
    [mapView addSubview:coverView];
    
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView = scrollView;
    self.scrollView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(kMainBoundsWidth, kMainBoundsHeight * 1.56 - 64);
    scrollView.delegate = self;

    
    scrollView.y = kMainBoundsHeight * 0.56;
    [mapView addSubview:scrollView];

    NSArray *titleArr = [NSArray arrayWithObjects:
                         @"【上海市】快件已从浦东转运中心发出，准备 发往临沂市",
                         @"【上海市】快件已到达 浦东转运中心" ,
                         @"【上海市】快件已到达 上海电商一部集货点",
                         @"【上海市】你的快件已被物流公司揽件成功",
                         @"包裹正在等待揽件",
                         @"你的包裹已出库",
                         @"你的订单待配货",
                         @"你的订单开始处理",
                         nil];
    NSArray *timeArr = [NSArray arrayWithObjects:
                        @"上午\n11:25",
                        @"昨天\n14:25",

                        @"昨天\n11:25",

                        @"昨天\n10:36",

                        @"昨天\n10:15",

                        @"昨天\n9:25",
                        @"昨天\n9:08",

                        @"昨天\n8:45",
                        nil];
    NSArray *statusArr = [NSArray arrayWithObjects:
                        @(PMLogisticStatue_dangqianweizhi),
                          @(PMLogisticStatue_tuzhong),
                          @(PMLogisticStatue_tuzhong),
                          @(PMLogisticStatue_lanjian),
                          @(PMLogisticStatue_fahuo),
                          @(PMLogisticStatue_chuku),
                          @(PMLogisticStatue_xiadan),
                          @(PMLogisticStatue_start),
                          nil];

    for (NSInteger i = titleArr.count-1;i>=0 ; i--) {
        OKLogisticModel * model = [[OKLogisticModel alloc]init];
        model.dsc = [titleArr objectAtIndex:i];
        model.date = [timeArr objectAtIndex:i];
        model.statue = [[statusArr objectAtIndex:i] intValue];
        [self.dataArry addObject:model];
    }
    // 数组倒叙
    self.dataArry = (NSMutableArray *)[[self.dataArry reverseObjectEnumerator] allObjects];
    OKLogisticsView * logis = [[OKLogisticsView alloc]initWithDatas:self.dataArry];
    self.logis = logis;
    // 给headView赋值
    logis.wltype=@"已签收";
    logis.number = @"3908723967437";
    logis.company = @"韵达快运";
    logis.phone = @"400-821-6789";
    logis.imageUrl = @"https://tva4.sinaimg.cn/crop.0.0.180.180.180/7d83a716jw1e8qgp5bmzyj2050050aa8.jpg";
    logis.frame = scrollView.bounds;
    [self.scrollView addSubview:logis];
    
    UIButton *backBtn = [[UIButton alloc] init];
    self.backBtn = backBtn;
     [backBtn setImage:IMAGE(@"detail_back") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(12);
        make.top.mas_equalTo(self.view).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
    
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"------scrollView------%f",scrollView.y);
    NSLog(@"----logis------%f",self.logis.y);
    self.scrollView.y =  kMainBoundsHeight * 0.56 - self.scrollView.contentOffset.y;
    self.logis.y = self.scrollView.contentOffset.y;
    
    if (self.scrollView.y  < 200) {
        [self.backBtn setImage:IMAGE(@"nav_Back_normal") forState:UIControlStateNormal];
        float ritao = (200 - self.scrollView.y)/100;
        self.coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:ritao];
           self.scrollView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:ritao];
    }else{
        [self.backBtn setImage:IMAGE(@"detail_back") forState:UIControlStateNormal];
    }
}
- (void)setupNavgationBar {
    [super setupNavgationBar];
    
    //    UIColor *tintColor = [UIColor whiteColor];
    //    [self.navgationBar.leftBarButton removeFromSuperview];
    //    self.navgationBar.navigationBarBg.alpha = 0;
//    UIColor *tintColor = [UIColor whiteColor];
    [self.navgationBar.leftBarButton setImage:IMAGE(@"detail_back") forState:UIControlStateNormal];

     self.navgationBar.leftBarButton.frame = (CGRect){12,(self.navgationBar.height - 44) / 2, 44,44}; self.navgationBar.navigationBarBg.backgroundColor = [UIColor blackColor];
    self.navgationBar.navigationBarBg.alpha = 0.f;
    self.statusBarView.backgroundColor = [UIColor blackColor];
    self.statusBarView.alpha = 0.f;
    
//    self.navgationBar.titleLabel.textColor = [UIColor whiteColor];
//    self.navgationBar.titleLabel.text = @"我的积分";

}
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}
- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}
//- (BOOL)shouldInitSTNavgationBar{
//    return YES;
//}

@end
