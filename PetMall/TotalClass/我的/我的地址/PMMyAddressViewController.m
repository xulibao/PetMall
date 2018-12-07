//
//  PMMyAddressViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyAddressViewController.h"
#import "PMAddNewAddressViewController.h"
#import "YWAddressDataTool.h"
@interface PMMyAddressViewController ()<PMMyAddressCellDelegate>
@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMMyAddressViewController

- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[YWAddressDataTool sharedManager] requestGetData];
    self.title = @"我的地址";
    [self fetchData];
    self.tableView.mj_header.hidden = YES;
    self.viewModel.cellDelegate = self;
}

- (void)refreshingAction {
    [self fetchData];
}

- (void)initSubviews{
    [super initSubviews];
    
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
    NSString * str = @"+ 添加新地址";
    NSMutableAttributedString * addressAtt = [[NSMutableAttributedString alloc] initWithString:str];
    [addressAtt addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:23]} range:[str rangeOfString:@"+"]];
    [addressAtt addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, str.length)];
    [addAddressBtn setAttributedTitle:addressAtt forState:UIControlStateNormal];
//        [addAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
//        [addAddressBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [addAddressBtn setImage:IMAGE(@"mine_address_add") forState:UIControlStateNormal];
//    addAddressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 13, 0, 0);
    [addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.centerX.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(290, 44));
    }];
}
- (void)addAddressBtnClick{
    PMAddNewAddressViewController * vc = [[PMAddNewAddressViewController alloc] init];
    vc.addressBlock = ^(PMMyAddressItem *model) {
        model.zt = YES;
        NSMutableDictionary *dict = [model mj_keyValuesWithKeys:@[@"user_phone",@"user_name",@"user_address",@"user_add",@"zt"]];
        [dict setObject:[SAApplication userID] forKey:@"user_id"];
        [self requestPOST:API_user_address parameters:dict success:^(__kindof SARequest *request, id responseObject) {
        [self showSuccess:@"添加地址成功"];
        if (model.zt) {
            for (PMMyAddressItem *model in self.dataArray) {
                model.zt = NO;
            }
        }
        [self.dataArray addObject:model];
        [self setItems:self.dataArray];
    } failure:NULL];
    };
    [self pushViewController:vc];

}
- (void)PMMyAddressCellEdit:(id)item{
    PMMyAddressItem * addressItem = (PMMyAddressItem *)item;
    NSInteger  index = [self.dataArray indexOfObject:addressItem];
    PMAddNewAddressViewController * vc = [[PMAddNewAddressViewController alloc] init];
    vc.model = addressItem;
    vc.deleteAddress = ^{
        [self requestPOST:API_user_deladdress parameters:@{@"user_id":[SAApplication userID],@"id":addressItem.address_id} success:^(__kindof SARequest *request, id responseObject) {
            [self showSuccess:@"删除地址成功"];
            [self.dataArray removeObjectAtIndex:index];
            [self setItems:self.dataArray];
        } failure:NULL];
    };
    vc.addressBlock = ^(PMMyAddressItem *model) {
        NSMutableDictionary *dict = [model mj_keyValuesWithKeys:@[@"user_id",@"user_phone",@"user_name",@"user_address",@"user_add",@"zt"]];
        [dict setObject:model.address_id forKey:@"address_id"];
        [self requestPOST:API_user_addressdel parameters:dict success:^(__kindof SARequest *request, id responseObject) {
            [self showSuccess:@"编辑地址成功"];
            if (model.zt) {
                for (PMMyAddressItem *item in self.dataArray) {
                    item.zt = NO;
                }
                model.zt = YES;
            }
            [self.dataArray replaceObjectAtIndex:index withObject:model];
            [self setItems:self.dataArray];
        } failure:NULL];
    };
    [self pushViewController:vc];
}

#pragma mark - Request

- (void)fetchData {
    
    [self requestMethod:GARequestMethodPOST URLString:API_user_useraddress parameters:@{@"user_id":[SAApplication userID]} resKeyPath:@"result" resArrayClass:[PMMyAddressItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        self.dataArray = responseObject;
        [self setItems:self.dataArray];

    } failure:NULL];
//    PMMyAddressItem * item = [PMMyAddressItem new];
//    item.nameStr = @"张三";
//    item.detailAddress = @"沂蒙路与涑河南街交汇处西净雅新天地1号楼C座3楼";
//    item.areaAddress = @"山东省临沂市兰山区";
//    item.phoneStr = @"18369720486";
//    item.zt = YES;
//    [self.dataArray addObject:item];
//
//    item = [PMMyAddressItem new];
//    item.nameStr = @"李四";
//    item.detailAddress = @"沂蒙路与涑河南街交汇处西净雅新天地1号楼C座3楼";
//    item.areaAddress = @"山东省临沂市兰山区";
//    item.phoneStr = @"18369720486";
//    item.zt = NO;
//    [self.dataArray addObject:item];
//
//    item = [PMMyAddressItem new];
//    item.nameStr = @"王二";
//    item.detailAddress = @"沂蒙路与涑河南街交汇处西净雅新天地1号楼C座3楼";
//    item.areaAddress = @"山东省临沂市兰山区";
//    item.phoneStr = @"18369720486";
//    item.zt = NO;
//    [self.dataArray addObject:item];

}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    if (self.callBack) {
        self.callBack(item);
    }
}

@end
