//
//  SPCodeForgotCell.h
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/15.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "STCommonTableViewCell.h"
#import "SPCodeForgotModel.h"

@protocol SPCodeForgotCellDelegate <STCommonTableViewCellDelegate>

@optional
- (void)cellDidClickCodeForgot:(SPCodeForgotModel *)companyModel;
@end


@interface SPCodeForgotCell : STCommonTableViewCell

@property(nonatomic, weak) id<SPCodeForgotCellDelegate> cellDelegate;

@end
