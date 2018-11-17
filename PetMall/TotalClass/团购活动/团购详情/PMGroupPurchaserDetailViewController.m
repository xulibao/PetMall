//
//  PMGroupPurchaserDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/19.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGroupPurchaserDetailViewController.h"

@interface PMGroupPurchaserDetailViewController ()

@property(nonatomic, strong) UIButton *collectionBtn;

@end

@implementation PMGroupPurchaserDetailViewController
- (void)initViewData{
    [super initViewData];
    self.goodTip = [NSString stringWithFormat:@"参团数量%@ 还差%@",self.detailModel.goods_shul,self.detailModel.groupa];
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"¥28\n单独购买",@"¥20.8\n参团购买"];
    CGFloat buttonW = ScreenW * 0.8 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = PFR13Font;
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor colorWithHexStr:@"#FFC3C7"] : kColorFF3945;
        [button addTarget:self action:@selector(bottomRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
    }
}

- (void)bottomRightButtonClick:(UIButton *)button{
    if(button.tag == 2){
//        [self showFeatureView];
    }else  if ( button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
        vc.list_id = self.detailModel.list_id;
        vc.goods_id =  self.detailModel.goodId;
        vc.price = self.detailModel.selling_price;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
