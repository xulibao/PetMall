//
//  PMConfirmPayViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/12.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMConfirmPayViewController.h"
#import "SAWithdrawalsCell.h"
#import "STCommonTableViewModel.h"
#import "PMPayResultViewController.h"
@interface PMConfirmPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) STCommonTableViewModel *viewModel;
@property(nonatomic, copy) NSString *payType;
@property(nonatomic, strong) UILabel *moneyTextField;
@property(nonatomic, strong) UIButton *footView1;
@end

@implementation PMConfirmPayViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.title = @"确认支付";
    [self fetchHeaderView];
    [self fetchFooterView];
    self.viewModel = [[STCommonTableViewModel alloc] initWithTableView:self.tableView];
    self.viewModel.tableViewDelegate = self;
    SAWithdrawalsModel * item = [[SAWithdrawalsModel alloc] init];
    item.bankLogo = @"order_weixin";
    item.bankName = @"微信支付";
    item.bankAccount = @"微信安全支付";
    [self.viewModel addRow:item];
    
    item = [[SAWithdrawalsModel alloc] init];
    item.bankLogo = @"order_zhifubao";
    item.bankName = @"支付宝支付";
    item.bankAccount = @"支付宝安全支付";
    [self.viewModel addRow:item];
}

- (void)fetchHeaderView{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    bgView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = bgView;
    UILabel * textField = [[UILabel alloc] init];
    NSString * countStr = @"需支付 154.00";
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:countStr];
    [str addAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexStr:@"#FF3945"]} range:[countStr rangeOfString:@"154.00"]];
    textField.attributedText = str;
    self.moneyTextField = textField;
    textField.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:textField];
    
 
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(bgView);
    }];
    
  
}

- (void)fetchFooterView{

    UIButton * footView = [[UIButton alloc] init];
    [self.view addSubview:footView];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, kMainBoundsWidth, 44);
    [footView.layer addSublayer:gradientLayer];
    footView.titleLabel.font = [UIFont systemFontOfSize:16];
    [footView setTitle:@"确认支付" forState:UIControlStateNormal];
    [footView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addTarget:self action:@selector(footBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 44)];
    bgView.backgroundColor = kColorFAFAFA;
    UILabel * label = [[UILabel alloc] init];
    label.textColor = kColor999999;
    label.text = @"选择支付方式";
    label.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:label];
    [bgView sp_addBottomLineWithLeftMargin:0 rightMargin:0];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.mas_equalTo(bgView);
    }];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SAWithdrawalsModel * selectModel = (SAWithdrawalsModel *)[self.viewModel objectAtIndexPath:indexPath];
    selectModel.isSelect = !selectModel.isSelect;
    if (selectModel.isSelect) {
        self.payType = [@(indexPath.row + 1) stringValue];
    }
    for (SAWithdrawalsModel * model in [self.viewModel rowsAtSection:0]) {
        if (![selectModel isEqual:model]) {
            if (selectModel.isSelect) {
                model.isSelect = !selectModel.isSelect ;
            }
        }
    }
    [self.tableView reloadData];
    
}
//从余额中查看
- (void)footBtnClick1{
//    SAMyWalletViewController * vc = [[SAMyWalletViewController alloc] init];
//    [self pushViewController:vc];
    
}

- (void)footBtnClick{
    [self.view endEditing:YES];
 

 
        if (0 == [self.payType integerValue]) {
            [self showWaring:@"请选择一种支付方式"];
            return;
        }
        if (1 == [self.payType integerValue]) { //微信
            [self rechargeOrPaySuccess];
//            if ([WXApi isWXAppInstalled] == NO) {
//                [self showErrow:@"您没有安装微信客户端，建议您使用支付宝支付"];
//                return;
//            }
//            SAWXPayRequest *wxRequest = [[SAWXPayRequest alloc] init];
//            wxRequest.userId = [SAApplication userID];
//            wxRequest.payType = self.payType;
//            wxRequest.money = self.moneyTextField.text;
//            wxRequest.shouldDisplayRetryView = YES;
//            wxRequest.shouldDisplayLoadingView = YES;
//            [wxRequest addAccessory:self];
//
//            [wxRequest startWithCompletionBlockWithSuccess:^(__kindof SAWXPayRequest *request) {
//                __weak typeof(self)weakSelf = self;
//                [[WXPayClient shareInstance] payByWeiXinDict:request.responseObject];
//                [WXPayClient shareInstance].wxPaySucessedCallBack = ^(){
//                    __strong typeof(weakSelf)strongSelf = weakSelf;
//                    [strongSelf rechargeOrPaySuccess];
//                };
//                [WXPayClient shareInstance].wxPayAilFieldBlock = ^(NSString *fieldStr){
//                    __strong typeof(weakSelf)strongSelf = weakSelf;
//                    [strongSelf showErrow:fieldStr];
//                    [self showErrow:fieldStr];
//                };
//
//            } failure:NULL];
            
        }else if (2 == [self.payType integerValue]) { //支付宝
            [self rechargeOrPaySuccess];
//            [self requestMethod:GARequestMethodGET URLString:API_recharge_getRechargeAndCallback parameters:@{@"userId":[SAApplication userID],@"payType":self.payType,@"money":self.moneyTextField.text} resKeyPath:@"data" resClass:[SAAlipayToolModel class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
//                __weak typeof(self)weakSelf = self;
//                [[SAAlipayTool sharedSAAlipayTool] payByAilPay:responseObject];
//                [SAAlipayTool sharedSAAlipayTool].ailPaySucessedCallBack = ^(){
//                    __strong typeof(weakSelf)strongSelf = weakSelf;
//                    [strongSelf rechargeOrPaySuccess];
//
//                };
//                [SAAlipayTool sharedSAAlipayTool].ailPayAilFieldBlock = ^(NSString *fieldStr){
//                    __strong typeof(weakSelf)strongSelf = weakSelf;
//                    //            [self paySucess:NO failReason:@"取消支付"];
//                    [strongSelf showErrow:fieldStr];
//                };
//
//            } failure:NULL];
        }
    }

// 充值或支付完成
- (void)rechargeOrPaySuccess{
    PMPayResultViewController * vc = [[PMPayResultViewController alloc] init];
    [self pushViewController:vc];
}
- (void)payment{
//    [self requestGET:API_video_payOrder parameters:@{@"vaId":self.vaId,@"lotId":self.lotId,@"userId":[SAApplication userID]} success:^(__kindof SARequest *request, id responseObject) {
//        SAAlertController *alertController = [SAAlertController alertControllerWithTitle:nil
//                                                                                 message:@"视频服务费已从余额中扣除，请准时等待检测师发起视频"
//                                                                          preferredStyle:SAAlertControllerStyleAlert];
//        SAAlertAction *action = [SAAlertAction actionWithTitle:@"确定" style:SAAlertActionStyleDefault handler:^(SAAlertAction *action) {
//            if (self.reloadCallBack) {
//                self.reloadCallBack();
//            }
//            if (self.actionCallBack) {
//                self.actionCallBack();
//            }
//        }];
//        [alertController addAction:action];
//        [alertController showWithAnimated:YES];
//
//    } failure:NULL];
}
@end
