//
//  SPForgotPasswordViewController.m
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/14.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "SPForgotPasswordViewController.h"
#import "SPVerificationBaseCell.h"
#import "SPVerificationBaseModel.h"
#import "STCommonTableViewModel.h"
#import "STHelpTools.h"
#import "SPCodeForgotModel.h"
#import "SPCodeForgotCell.h"
@interface SPForgotPasswordViewController ()<SPVerificationBaseCellDelegate,SPCodeForgotCellDelegate>

@property(nonatomic, strong) STCommonTableViewModel *viewModel;
@property (nonatomic,strong) UIButton * footView;//底部登录控件

@end

@implementation SPForgotPasswordViewController

- (STCommonTableViewModel *)viewModel{
    if (_viewModel == nil) {
        _viewModel = [[STCommonTableViewModel alloc] initWithTableView:self.tableView];
        _viewModel.cellDelegate = self;
        SPVerificationBaseModel *model = [[SPVerificationBaseModel alloc] init];
        model.cellIdentifier = @"loginTelCellIdentifier";
        model.feildPlace = @"手机号";
        model.severKey = @"mobile";
        model.maxNumber = 11;
        model.showType = kVerificationShowForHidden;
        model.keyBoardType = UIKeyboardTypeNumberPad;
        SAPhoneNumberInputHandle * handle= [[SAPhoneNumberInputHandle alloc] init];
        model.handle = handle;
        [_viewModel addRow:model];
        model = [[SPVerificationBaseModel alloc] init];

        model = [[SPVerificationBaseModel alloc] init];
        model.cellIdentifier = @"loginCodeCellIdentifier";
        model.imageName = @"me_password";
        model.severKey = @"code";
        model.feildPlace = @"验证码";
        model.showType = kVerificationShowForShow;
        SATextFieldInputValidHandle * handle1= [[SATextFieldInputValidHandle alloc] init];
        handle1.maxLength = 4;
        model.handle = handle1;
        model.keyBoardType = UIKeyboardTypeNumberPad;
        [_viewModel addRow:model];
        
        model = [[SPVerificationBaseModel alloc] init];
        model.cellIdentifier = @"registerCodeCellIdentifier";
        model.imageName = @"me_password";
        model.severKey = @"newPassword";
        model.feildPlace = @"新密码";
        model.isAddTimer = YES;
        model.isCiphertext = YES;
        model.isShowCiphertext = YES;
        handle1= [[SATextFieldInputValidHandle alloc] init];
        handle1.inputRegex = @"^[A-Za-z0-9]{0,6}$";
        model.handle = handle1;
        model.showType = kVerificationShowForHidden;
        model.keyBoardType = UIKeyboardTypeASCIICapable;
        [_viewModel addRow:model];
        
        model = [[SPVerificationBaseModel alloc] init];
        model.cellIdentifier = @"registerCodeCellIdentifier";
        model.imageName = @"me_password";
        model.severKey = @"confirmPassword";
        model.feildPlace = @"再次输入新密码";
        model.isShowCiphertext = YES;
        model.isAddTimer = YES;
        model.isCiphertext = YES;
        handle1= [[SAChineseIDCardInputHandle alloc] init];
        handle1.inputRegex = @"^[A-Za-z0-9]{0,6}$";
        model.handle = handle1;
        model.showType = kVerificationShowForHidden;
        model.keyBoardType = UIKeyboardTypeASCIICapable;
        [_viewModel addRow:model];
    }
    return _viewModel;
}

- (void)initTableView {
    [super initTableView];
    self.title = @"找回密码";
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = kColorFAFAFA;
    self.view.backgroundColor = kColorFAFAFA;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self fecthHeaderView];
    [self fetchFooterView];
    if (@available(iOS 11, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.dataSource = self.viewModel;
    [self.tableView reloadData];
}

- (void)layoutTableView{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right. mas_equalTo(self.view);
    }];
}

- (void)fecthHeaderView{
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth - 30, 20)];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = kColorFAFAFA;
    self.tableView.tableHeaderView = bgView;
    
}

- (void)fetchFooterView{
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 290, 44)];
    bgView.backgroundColor = kColorFAFAFA;
    self.tableView.tableFooterView = bgView;
    self.footView = [[UIButton alloc] init];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
     gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [self.footView.layer addSublayer:gradientLayer];
    [bgView addSubview:self.footView];
    self.footView.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.footView setTitle:@"更改密码" forState:UIControlStateNormal];
    [self.footView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.footView addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
   
    [self.footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView); make.top.mas_equalTo(bgView).mas_offset(20);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
    }];
}

-(void)loginClick{
    [self.view endEditing:YES];
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSArray * array = [self.viewModel rowsAtSection:0];
    for (id model in array) {
        if ([model isKindOfClass:[SPVerificationBaseModel class]]) {
            SPVerificationBaseModel *baseModel =  (SPVerificationBaseModel *)model;
            if (0 == [baseModel.severValue length]) {
                [self showWaring:[NSString stringWithFormat:@"请输入%@！",baseModel.feildPlace]];
                return;
            }
            [dict setObject:baseModel.severValue forKey:baseModel.severKey];
        }else if([model isKindOfClass:[SPCodeForgotModel class]]){
            SPCodeForgotModel *forgotModel =  (SPCodeForgotModel *)model;
            if (forgotModel.companyId.length == 0) {
                [self showWaring:@"请选择所属公司"];
                return;
            }
            [dict setObject:forgotModel.companyId forKey:@"companyId"];
            [dict setObject:forgotModel.managerPhone forKey:@"mobile"];
        }
    }
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
    
        [self showSuccess:@"发送成功"];
        [codeModel startCountDown];
    
}

@end
