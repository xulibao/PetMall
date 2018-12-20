//
//  PMSetViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSetViewController.h"
#import "PMSetItem.h"
#import "SPForgotPasswordViewController.h"
#import "PMContactUsViewController.h"
#import "PMSendCommentViewController.h"
#import "PMBaseWebViewController.h"
@interface PMSetViewController ()


@property(nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation PMSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self fetchData];
    self.tableView.mj_header.hidden = YES;
}
- (void)initSubviews {
    [super initSubviews];
    [self fecthFooterView];
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
    [footView setTitle:@"退出" forState:UIControlStateNormal];
    [footView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footView addTarget:self
                action:@selector(signOut)
      forControlEvents:UIControlEventTouchUpInside];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(bgView); make.top.mas_equalTo(bgView).mas_offset(20);
        make.width.mas_equalTo(290);
        make.height.mas_equalTo(44);
    }];
    
}

-(void)signOut{
    [[SAApplication sharedApplication] signOut];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)fetchData {
    self.dataArray = [NSMutableArray array];
    PMSetItem * recommendItem = [PMSetItem new];
   
    recommendItem.title = @"修改密码";
    recommendItem.itemSelect = ^{
        if ([SAApplication userID] == nil) {
            [self showWaring:@"请先登录"];
            return;
        }
        SPForgotPasswordViewController * vc = [[SPForgotPasswordViewController alloc] init];
        [self pushViewController:vc];
    };
    [_dataArray addObject:recommendItem];
    
    recommendItem = [PMSetItem new];
    recommendItem.title = @"联系我们";
    recommendItem.itemSelect = ^{
        if ([SAApplication userID] == nil) {
            [self showWaring:@"请先登录"];
            return;
        }
        PMContactUsViewController * vc = [PMContactUsViewController new];
        [self pushViewController:vc];
    };
    [_dataArray addObject:recommendItem];
    
    recommendItem = [PMSetItem new];
    recommendItem.title = @"关于我们";
    recommendItem.itemSelect = ^{
        [self requestPOST:API_user_aboutus parameters:nil success:^(__kindof SARequest *request, id responseObject) {
            PMBaseWebViewController * vc = [[PMBaseWebViewController alloc] init];
            vc.webTitle = @"关于我们";
            vc.jumpUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[STNetworking host],responseObject[@"result"]]];
            [self.navigationController pushViewController:vc animated:YES];
        } failure:NULL];
       
    };
    [_dataArray addObject:recommendItem];
    
    
    [self setItems:self.dataArray];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMSetItem * setItem = (PMSetItem *)item;
    if (setItem.itemSelect ) {
        setItem.itemSelect();
    }
}

@end
