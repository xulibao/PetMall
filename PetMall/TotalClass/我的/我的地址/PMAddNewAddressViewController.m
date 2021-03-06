//
//  PMAddNewAddressViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMAddNewAddressViewController.h"
#import "YWAddressTableViewCell1.h"
#import "YWAddressTableViewCell2.h"
#import "YWAddressTableViewCell3.h"
#import <ContactsUI/ContactsUI.h>
#import "YWChooseAddressView.h"
#import "YWAddressDataTool.h"
#import "YWTool.h"
#define CELL_IDENTIFIER1     @"YWAddressTableViewCell1"
#define CELL_IDENTIFIER2     @"YWAddressTableViewCell2"
#define CELL_IDENTIFIER3     @"YWAddressTableViewCell3"
@interface PMAddNewAddressViewController ()<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate,UIGestureRecognizerDelegate, CNContactViewControllerDelegate, CNContactPickerDelegate>
@property (nonatomic, strong) UITableView         * tableView;
@property (nonatomic, strong) NSArray             * dataSource;
@property (nonatomic, strong) UITextView          * detailTextViw;

@property (nonatomic,strong) YWChooseAddressView  * chooseAddressView;
@property (nonatomic,strong) UIView               * coverView;

@property (nonatomic, strong) UILabel             * promptLable;
- (void)initUserInterface;  /**< 初始化用户界面 */
- (void)initUserDataSource;  /**< 初始化数据源 */
@end

@implementation PMAddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColorFAFAFA;
    [self initUserDataSource];
    [self initUserInterface];
    [self initBottomView];
  
}

- (void)editRightBtn{
    UIButton * rightBtn = [[UIButton alloc] init];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitle:@"删除" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(editBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:kColorFF5554 forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}
- (void)editBtnClick{
    if (self.deleteAddress) {
        self.deleteAddress();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initBottomView{
    UIButton * addAddressBtn = [UIButton new];
    [self.view addSubview:addAddressBtn];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexStr:@"#FF3945"].CGColor, (__bridge id)[UIColor colorWithHexStr:@"#F63677"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = CGRectMake(0, 0, 290, 44);
    gradientLayer.cornerRadius = 22;
    [addAddressBtn.layer addSublayer:gradientLayer];
    
    addAddressBtn.titleLabel.font = [UIFont systemFontOfSize:15];
            [addAddressBtn setTitle:@"保存" forState:UIControlStateNormal];
            [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addAddressBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).mas_offset(30);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(290, 44));
    }];
}

- (void)initUserInterface {
    
    self.title = @"添加新地址";
    if (_model) {
        self.title = @"编辑地址";
        [self editRightBtn];
    } else {
        _model = [[PMMyAddressItem alloc] init];
        _model.user_address = @"请选择";
    }
    
    //监听所有的textView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewPlaceholder) name:UITextViewTextDidChangeNotification object:nil];
    
    [self.view addSubview:self.tableView];
    [kWindow addSubview:self.coverView];
    
}


- (void)initUserDataSource {
    
    _dataSource = @[@[@"收货人", @"手机号码", @"所在地区"],
                    @[@"设为默认地址"]];
}

#pragma mark -- action

//*** 保存按钮 ***
- (void)saveBtnClick{
    YWAddressTableViewCell1 *nameCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    YWAddressTableViewCell1 *phoneCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    YWAddressTableViewCell3 *defaultCell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    
    _model.user_name = nameCell.textField.text;
    _model.user_phone = phoneCell.textField.text;
    _model.user_add = _detailTextViw.text;
    _model.user_address = _chooseAddressView.address;
    if (defaultCell) {
        _model.zt = defaultCell.rightSwitch.isOn;
    }
    
    if (_model.user_name.length == 0) {
        [self showWaring:@"请填写收货人姓名！"];
        return;
    } else if (_model.user_phone.length == 0) {
        [self showWaring:@"请填写收货人电话！"];
        return;
    } else if (_model.user_phone.length != 11) {
        [self showWaring:@"手机号为11位，如果为座机请加上区号"];
        return;
    } else if ([_model.user_address isEqualToString:@"请选择"]) {
         [self showWaring:@"请选择所在地区"];
        return;
    } else if (_model.user_add.length == 0 || _model.user_add.length < 5) {
        [self showWaring:@"请填写详细地址，不少与5字"];

        return;
    }
    
    // 回调所填写的地址信息（姓名、电话、地址等等）
    if (self.addressBlock) {
        self.addressBlock(_model);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// textView 水印字体
- (void)textViewPlaceholder {
    self.promptLable.hidden = self.detailTextViw.text.length > 0 ? 1 : 0;
}

#pragma mark *** 弹出选择地区视图 ***
- (void)chooseAddress {
    [self.view endEditing:YES];
    @weakify(self)
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        @strongify(self);
        self.coverView.frame = CGRectMake(0, 0, kMainBoundsWidth, kMainBoundsHeight);
        self.chooseAddressView.hidden = NO;
    } completion:^(BOOL finished) {
        // 动画结束之后添加阴影
        self.coverView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseAddressView.frame, point)){
        return NO;
    }
    return YES;
}


- (void)tapCover:(UITapGestureRecognizer *)tap {
    if (_chooseAddressView.chooseFinish) {
        _chooseAddressView.chooseFinish();
    }
}

#pragma mark *** 从通讯录选择联系人 电话 & 姓名 ***
//用户点击 加号按钮 - 选择联系人
- (void)selectContactAction {
    // 弹出联系人列表 - 此方法只使用于 iOS 9.0以后
    CNContactPickerViewController * pickerVC = [[CNContactPickerViewController alloc]init];
    pickerVC.navigationItem.title = @"选择联系人";
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

//这个方法在用户取消选择时调用
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - CNContactPickerDelegate
// 这个方法在用户选择一个联系人后调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    // 1.获取姓名
    NSString *firstname = contact.givenName;
    NSString *lastname = contact.familyName;
    NSLog(@"%@%@", lastname, firstname);
    
    //通过姓名寻找联系人
    NSMutableString *fullName = [[NSMutableString alloc] init];
    if ( lastname != nil || lastname.length > 0 ) {
        [fullName appendString:lastname];
    }
    if ( firstname != nil || firstname.length > 0 ) {
        [fullName appendString:firstname];
    }
    
    // 2.获取电话号码
    NSArray *phones = contact.phoneNumbers;
    NSMutableArray *phoneNumbers = [NSMutableArray array];
    // 3.遍历电话号码
    for (CNLabeledValue *labelValue in phones) {
        CNPhoneNumber *phoneNumber = labelValue.value;
        //把 -、+86、空格 这些过滤掉
        NSString *phoneStr = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        [phoneNumbers addObject:phoneStr];
    }
    
    NSLog(@"选择的姓名：%@， 电话号码：%@", fullName, phoneNumbers.firstObject);
    _model.user_name = fullName;
    // 这里直接取第一个电话号码，如果有多个请自行添加选择器
    _model.user_phone = phoneNumbers.firstObject;
    [_tableView reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark *** UITableViewDataSource & UITableViewDelegate ***
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_model.zt) {
        // 如果该地址已经是默认地址，则无需再显示 "设为默认" 这个按钮，即隐藏
        return 1;
    }
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    if (indexPath.section == 0) {
        if (indexPath.row < 2) {
            YWAddressTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER1 forIndexPath:indexPath];
            cell.rightBtn.hidden = YES;
            cell.placehodlerStr = @"填写收货人姓名";
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.leftStr = _dataSource[indexPath.section][indexPath.row];
            if (_model.user_name.length > 0) {
                cell.textFieldStr = _model.user_name;
            }
            if (indexPath.row == 1) {
                cell.rightBtn.hidden = NO;
                cell.placehodlerStr = @"填写收货人电话";
                cell.textField.keyboardType = UIKeyboardTypePhonePad;
                if (_model.user_phone.length > 0) {
                    cell.textFieldStr = _model.user_phone;
                }
                cell.contactBlock = ^{
                    @strongify(self);
                    [self selectContactAction];
                };
            }
            return cell;
        } else {
            YWAddressTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER2 forIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            [cell sp_addBottomLineWithLeftMargin:0 rightMargin:0];
            cell.leftStr = _dataSource[indexPath.section][indexPath.row];
            cell.rightStr = _model.user_address;
            if (![_model.user_address isEqualToString:@""] && ![_model.user_address isEqualToString:@"请选择"]) {
                cell.rightLabel.textColor = [UIColor blackColor];
            } else {
                cell.rightLabel.textColor = [UIColor lightGrayColor];
            }
            return cell;
        }
    } else {
        YWAddressTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER3 forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.leftStr = _dataSource[indexPath.section][indexPath.row];
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footerView = [[UIView alloc] init];
        footerView.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 65, 15)];
        [footerView addSubview:label];
        label.text = @"详细地址";
        label.font = [UIFont systemFontOfSize:15];
        [footerView addSubview:label];
        [footerView addSubview:self.detailTextViw];
        
        UIView * view= [[UIView alloc] init];
        view.backgroundColor =kColorFAFAFA;
        [footerView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(footerView);
            make.height.mas_equalTo(10);
        }];
        return footerView;
    } else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 90;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 取消cell选中效果
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 2) {
        // 选择地区
        [self chooseAddress];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kMainBoundsWidth,300) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kColorFAFAFA;
        _tableView.rowHeight = 50;
        _tableView.tableFooterView = nil;
        // 设置分割线
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
        // 注册cell
        [_tableView registerNib:[UINib nibWithNibName:CELL_IDENTIFIER1 bundle:nil] forCellReuseIdentifier:CELL_IDENTIFIER1];
        [_tableView registerNib:[UINib nibWithNibName:CELL_IDENTIFIER2 bundle:nil] forCellReuseIdentifier:CELL_IDENTIFIER2];
        [_tableView registerNib:[UINib nibWithNibName:CELL_IDENTIFIER3 bundle:nil] forCellReuseIdentifier:CELL_IDENTIFIER3];
    }
    return _tableView;
}

- (UITextView *)detailTextViw {
    if (!_detailTextViw) {
        _detailTextViw = [[UITextView alloc] initWithFrame:CGRectMake(95, 1, kMainBoundsWidth - 95, 80)];
        _detailTextViw.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 15);
        _detailTextViw.font = [UIFont systemFontOfSize:14];
        [_detailTextViw addSubview:self.promptLable];
        if (_model.user_add.length > 0) {
            _detailTextViw.text = _model.user_add;
            self.promptLable.hidden = YES;
        }
    }
    return _detailTextViw;
}

- (UILabel *)promptLable {
    if (!_promptLable) {
        _promptLable = [[UILabel alloc] initWithFrame:CGRectMake(0 , 5, kMainBoundsWidth, 24)];
        _promptLable.text = @"街道、楼牌号等";
        _promptLable.numberOfLines = 0;
        _promptLable.textColor = RGBA(200, 200, 200, 1);
        _promptLable.textAlignment = NSTextAlignmentJustified;
        [_promptLable setFont:[UIFont systemFontOfSize:14]];
    }
    return _promptLable;
}

- (YWChooseAddressView *)chooseAddressView {
    if (!_chooseAddressView) {
        @weakify(self);
        _chooseAddressView = [[YWChooseAddressView alloc]initWithFrame:CGRectMake(0, kMainBoundsHeight - 350, kMainBoundsWidth, 350)];
        if ([_model.user_address isKindOfClass:[NSNull class]] || [_model.user_address isEqualToString:@""]) {
            _model.user_address = @"请选择";
        }
        
        _chooseAddressView.address = _model.user_address;
        _chooseAddressView.closed = ^{
            @strongify(self)
            self.coverView.backgroundColor = [UIColor clearColor];
            NSLog(@"选择的地区为：%@", self.chooseAddressView.address);
            self.model.user_address = self.chooseAddressView.address;
            if (self.model.user_address.length == 0) {
                self.model.user_address = @"请选择";
            }
            [self.tableView reloadData];
            // 隐藏视图 - 动画
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.coverView.frame = CGRectMake(0, kMainBoundsHeight, kMainBoundsWidth, kMainBoundsHeight);
                self.chooseAddressView.hidden = NO;
            } completion:nil];
        };
        _chooseAddressView.chooseFinish = ^{
            @strongify(self)
            self.coverView.backgroundColor = [UIColor clearColor];
            NSLog(@"选择的地区为：%@", self.chooseAddressView.address);
            self.model.user_address = self.chooseAddressView.address;
            if (self.model.user_address.length == 0) {
                self.model.user_address = @"请选择";
            }
            [self.tableView reloadData];
            // 隐藏视图 - 动画
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.coverView.frame = CGRectMake(0, kMainBoundsHeight, kMainBoundsWidth, kMainBoundsHeight);
                self.chooseAddressView.hidden = NO;
            } completion:nil];
        };
    }
    return _chooseAddressView;
}

- (UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, kMainBoundsHeight, kMainBoundsWidth, kMainBoundsHeight)];
        [_coverView addSubview:self.chooseAddressView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCover:)];
        [_coverView addGestureRecognizer:tap];
        tap.delegate = self;
    }
    return _coverView;
}


@end
