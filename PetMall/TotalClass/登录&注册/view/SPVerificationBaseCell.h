//
//  SAVerificationBaseCell.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STCommonTableViewCell.h"
#import "SABaseInputValidTextField.h"
#import "SPVerificationBaseModel.h"
#import "SABaseCell.h"
@class SPVerificationBaseCell;

@protocol SPVerificationBaseCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidClickSendMessageCode:(SPVerificationBaseCell *)cell;
@end

@interface SPVerificationBaseCell : STCommonTableViewCell

@property (nonatomic, strong) SPVerificationBaseModel * model;
@property (nonatomic, strong) SABaseInputValidTextField *cellTextField;//输入框
@property(nonatomic, weak) id<SPVerificationBaseCellDelegate> cellDelegate;
//@property (nonatomic, strong) NSTimer * timer;//定时器

@end
