//
//  SPRegisterViewController.m
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/8.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "SPRegisterViewController.h"
#import "STCommonTableViewModel.h"
#import "SPInputMsgBaseCell.h"
#import "SPVerificationBaseModel.h"
#import "SPVerificationBaseCell.h"
@interface SPRegisterViewController ()<UITableViewDelegate,UITableViewDataSource,SPVerificationBaseCellDelegate>

@property(nonatomic, strong) STCommonTableViewModel *viewModel;
@property(nonatomic, strong) NSMutableDictionary *parametersDict;
@end

@implementation SPRegisterViewController

- (void)layoutTableView{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right. mas_equalTo(self.view);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.tableView.separatorStyle =NO;
    self.tableView.backgroundColor = kColorFAFAFA;
    self.viewModel = [[STCommonTableViewModel alloc] initWithTableView:self.tableView];
    self.viewModel.tableViewDelegate = self;
    self.viewModel.cellDelegate = self;
    SATextFieldInputValidHandle * handle= [[SATextFieldInputValidHandle alloc] init];
    SPVerificationBaseModel *model = [[SPVerificationBaseModel alloc] init];
    model.cellIdentifier = @"loginTelCellIdentifier";
    model.feildPlace = @"手机号";
    model.errorStr = @"请输入手机号";
    model.severKey = @"user_phone";
    model.maxNumber = 11;
    model.showType = kVerificationShowForHidden;
    model.keyBoardType = UIKeyboardTypeNumberPad;
    SAPhoneNumberInputHandle * handle1= [[SAPhoneNumberInputHandle alloc] init];
    model.handle = handle1;
    [_viewModel addRow:model];
    
    model = [[SPVerificationBaseModel alloc] init];
    model.cellIdentifier = @"loginCodeCellIdentifier";
    model.imageName = @"me_password";
    model.severKey = @"ver_yz";
    model.errorStr = @"请输入验证码";
    model.feildPlace = @"验证码";
    model.showType = kVerificationShowForShow;
    handle= [[SATextFieldInputValidHandle alloc] init];
    handle.maxLength = 6;
    model.handle = handle;
    model.keyBoardType = UIKeyboardTypeNumberPad;
    [self.viewModel addRow:model];
    
    
    model = [[SPVerificationBaseModel alloc] init];
    model.cellIdentifier = @"registerCodeCellIdentifier";
    model.imageName = @"me_password";
    model.severKey = @"user_password";
    model.feildPlace = @"新密码";
    model.errorStr = @"请输入新密码";
    model.isAddTimer = YES;
    model.isCiphertext = YES;
    model.isShowCiphertext = YES;
    handle= [[SATextFieldInputValidHandle alloc] init];
    handle.inputRegex = @"^[A-Za-z0-9]{0,6}$";
    model.handle = handle;
    model.showType = kVerificationShowForHidden;
    model.keyBoardType = UIKeyboardTypeASCIICapable;
    [self.viewModel addRow:model];
    [self fectchHeaderView];
    [self fecthFooterView];
}

- (void)fectchHeaderView{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 25)];
    view.backgroundColor = kColorFAFAFA;
    self.tableView.tableHeaderView = view;
}

- (void)fecthFooterView{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth, 110)];
    bgView.backgroundColor = kColorFAFAFA;
    self.tableView.tableFooterView = bgView;
    
    UIButton * footView = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [footView.layer addSublayer:gradientLayer];
    [bgView addSubview:footView];
    footView.titleLabel.font = [UIFont systemFontOfSize:18];
    [footView setTitle:@"注册" forState:UIControlStateNormal];
    [footView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addTarget:self action:@selector(registerClick) forControlEvents:UIControlEventTouchUpInside];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView); make.top.mas_equalTo(bgView).mas_offset(20);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
    }];

}
// 注册
- (void)registerClick{
    NSMutableDictionary * parametersDict = [NSMutableDictionary dictionary];
    self.parametersDict = parametersDict;
    for (id object in [self.viewModel rowsAtSection:0]) {
        if ([object isKindOfClass:[SPVerificationBaseModel class]]){
            SPVerificationBaseModel *model = (SPVerificationBaseModel *)object;
            if (model.severValue.length == 0) {
                [self showWaring:model.errorStr];
                return;
            }
            [parametersDict setObject:model.severValue forKey:model.severKey];
        }
    }
    [self requestPOST:API_user_regist parameters:parametersDict success:^(__kindof SARequest *request, id responseObject) {
//        PMAdorViewController * vc = [PMAdorViewController new];
//        [self pushViewController:vc];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self showSuccess:@"注册成功"];
    } failure:NULL];
    
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return 60;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - SAVerificationBaseCellDelegate

- (void)cellDidClickSendMessageCode:(SPVerificationBaseCell *)cell {
      [self.view endEditing:YES];
    //手机号cell
    SPVerificationBaseModel * telModel = (SPVerificationBaseModel *)[self.viewModel objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //验证码cell
    SPVerificationBaseModel *codeModel = (id)[self.viewModel objectWithCell:cell];
    if (telModel.severValue.length == 0) {
        [self showWaring:@"请输入手机号"];
        return;
    }
    
    [self requestPOST:API_user_sendRegistCode parameters:@{@"user_phone":telModel.severValue} success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"发送成功"];
        [codeModel startCountDown];
    } failure:NULL];
   
    

}


@end
