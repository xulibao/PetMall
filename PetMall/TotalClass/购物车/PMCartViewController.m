//
//  PMCartViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/8/28.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMCartViewController.h"
#import "PMConfirmOrderViewController.h"
#import "DCRecommendItem.h"
#import "PMCartCell.h"
#import "SARefreshHeader.h"

static NSString *const PMCartCellID = @"PMCartCell";

@interface PMCartViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UIButton *balanceBtn;
@property(nonatomic, strong) UIButton *allSelectBtn;
@property(nonatomic, strong) UIButton *collectBtn;
@property(nonatomic, strong) UIButton *deleteBtn;
@property(nonatomic, strong) UILabel *totalPriceLabel;
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, assign) float totalPrice;
@property(nonatomic, assign) BOOL isCartEdit;
@property(nonatomic, strong) UIButton * signBtn;
@end

@implementation PMCartViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    self.view.backgroundColor = kColorFAFAFA;
    if ([SAApplication userID] == nil) {
        [self fecthOffLine];
    }else{
        [self fecthNavView];
        [self fecthTableView];
        [self fecthBottomView];
        self.isCartEdit = YES;
        [self.tableView reloadData];
    }
}

- (void)fecthOffLine{
    UIButton * signBtn = [UIButton new];
    self.signBtn = signBtn;
    [signBtn addTarget:self action:@selector(signBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [signBtn setTitle:@"登录" forState:UIControlStateNormal];
    [signBtn setTitleColor:kColorTextGay forState:UIControlStateNormal];
    signBtn.layer.cornerRadius = 15;
    signBtn.layer.borderColor = kColorTextGay.CGColor;
    signBtn.layer.borderWidth = 1;
    [self.view addSubview:signBtn];
    [signBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
}

- (void)signBtnClick{
    PMLoginViewController *loginVc = [[PMLoginViewController alloc] init];
    loginVc.callBack = ^(PMLoginViewController *viewController) {
        [viewController.navigationController popToRootViewControllerAnimated:YES];
        [self.signBtn removeFromSuperview];
        [self fecthNavView];
        [self fecthTableView];
        [self fecthBottomView];
        self.isCartEdit = YES;
        [self fecthData];
    };
    [self.navigationController pushViewController:loginVc animated:YES];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([SAApplication userID]) {
        [self fecthData];
    }
}

-  (void)fecthData{
    [self requestMethod:GARequestMethodPOST URLString:API_Dogfood_cartlist parameters:@{@"pagenum":@"1",@"user_id":[SAApplication userID],@"pagesize":@"10"} resKeyPath:@"result" resArrayClass:[PMCartItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        [self.tableView.mj_header endRefreshing];
        self.dataArray = responseObject;
        if (self.dataArray.count == 0) {
            [self showEmptyView];
        }else{
            [self.tableView reloadData];
        }
    } failure:NULL];
}

- (void)fecthNavView{
    UIBarButtonItem * button = [self setupNavRightCSBarButtonWithAction:@selector(editClick:)];
    [button setTitle:@"编辑"];
}
- (void)fecthTableView{
    UITableView * tableView = [[UITableView alloc] init];
    tableView.backgroundColor = kColorFAFAFA;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
        self.tableView.mj_header = [SARefreshHeader headerWithRefreshingTarget:self
                                                          refreshingAction:@selector(refreshingAction)];
    
    tableView.tableFooterView = nil;
    [tableView registerClass:[PMCartCell class] forCellReuseIdentifier:PMCartCellID];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(-44);
    }];
}
- (void)refreshingAction{
    [self fecthData];
}
- (void)fecthBottomView{
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton * allSelectBtn = [[UIButton alloc] init];
    allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    self.allSelectBtn = allSelectBtn;
    [allSelectBtn setImage:IMAGE(@"cart_yuanquan") forState:UIControlStateNormal];
    [allSelectBtn setImage:IMAGE(@"cart_yuanquan_selected") forState:UIControlStateSelected];
    [allSelectBtn setTitle:@"全选" forState:UIControlStateNormal];
    [allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [allSelectBtn addTarget:self action:@selector(allSelect) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:allSelectBtn];
    
    UILabel *countLabel = [[UILabel alloc] init];
    self.totalPriceLabel = countLabel;
    NSString * countStr = @"合计：¥0";
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:countStr];
    [str addAttributes:@{NSForegroundColorAttributeName:kColorFF5554} range:[countStr rangeOfString:@"¥0"]];
    countLabel.attributedText = str;
    countLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:countLabel];
    
    
    
    UIButton * balanceBtn = [[UIButton alloc] init];
    [balanceBtn addTarget:self action:@selector(balanceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.balanceBtn = balanceBtn;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 110, 44);
    [self.balanceBtn.layer addSublayer:gradientLayer];
    [balanceBtn setTitle:@"去结算（0）" forState:UIControlStateNormal];
    [balanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    balanceBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:balanceBtn];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
        ;    }];
    
    [allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(70);
        make.centerY.mas_equalTo(bottomView);
    }];
    
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(bottomView);
        make.right.mas_equalTo(balanceBtn.mas_left);
        make.width.mas_equalTo(110);
    }];
    
    [balanceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(bottomView);
        make.width.mas_equalTo(110);
    }];
    
    
    // 收藏和删除
    UIButton * collectBtn = [[UIButton alloc] init];
    collectBtn.hidden = YES;
    self.collectBtn = collectBtn;
    [collectBtn addTarget:self action:@selector(collectBtnClick)  forControlEvents:UIControlEventTouchUpInside];
    collectBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [collectBtn setTitle:@"移入收藏" forState:UIControlStateNormal];
    [collectBtn setTitleColor:[UIColor colorWithHexStr:@"#999999"] forState:UIControlStateNormal];
    collectBtn.layer.borderColor = [UIColor colorWithHexStr:@"#999999"].CGColor;
    collectBtn.layer.cornerRadius = 14;
    collectBtn.layer.borderWidth = 0.5;
    [bottomView addSubview:collectBtn];

    UIButton * deleteBtn = [[UIButton alloc] init];
    deleteBtn.hidden = YES;
    self.deleteBtn = deleteBtn;
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setTitleColor:[UIColor colorWithHexStr:@"#FF3945"] forState:UIControlStateNormal];
    deleteBtn.layer.borderColor = [UIColor colorWithHexStr:@"#FF3945"].CGColor;
    deleteBtn.layer.cornerRadius = 14;
    deleteBtn.layer.borderWidth = 0.5;
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick)  forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:deleteBtn];
    
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(deleteBtn.mas_left).mas_offset(-15);
        make.centerY.mas_equalTo(bottomView);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
    
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
}

#pragma mark - uitableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PMCartItem  * item = self.dataArray[section];
    return item.order_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PMCartCell *cell = [tableView dequeueReusableCellWithIdentifier:PMCartCellID forIndexPath:indexPath];
    
    PMCartItem  * item = self.dataArray[indexPath.section];
    DCRecommendItem * subItem = item.order_list[indexPath.row];
    cell.calculateCallBack = ^(NSString *goodsCount,NSString *zt) {
        [self calculateTotal];
        if (zt) {
            [self requestPOST:API_Dogfood_shopping parameters:@{@"cart_id":subItem.cart_id,@"zt":zt} success:^(__kindof SARequest *request, id responseObject) {
                [self fecthData];
            } failure:NULL];
        }
 
    };
    cell.item = subItem;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 10)];
    headerView.backgroundColor = kColorFAFAFA;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#pragma mark - action

- (void)calculateTotal{
    float totalPrice = 0;
    int totalGoodsCount = 0;
    for (PMCartItem  *cartItem in self.dataArray) {
        for (DCRecommendItem *recommendItem in cartItem.order_list) {
            if (recommendItem.isSelect) {
                totalPrice += [recommendItem.goods_shul intValue] * [recommendItem.market_price floatValue];
                totalGoodsCount += [recommendItem.goods_shul intValue];
            }
        }
    }
    self.totalPrice = totalPrice;
    NSString *totalPriceStr = [NSString stringWithFormat:@"总计￥%.2f", totalPrice];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:totalPriceStr];
    [str addAttributes:@{NSForegroundColorAttributeName:kColorFF5554} range:[totalPriceStr rangeOfString:[NSString stringWithFormat:@"合计￥%.2f", totalPrice]]];
    self.totalPriceLabel.attributedText = str;
    [self.balanceBtn setTitle:[NSString stringWithFormat:@"结算(%d)", totalGoodsCount] forState:UIControlStateNormal];
}
- (void)editClick:(UIBarButtonItem *)editBtn{
    if (self.isCartEdit) {
        self.isCartEdit = NO;
        [editBtn setTitle:@"完成"];
        self.collectBtn.hidden = NO;
        self.deleteBtn.hidden = NO;
        self.totalPriceLabel.hidden = YES;
        self.balanceBtn.hidden = YES;
    }else{
        self.isCartEdit = YES;
        [editBtn setTitle:@"编辑"];
        self.totalPriceLabel.hidden = NO;
        self.balanceBtn.hidden = NO;
        self.collectBtn.hidden = YES;
        self.deleteBtn.hidden = YES;
    }
    
    
}

- (void)allSelect{
    self.allSelectBtn.selected = !self.allSelectBtn.selected;
    float totalPrice = 0;
    int totalGoodsCount = 0;
    for (PMCartItem  *cartItem in self.dataArray) {
        for (DCRecommendItem *recommendItem in cartItem.order_list) {
            if (self.allSelectBtn.selected) {
                recommendItem.isSelect = YES;
                totalPrice += [recommendItem.goods_shul intValue] * [recommendItem.market_price floatValue];
                totalGoodsCount += [recommendItem.goods_shul intValue];
            }else{
                recommendItem.isSelect = NO;
            }
        }
    }
    NSString *totalPriceStr = [NSString stringWithFormat:@"总计￥%.2f", totalPrice];
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:totalPriceStr];
    [str addAttributes:@{NSForegroundColorAttributeName:kColorFF5554} range:[totalPriceStr rangeOfString:[NSString stringWithFormat:@"合计￥%.2f", totalPrice]]];
    self.totalPriceLabel.attributedText = str;
    [self.balanceBtn setTitle:[NSString stringWithFormat:@"结算(%d)", totalGoodsCount] forState:UIControlStateNormal];
    [self.tableView reloadData];
    
}

//收藏
- (void)collectBtnClick{
    if ([SAApplication needSignTool]) {
        return;
    }
    BOOL isGoodsSelect = NO;
    NSMutableArray *goodsIds = [NSMutableArray array];
    for (PMCartItem  *cartItem in self.dataArray) {
        for (DCRecommendItem *recommendItem in cartItem.order_list) {
            if (recommendItem.isSelect) {
                isGoodsSelect = YES;
                [goodsIds addObject:recommendItem.goodId];
            }
        }
    }
    
    if (!isGoodsSelect) {
        [self showErrow:@"您还没有选择商品"];
        return;
    }
    
    NSString * goodsIdStr = [goodsIds componentsJoinedByString:@","];
    [self requestPOST:API_Dogfood_collection parameters:@{@"goods_id":goodsIdStr,@"user_id":[SAApplication userID]} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:responseObject[@"msg"]];
    } failure:NULL];

}

//删除
- (void)deleteBtnClick{
    BOOL isGoodsSelect = NO;
    NSMutableArray *goodsIds = [NSMutableArray array];
    for (PMCartItem  *cartItem in self.dataArray) {
        for (DCRecommendItem *recommendItem in cartItem.order_list) {
            if (recommendItem.isSelect) {
                isGoodsSelect = YES;
                [goodsIds addObject:recommendItem.cart_id];
            }
        }
    }
    
    if (!isGoodsSelect) {
        [self showErrow:@"您还没有选择商品"];
        return;
    }
    NSString * goodsIdStr = [goodsIds componentsJoinedByString:@","];
    [self requestPOST:API_Dogfood_deletion parameters:@{@"cart_id":goodsIdStr,@"user_id":[SAApplication userID]} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:responseObject[@"msg"]];
        [self fecthData];
    } failure:NULL];

}
//结算
- (void)balanceBtnClick{
    if ([SAApplication needSignTool]) {
        return;
    }
    BOOL isGoodsSelect = NO;
    NSMutableArray *goodsIds = [NSMutableArray array];
    for (PMCartItem  *cartItem in self.dataArray) {
        for (DCRecommendItem *recommendItem in cartItem.order_list) {
            if (recommendItem.isSelect) {
                [goodsIds addObject:recommendItem.cart_id];
                isGoodsSelect = YES;
            }
        }
    }
    if (!isGoodsSelect) {
        [self showErrow:@"您还没有选择商品"];
        return;
    }
    NSString * goodsIdStr = [goodsIds componentsJoinedByString:@","];
    PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
    vc.price = [@(self.totalPrice) stringValue];
    vc.order_id =  goodsIdStr;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
