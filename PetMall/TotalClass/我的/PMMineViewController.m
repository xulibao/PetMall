//
//  PMMineViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMineViewController.h"
#import "STBaseViewController.h"
#import "SAMineCell.h"
#import "SAMineOrderCell.h"
#import "SAMineModel.h"
#import "SAMineHeadView.h"
#import "SAPersonCenterModel.h"
#import "SAMessageButton.h"
#import "PMOrderViewController.h"
#import "PMLogisticsInformationViewController.h"
#import "PMMyGroupPurchaseViewController.h"
#import "PMMyExchangeViewController.h"
#import "PMMyCollectionViewController.h"
#import "PMMyIntegralViewController.h"
#import "PMMyAddressViewController.h"
@interface PMMineViewController ()<UITableViewDelegate,UITableViewDataSource,SAMineHeadViewDelegate,SAMineOrderDelegate>
@property (nonatomic,strong) SAMineHeadView * headerView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) SAPersonCenterModel *personCenterModel;
@property (nonatomic, strong) UIButton *settingButton;
@property (nonatomic, strong) UIButton *giftButton;
@property (nonatomic, strong) SAMessageButton *messageButton;
@property(nonatomic, strong) SAMineModel * moneyModel;
@end

@implementation PMMineViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:2];
    }
    return _dataArray;
}

- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}

- (BOOL)shouldInitSTNavgationBar{
    return YES;
}

- (void)didInitialized {
    [super didInitialized];
//    [self fecthNetData];
    [self fecthSubViews];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self fecthNetData];
}

- (void)fecthNetData{
    SARequest * request = ({
        [self requestMethod:GARequestMethodGET
                  URLString:API_user_personalCenter
                 parameters:@{@"userId":[SAApplication userID]}
                 resKeyPath:@"data"
                   resClass:[SAPersonCenterModel class]
              resArrayClass:NULL
                      retry:NO
                  accessory:nil
                    success:^(__kindof SARequest *request, id responseObject) {
                        SAPersonCenterModel * personCenterModel = (SAPersonCenterModel *)responseObject;
                        self.personCenterModel = personCenterModel;
                        self.headerView.model = personCenterModel;
                        self.moneyModel.descTitle = personCenterModel.availableBond;
                        if (self.dataArray.count == 0) {
                            [self fecthSubViews];
                        }else{
                            [self.tableView reloadData];
                        }
                    } failure:NULL];
    });
    
    [request start];
    
    //    [self requestMethod:GARequestMethodGET URLString:API_user_personalCenter parameters: resKeyPath:@"data" resClass:[SAPersonCenterModel class] retry:NO success:^(__kindof SARequest *request, id responseObject) {
    //    } failure:^(__kindof SARequest *request, id responseObject, NSError *error) {
    //
    //    }];
}
- (void)fecthSubViews{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    SAMineModel * model = [[SAMineModel alloc] init];
    self.moneyModel = model;
    model.iconImage = @"mine_tuangou";
    model.titleName = @"我的团购";
    model.descTitle = [NSString stringWithFormat:@"%@元",self.personCenterModel.availableBond];
    [self.dataArray addObject:model];
    model.cellAction = ^(SAMineModel *model) {
        PMMyGroupPurchaseViewController * vc = [[PMMyGroupPurchaseViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    model = [[SAMineModel alloc] init];
    model.iconImage = @"mine_duihuan";
    model.titleName = @"我的兑换";
    [self.dataArray addObject:model];
    model.cellAction = ^(SAMineModel *model) {
        PMMyExchangeViewController *vc = [[PMMyExchangeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    model = [[SAMineModel alloc] init];
    model.iconImage = @"mine_shoucang";
    model.titleName = @"我的收藏";
    [self.dataArray addObject:model];
    model.cellAction = ^(SAMineModel *model) {
                PMMyCollectionViewController *vc = [[PMMyCollectionViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
    };
    
    model = [[SAMineModel alloc] init];
    model.iconImage = @"mine_pingjia";
    model.titleName = @"我的评价";
    [self.dataArray addObject:model];
    model.cellAction = ^(SAMineModel *model) {
//        SAMyCouponViewController *vc = [[SAMyCouponViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    
    model = [[SAMineModel alloc] init];
    model.iconImage = @"mine_dizhi";
    model.titleName = @"我的地址";
    [self.dataArray addObject:model];
    model.cellAction = ^(SAMineModel *model) {
        PMMyAddressViewController * vc = [[PMMyAddressViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
        model = [[SAMineModel alloc] init];
        model.iconImage = @"mine_bangzhu";
        model.titleName = @"帮助/问题";
        [self.dataArray addObject:model];
        //我的出价
        model.cellAction = ^(SAMineModel *model) {
                };
        model = [[SAMineModel alloc] init];
        model.iconImage = @"mine_fengxiang";
        model.titleName = @"分享";
        //商户必读
        model.cellAction = ^(SAMineModel *model) {

        };
    //我的出价
    model.cellAction = ^(SAMineModel *model) {
    };
    model = [[SAMineModel alloc] init];
    model.iconImage = @"mine_lianxikefu";
    model.titleName = @"联系客服";
    //商户必读
    model.cellAction = ^(SAMineModel *model) {
        
    };

        [self.dataArray addObject:model];
    [self.tableView reloadData];
}
- (void)initSubviews {
    [super initSubviews];
    self.statusBarView.hidden = YES;
    //    self.tabelView = [[UITableView alloc] init];
    
    //    self.additionalSafeAreaInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    ////    self.tabelView.adjustedContentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    if (@av) {
    //        statements
    //    }
    //    self.tabelView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    SAMineHeadView * headerView = [[SAMineHeadView alloc] init];
    self.headerView = headerView;
    headerView.delegate = self;
    headerView.width = kMainBoundsWidth;
    headerView.height = 255;
    [headerView setIsLogin:YES];
    self.tableView.tableHeaderView = headerView;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    
}

- (void)setupNavgationBar{
    [super setupNavgationBar];
    self.navgationBar.navigationBarBg.hidden = NO;
    self.navgationBar.navigationBarBg.userInteractionEnabled = YES;
    self.navgationBar.navigationBarBg.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.0f];
    self.navgationBar.leftBarButton.hidden = YES;
    self.messageButton = [[SAMessageButton alloc] init];
    [self.messageButton addTarget:self action:@selector(messageButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationBar.navigationBarBg addSubview:self.messageButton];
    
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.settingButton setTitle:@"设置"  forState:UIControlStateNormal];
    [self.settingButton addTarget:self action:@selector(settingButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationBar.navigationBarBg addSubview:self.settingButton];
    // 礼物
    self.giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.giftButton setImage:[UIImage imageNamed:@"mine_gift"] forState:UIControlStateNormal];
    [self.giftButton addTarget:self action:@selector(giftButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navgationBar.navigationBarBg addSubview:self.giftButton];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navgationBar.navigationBarBg);
        make.right.mas_equalTo(self.navgationBar.navigationBarBg).mas_offset(-15);
    }];
    
    [self.giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navgationBar.navigationBarBg);
        make.right.mas_equalTo(self.messageButton.mas_left).mas_offset(-15);
    }];
    
    [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.navgationBar.navigationBarBg);
        make.right.mas_equalTo(self.navgationBar.navigationBarBg).mas_offset(-15);
    }];
    
}

//消息
- (void)messageButtonClick{
}
//设置
- (void)settingButtonClick{
    
}

#pragma mark - MineOrderDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return 1;
    }else{
        return self.dataArray.count;
        
    }
}



- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        static NSString* ID = @"SAMineOrderCell";
        SAMineOrderCell* cell = [SAMineOrderCell cellWith:tableView WithIdentifier:ID];
        cell.model = self.personCenterModel;
        cell.delegate = self;
        //        cell.model = self.dataArray[indexPath.row];
        return cell;
    }else{
        static NSString* ID = @"SAMineCell";
        SAMineCell* cell = [SAMineCell cellWith:tableView WithIdentifier:ID];
        cell.model = self.dataArray[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        return 135;
    }else{
        return 54;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==  1) {
        SAMineModel *model = self.dataArray[indexPath.row];
        if (model.cellAction) {
            model.cellAction(model);
        }
    }
}

#pragma mark - mineHeadViewDelegate
- (void)mineOrderClickWithType:(SAMineOrderType)type{
    
    PMOrderViewController * vc = [PMOrderViewController new];
    [self.navigationController pushViewController:vc animated:YES];
//    PMLogisticsInformationViewController * vc = [PMLogisticsInformationViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)mineHeadViewClickYouhui{
    
}

- (void)mineHeadViewClickJifeng{
    PMMyIntegralViewController * vc = [PMMyIntegralViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
