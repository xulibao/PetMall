//
//  SAMineHeadView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/6.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAPersonCenterModel.h"
@class STMineHeadView;

@protocol SAMineHeadViewDelegate <NSObject>
@optional
- (void)mineHeadViewClickSignButton;
- (void)mineHeadViewChangePassword:(UIButton *)changeButton;
//- (void)mineHeadViewClickMenuButton:(SAMineMenuButton * )menuButton;
- (void)mineHeadViewClickCertification;
- (void)mineHeadViewClickUserInfo;
- (void)mineHeadViewClickSellCar;


@end

@interface SAMineHeadModel : NSObject

@property (nonatomic, copy) NSString *infoCount; // 消息中心,未读个数

@end


@interface SAMineHeadView : UIView

@property (nonatomic, strong) UIImageView * headImageBg;

@property (nonatomic, weak) id <SAMineHeadViewDelegate> delegate;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, strong) SAPersonCenterModel *model;

@end
