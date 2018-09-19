//
//  PMGroupPurchaserDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/19.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMGoodSaleDetailViewController.h"

@interface PMGoodSaleDetailViewController ()

@end

@implementation PMGoodSaleDetailViewController
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"将在08月28日12:00正式发售\n付尾款后7天内发货",@"立即支付定金\n¥50"];
    CGFloat buttonW = ScreenW * 0.8 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (0 == i) {
            button.titleLabel.font = PFR10Font;
        }else{
            button.titleLabel.font = PFR13Font;

        }
        button.titleLabel.numberOfLines = 0;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 1) ? [UIColor colorWithHexStr:@"#F93765"] : kColorFF3945;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

- (void)bottomButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 2){
//        [self showFeatureView];
    }else  if ( button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
