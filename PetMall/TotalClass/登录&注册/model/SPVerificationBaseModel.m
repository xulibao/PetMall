//
//  SAVerificationBaseModel.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SPVerificationBaseModel.h"
#import "SPVerificationBaseCell.h"

NSTimeInterval const SPVerificationCountDownTime = 120*1000;

@implementation SPVerificationBaseModel

- (Class)cellClass {
    return [SPVerificationBaseCell class];
}

- (void)startCountDown {
    self.countdownEpisode.countDown = SPVerificationCountDownTime;
    [self.countdownEpisode start];
}

@end
