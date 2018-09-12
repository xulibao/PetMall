//
//  PMConfirmOrderViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/10.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMConfirmOrderViewController.h"
#import "PMConfirmOrderHeaderView.h"
#import "PMConfirmOrderCell.h"
#import "PMOrderSelectCell.h"
#import "STCoverView.h"
#import "PMCoverCell.h"
#import "PMVoucherCell.h"
#import "PMConfirmPayViewController.h"
@interface PMConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) PMConfirmOrderHeaderView *headerView;
@property(nonatomic, strong) UIView *footerView;
@property(nonatomic, strong) NSMutableArray *dataArray;
@property(nonatomic, strong) NSMutableArray *expressArray;
@property(nonatomic, strong) NSMutableArray *voucherArray;
@property (nonatomic, strong) STCoverView *coverBtn;
@property(nonatomic, strong) UITableView *subTableView;
@property(nonatomic, strong) UILabel *subTableTitleLabel;

@end

@implementation PMConfirmOrderViewController
- (NSMutableArray *)voucherArray{
    if (_voucherArray == nil) {
        _voucherArray = [@[] mutableCopy];
        PMVoucherModel * model = [PMVoucherModel new];
        model.price = @"10";
        model.isEnable = YES;
        [_voucherArray addObject:model];
        model = [PMVoucherModel new];
        model.price = @"20";
        model.isEnable = YES;
        [_voucherArray addObject:model];
        model = [PMVoucherModel new];
        model.price = @"30";
        model.isEnable = YES;
        [_voucherArray addObject:model];
        model = [PMVoucherModel new];
        model.price = @"40";
        model.isEnable = YES;
        [_voucherArray addObject:model];
        model = [PMVoucherModel new];
        model.price = @"50";
        model.isEnable = NO;
        [_voucherArray addObject:model];
        
    }
    return _voucherArray;
}
- (NSMutableArray *)expressArray{
    if (_expressArray == nil) {
        _expressArray = [@[] mutableCopy];
        PMExpressModel * model = [PMExpressModel new];
        model.expressName = @"顺丰快递";
        [_expressArray addObject:model];
        model = [PMExpressModel new];
        model.expressName = @"圆通快递";
        [_expressArray addObject:model];
        model = [PMExpressModel new];
        model.expressName = @"中通快递";
        [_expressArray addObject:model];
        model = [PMExpressModel new];
        model.expressName = @"申通快递";
        [_expressArray addObject:model];
        model = [PMExpressModel new];
        model.expressName = @"中国邮政";
        [_expressArray addObject:model];
        model = [PMExpressModel new];
        model.expressName = @"韵达快递";
        [_expressArray addObject:model];
        model.expressName = @"百世快递";
        [_expressArray addObject:model];
        
    }
    return _expressArray;
}

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        DCRecommendItem *recommendItem = [[DCRecommendItem alloc] init];
        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
        recommendItem.goods_title = @"GO狗粮 抗敏美毛系列全 牧羊犬全新配方 25磅";
        recommendItem.nature = @"3.06kg  牛肉味";
        recommendItem.price = @"158";
        recommendItem.people_count = @"2";
        [_dataArray addObject:recommendItem];
        
        PMOrderSelectModel * model = [PMOrderSelectModel new];
        model.title = @"优惠券";
        model.count = @"已选1张";
        model.content = @"10元优惠券";
        [_dataArray addObject:model];
        
        model = [PMOrderSelectModel new];
        model.title = @"配送";
        model.content = @"顺丰速递";
        [_dataArray addObject:model];

//        recommendItem.image_url = @"https://img.alicdn.com/imgextra/i2/108613394/TB2mlYjm5MnBKNjSZFoXXbOSFXa_!!0-saturn_solar.jpg_210x210.jpg";
//        recommendItem.goods_title = @"GO猫粮 抗敏美毛系列全 全新包装营养配方 25磅";
//        recommendItem.nature = @"3.06kg  牛肉味";
//        recommendItem.price = @"158";
//        recommendItem.people_count = @"2";
//        [_dataArray addObject:recommendItem];
    }
    return _dataArray;
}

- (UITableView *)subTableView{
    if (_subTableView == nil) {
        _subTableView = [[UITableView alloc] init];
        UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 40)];
        UILabel *subTableTitleLabel = [[UILabel alloc] init];
        self.subTableTitleLabel = subTableTitleLabel;
        subTableTitleLabel.font = [UIFont boldSystemFontOfSize:15];
        subTableTitleLabel.text = @"选择配送";
        [headerView addSubview:subTableTitleLabel];
        
        UIButton * closeBtn = [[UIButton alloc] init];
        [closeBtn addTarget:self action:@selector(closeCover) forControlEvents:UIControlEventTouchUpInside];
        [closeBtn setImage:IMAGE(@"order_closed") forState:UIControlStateNormal];
        [headerView addSubview:closeBtn];
        [headerView sp_addBottomLineWithLeftMargin:0 rightMargin:0];
        
        [subTableTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(headerView);
        }];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(headerView);
        }];
        
        _subTableView.tableHeaderView =headerView;
                _subTableView.delegate = self;
                _subTableView.dataSource = self;
         [_subTableView registerClass:[PMCoverCell class] forCellReuseIdentifier:@"PMCoverCellID"];
        [_subTableView registerClass:[PMVoucherCell class] forCellReuseIdentifier:@"PMVoucherCellID"];
        _subTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _subTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _subTableView.backgroundColor = [UIColor whiteColor];
        _subTableView.showsVerticalScrollIndicator = NO;
    }
    return _subTableView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 49) style:UITableViewStylePlain];
        _tableView.tag = 0;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[PMConfirmOrderCell class] forCellReuseIdentifier:@"PMConfirmOrderCellID"];
        [_tableView registerClass:[PMOrderSelectCell class] forCellReuseIdentifier:@"PMOrderSelectCellID"];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.backgroundColor = kColorFAFAFA;
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}

- (PMConfirmOrderHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [[PMConfirmOrderHeaderView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 103)];
    }
    return _headerView;
}

- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 140)];
        UIView * bgView = [[UIView alloc] init];
        bgView.backgroundColor = [UIColor whiteColor];
        [_footerView addSubview:bgView];
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:16];
        titleLabel.text = @"商品金额";
        [bgView addSubview:titleLabel];
        
        UILabel * priceLabel = [[UILabel alloc] init];
        priceLabel.textAlignment = NSTextAlignmentRight;
        priceLabel.font = [UIFont boldSystemFontOfSize:16];
        priceLabel.text = @"¥158";
        [bgView addSubview:priceLabel];
        
        
        UILabel * titleLabel1 = [[UILabel alloc] init];
        titleLabel1.font = [UIFont systemFontOfSize:16];
        titleLabel1.text = @"运费";
        [bgView addSubview:titleLabel1];
        
        UILabel * priceLabel1 = [[UILabel alloc] init];
        priceLabel1.textAlignment = NSTextAlignmentRight;
        priceLabel1.font = [UIFont boldSystemFontOfSize:16];
        priceLabel1.text = @"+¥5.00";
        priceLabel1.textColor = [UIColor colorWithHexStr:@"#FF3945"];
        [bgView addSubview:priceLabel1];
        
        UILabel * titleLabel2 = [[UILabel alloc] init];
        titleLabel2.font = [UIFont systemFontOfSize:16];
        titleLabel2.text = @"优惠券";
        [bgView addSubview:titleLabel2];
        
        UILabel * priceLabel2 = [[UILabel alloc] init];
        priceLabel2.textAlignment = NSTextAlignmentRight;
        priceLabel2.font = [UIFont boldSystemFontOfSize:16];
        priceLabel2.text = @"-¥10.00";
        priceLabel2.textColor = [UIColor colorWithHexStr:@"#FF3945"];
        [bgView addSubview:priceLabel2];
        
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_footerView);
            make.top.mas_equalTo(10);
            make.height.mas_equalTo(100);
        }];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(15);
        }];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(titleLabel);
        }];
        
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(10);
        }];
        [priceLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(titleLabel1);
        }];
        
        [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(titleLabel1.mas_bottom).mas_offset(10);
        }];
        [priceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-12);
            make.centerY.mas_equalTo(titleLabel2);
        }];

        UILabel * infoLabel = [UILabel new];
        infoLabel.font = [UIFont systemFontOfSize:13];
        infoLabel.textColor = [UIColor colorWithHexStr:@"#FF3945"];
        infoLabel.text = @"交易成功可获得10积分";
        [_footerView addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(bgView.mas_bottom).mas_offset(10);
        }];
        
    }
    return _footerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.tableFooterView = self.footerView;
    [self fecthBottomView];
}


- (void)fecthBottomView{
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UILabel * totalPriceLabel = [[UILabel alloc] init];
    totalPriceLabel.textAlignment = NSTextAlignmentRight;
    totalPriceLabel.font =  [UIFont systemFontOfSize:12];
    NSString * countStr = @"合计：¥153";
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:countStr];
    [str addAttributes:@{NSForegroundColorAttributeName:kColorFF5554,NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} range:[countStr rangeOfString:@"¥153"]];
    totalPriceLabel.attributedText = str;
    [self.view addSubview:totalPriceLabel];
    
    UIButton * commitBtn = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 110, 44);
    [commitBtn.layer addSublayer:gradientLayer];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    commitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:commitBtn];
    
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.right.bottom.mas_equalTo(self.view);
    }];

    [totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commitBtn.mas_left).mas_offset(-10);
        make.left.bottom.height.mas_equalTo(bottomView);
    }];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.height.mas_equalTo(bottomView);
        make.width.mas_equalTo(110);
    }];
    
}

#pragma mark - action



#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.dataArray.count;
    }else if (tableView.tag == 1){
        return self.voucherArray.count;
    }else if(tableView.tag == 2) {
        return self.expressArray.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 0) {
        if (indexPath.row == 0) {
            PMConfirmOrderCell *  cell = [tableView dequeueReusableCellWithIdentifier:@"PMConfirmOrderCellID" forIndexPath:indexPath];
            DCRecommendItem * item = self.dataArray[indexPath.row];
            cell.item = item;
            return cell;
        }else if (indexPath.row == 1){
            PMOrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMOrderSelectCellID" forIndexPath:indexPath];
            PMOrderSelectModel * model = self.dataArray[indexPath.row];
            cell.model = model;
            return cell;
        }else if (indexPath.row == 2){
            PMOrderSelectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMOrderSelectCellID" forIndexPath:indexPath];
            PMOrderSelectModel * model = self.dataArray[indexPath.row];
            cell.model = model;
            return cell;
        }
        return nil;
    }else if (tableView.tag == 1){
        PMVoucherCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMVoucherCellID" forIndexPath:indexPath];
        cell.model = self.voucherArray[indexPath.row];
        return cell;
    }else if (tableView.tag == 2){
        PMCoverCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PMCoverCellID" forIndexPath:indexPath];
        cell.model = self.expressArray[indexPath.row];
        return cell;
    }else{
        return nil;
    }

   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        if (0 == indexPath.row) {
            return 94;
        }else{
            return 44;
        }
    }else if (tableView.tag == 1){
        return 115;
    }else if (tableView.tag == 2){
        return 40;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0) {
        if (1 == indexPath.row) {//优惠券
            self.subTableTitleLabel.text = @"选择优惠券";
            [self showCoverWithTag:indexPath.row];
        }else if (2 == indexPath.row) { //快递
            self.subTableTitleLabel.text = @"选择配送";
            [self showCoverWithTag:indexPath.row];
        }
    }else if (1 == tableView.tag){
        PMOrderSelectModel * model = self.dataArray[1];
        PMVoucherModel *  voucherModel = self.voucherArray[indexPath.row];
        voucherModel.isSelect = YES;
        for (PMVoucherModel *  model1 in self.voucherArray) {
            if (![model1 isEqual:voucherModel]) {
                model1.isSelect = NO;
            }
        }
        model.content = [NSString stringWithFormat:@"%@元优惠券",voucherModel.price];
        [self.subTableView reloadData];
        [self.tableView reloadData];
        [self performSelector:@selector(closeCover) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
        
    }else if (2 == tableView.tag){
        PMOrderSelectModel * model = self.dataArray[2];
        PMExpressModel *  expressModel = self.expressArray[indexPath.row];
        expressModel.isSelect = YES;
        for (PMExpressModel *  model1 in self.expressArray) {
            if (![model1 isEqual:expressModel]) {
                model1.isSelect = NO;
            }
        }
        model.content = expressModel.expressName;
        [self.subTableView reloadData];
        [self.tableView reloadData];
        [self performSelector:@selector(closeCover) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
    }

}

- (void)showCoverWithTag:(NSInteger )tag{
    self.coverBtn = [[STCoverView alloc] initWithSuperView:kWindow complete:^(UIView *cover) {
        [cover removeFromSuperview];
        [self.subTableView removeFromSuperview];
        self.subTableView.transform = CGAffineTransformMakeTranslation(0, 0);
    }];
    
    [self.coverBtn addSubview:self.subTableView];
    self.subTableView.tag = tag;
    [self.subTableView reloadData];
    self.subTableView.frame = CGRectMake(0, kMainBoundsHeight, kMainBoundsWidth, kMainBoundsHeight * 0.7);
    [UIView animateWithDuration:0.3 animations:^{
        self.subTableView.transform = CGAffineTransformMakeTranslation(0, -kMainBoundsHeight * 0.7);
    }];
}

- (void)closeCover{
    [self.coverBtn removeFromSuperview];
    [self.subTableView removeFromSuperview];
    self.subTableView.transform = CGAffineTransformMakeTranslation(0, 0);
}

- (void)commitBtnClick{
    PMConfirmPayViewController * vc = [[PMConfirmPayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
