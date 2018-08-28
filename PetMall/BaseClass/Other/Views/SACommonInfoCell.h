//
//  SACommonInfoCell.h
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "SATruckInfoBaseView.h"
#import "SATruckInfoBaseBottomView.h"

#import "SAInfoItemProtocol.h"

@interface SACommonInfoCell : STCommonTableViewCell

@property(nonatomic, strong) SATruckInfoBaseView *infoView;
@property(nonatomic, strong) SATruckInfoBaseBottomView *bottomView;
@property(nonatomic, strong) CAShapeLayer *dashLayer;

@property(nonatomic, strong) UIView *whiteBackground;

- (void)updateViewData:(id<SACommonListInfoItem>)viewData;
- (void)updateHotData:(id<SACommonListInfoItem>)viewData;

@end

@interface SACommonInfo1Cell : SACommonInfoCell

@end
