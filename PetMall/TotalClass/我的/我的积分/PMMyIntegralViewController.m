//
//  PMMyIntegralViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyIntegralViewController.h"
#import "PMIntegralMallViewController.h"
#import "PMMyIntegralCell.h"
@interface PMMyIntegralViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UILabel *jifengLabel;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation PMMyIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的积分";
}
- (void)didInitialized {
    [super didInitialized];
    [self fecthSubView];
    [self fecthData];
}

- (void)fecthData{
    [self requestMethod:GARequestMethodPOST URLString:API_user_mypoints parameters:@{@"user_id":[SAApplication userID]} success:^(__kindof SARequest *request, id responseObject) {
        self.jifengLabel.text = [responseObject[@"result"][@"user"] stringValue];
        self.dataArray = [PMMyIntegralModel mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"integral"]];
        [self.tableView reloadData];
    } failure:NULL];
}
- (void)setupNavgationBar {
    [super setupNavgationBar];
    
    //    UIColor *tintColor = [UIColor whiteColor];
//    [self.navgationBar.leftBarButton removeFromSuperview];
    //    self.navgationBar.navigationBarBg.alpha = 0;
    UIColor *tintColor = [UIColor whiteColor];
    [self.navgationBar.leftBarButton setTintColor:tintColor];
    self.navgationBar.navigationBarBg.backgroundColor = [UIColor blackColor];
    self.navgationBar.navigationBarBg.alpha = 0.f;
    self.statusBarView.backgroundColor = [UIColor blackColor];
    self.statusBarView.alpha = 0.f;
    
    self.navgationBar.titleLabel.textColor = [UIColor whiteColor];
    self.navgationBar.titleLabel.text = @"我的积分";
//    _userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_morenzhaopian"]];
//    [self.navgationBar addSubview:_userIcon];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}
- (BOOL)shouldInitSTNavgationBar{
    return YES;
}
- (void)fecthSubView{
    UITableView *table = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:table];
    [table registerClass:[PMMyIntegralCell class] forCellReuseIdentifier:@"PMMyIntegralCellID"];
    self.tableView = table;
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(-20);
    }];
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 215)];
    self.tableView.tableHeaderView = headerView;
    headerView.backgroundColor = kColorFAFAFA;
    UIView * topView = [UIView new];
    [headerView addSubview:topView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, kMainBoundsWidth, 190);
    [topView.layer addSublayer:gradientLayer];
    
    UILabel * jifengLabel = [[UILabel alloc] init];
    self.jifengLabel = jifengLabel;
    jifengLabel.font = [UIFont systemFontOfSize:30];
    jifengLabel.text = @"417";
    jifengLabel.textColor = [UIColor whiteColor];
    [topView addSubview:jifengLabel];
    [jifengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(topView);
    }];
    
    UIImageView * middleView = [[UIImageView alloc] init];
    middleView.userInteractionEnabled = YES;
    [middleView handleTapActionWithBlock:^(UIView *sender) {
        PMIntegralMallViewController * vc = [PMIntegralMallViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    middleView.contentMode = UIViewContentModeScaleToFill;
    middleView.clipsToBounds = YES;
    middleView.image = IMAGE(@"order_shadowBg");
    [headerView addSubview:middleView];
    
    UIImageView *middleImage = [[UIImageView alloc]init];
    middleImage.image = [UIImage imageNamed:@"mine_jifengLogo"];
    [middleView addSubview:middleImage];
    
    UILabel *middleTitle = [[UILabel alloc] init];
    middleTitle.text = @"积分商城";
    middleTitle.numberOfLines = 0;
    middleTitle.textColor =  kColor333333;
    middleTitle.font = [UIFont systemFontOfSize:15];
    [middleView addSubview:middleTitle];

    UIImageView *arrow = [[UIImageView alloc]init];
    arrow.image = [UIImage imageNamed:@"home_youjiantou"];
    [middleView addSubview:arrow];

  
    [middleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(middleView);
        make.left.mas_equalTo(15);
    }];
    [middleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(middleImage.mas_right).mas_offset(15);
        make.centerY.mas_equalTo(middleView);
    }];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-16);
        make.centerY.mas_equalTo(middleView);
    }];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(headerView);
        make.height.mas_equalTo(190);
    }];
    
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(50);
    }];
    
}

#pragma mark - tableviewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMMyIntegralCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMMyIntegralCellID" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}



@end
