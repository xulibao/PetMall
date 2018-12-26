//
//  PMGroupPurchaserDetailViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/19.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMIntegralMallDetailViewController.h"
#import "SAAlertController.h"
#import "PMIntegralResultViewController.h"
#import "PMConfirmOrderViewController.h"
@interface PMIntegralMallDetailViewController ()

@end

@implementation PMIntegralMallDetailViewController
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"我的积分：321积分",@"立即兑换"];
    CGFloat buttonW = ScreenW  * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = ScreenH - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        if (0 == i) {
            NSString * str = @"我的积分：321积分";
            NSMutableAttributedString * att = [[NSMutableAttributedString alloc] initWithString:str];
            
            [att addAttributes:@{NSForegroundColorAttributeName:kColorFF3945} range:[str rangeOfString:@"321积分"]];
            
            [button setTitleColor:kColor333333 forState:UIControlStateNormal];
            [button setAttributedTitle:att forState:UIControlStateNormal];
        }else{
            [button setTitle:titles[i] forState:UIControlStateNormal];

            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
        button.titleLabel.font = PFR15Font;
        button.titleLabel.numberOfLines = 0;
        
        button.tag = i + 2;
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        button.backgroundColor = (i == 1) ? [UIColor colorWithHexStr:@"#F93765"] : [UIColor whiteColor];
        [button addTarget:self action:@selector(bottomRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = buttonW * i;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

- (void)bottomRightButtonClick:(UIButton *)button
{
    if (button.tag == 0) {
        NSLog(@"收藏");
        button.selected = !button.selected;
    }else if(button.tag == 2){
//        [self showFeatureView];
    }else  if ( button.tag == 3) { //父控制器的加入购物车和立即购买
        SAAlertController *alertController = [SAAlertController alertControllerWithTitle:nil
                                                                                 message:@"确定用积分兑换此商品吗\n兑换将自动扣除相应积分"
                                                                          preferredStyle:SAAlertControllerStyleAlert];
        SAAlertAction *action = [SAAlertAction actionWithTitle:@"兑换" style:SAAlertActionStyleDefault handler:^(SAAlertAction *action) {
            
            PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
            vc.goods_id = self.goods_id;
            vc.list_id = self.list_id;
            vc.price = self.detailModel.market_price;
            [self.navigationController pushViewController:vc animated:YES];
//            [self requestPOST:API_Classification_purchase parameters:@{@"goods_id":self.detailModel.goodId,@"user_id":[SAApplication userID],@"list_id":self.list_id,@"shul":@"1",@"type":@"2",@"flag":@"1"} success:^(__kindof SARequest *request, id responseObject) {
//                [self showSuccess:responseObject[@"msg"]];
//                PMIntegralResultViewController * vc = [PMIntegralResultViewController new];
//                [self pushViewController:vc];
//            } failure:NULL];
       
        }];
        [alertController addAction:action];
        action = [SAAlertAction actionWithTitle:@"取消" style:SAAlertActionStyleCancel handler:^(SAAlertAction *action) {
        }];
        [alertController addAction:action];
        
        [alertController showWithAnimated:YES];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) { //商品详情
        return   100;
    }else if (indexPath.section == 1){//商品属性选择
        return  0;
    }else if (indexPath.section == 2){//商品评价部分展示
        DCCommentsItem * item = self.commentsItem[indexPath.row];
        return  item.cellHeight;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (1 == section) {
        return CGFLOAT_MIN;
    }
    return 10;
}

@end
