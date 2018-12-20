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
    int peopleCount = [self.detailModel.groupa intValue] - [self.detailModel.goods_shul intValue];
    NSString * groupStr;
    if (peopleCount > 0) {
        groupStr = [NSString stringWithFormat:@"还差%d人",peopleCount];
    }else{
        groupStr = @"已成团";
    }
    self.goodTip = [NSString stringWithFormat:@"%@人参团 %@",self.detailModel.goods_shul ? self.detailModel.goods_shul : @"0",groupStr];
}
#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton{
    
    NSArray *titles = @[[NSString stringWithFormat:@"¥%@\n单独购买",self.detailModel.market_price],[NSString stringWithFormat:@"¥%@\n参团购买",self.detailModel.selling_price]];
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
        button.backgroundColor = ([SAApplication userID]) ?  kColorFF3945 : [UIColor colorWithHexStr:@"#FFC3C7"];
        [button addTarget:self action:@selector(bottomRightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = ScreenW * 0.2 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [self.view addSubview:button];
    }
}

- (void)bottomRightButtonClick:(UIButton *)button{
    
    if ([SAApplication needSignTool]) {
        return;
    }
    if(button.tag == 2){
//        [self showFeatureView];
        //异步发通知
        PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
        vc.list_id = self.detailModel.list_id;
        vc.goods_id =  self.detailModel.goodId;
        vc.price = self.detailModel.market_price;
        [self.navigationController pushViewController:vc animated:YES];
    }else  if ( button.tag == 3) { //父控制器的加入购物车和立即购买
        //异步发通知
        PMConfirmOrderViewController * vc = [[PMConfirmOrderViewController alloc] init];
        vc.list_id = self.detailModel.list_id;
        vc.goods_id =  self.detailModel.goodId;
        vc.price = self.detailModel.selling_price;
        [self.navigationController pushViewController:vc animated:YES];
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
