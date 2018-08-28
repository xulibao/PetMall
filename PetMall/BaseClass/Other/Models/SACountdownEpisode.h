//
//  SACountdownEpisode.h
//  SnailAuction
//
//  Created by imeng on 20/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SACountdownEpisode;
@protocol SACountdownEpisodeDelegate <NSObject>

- (void)episodeCountdownEvent:(SACountdownEpisode *)episode;

@optional

- (void)episodeExpiredEvent:(SACountdownEpisode *)episode;

@end

extern const NSTimeInterval DefaultCountDownInterval;

@interface SACountdownEpisode : NSObject

#pragma mark - PrivateSetter

@property(nonatomic, strong, readonly) NSDate *date;
@property(nonatomic, assign, readonly) NSTimeInterval spendTime;
@property(nonatomic, assign, readonly) long long countDownSecond;

@property(nonatomic, assign, readonly) NSTimeInterval previousSpendTime;
@property(nonatomic, assign, readonly) BOOL isTimeOver;

#pragma mark - PublicSetter

@property(nonatomic, assign) NSTimeInterval countDownInterval;//倒计时间隔
@property(nonatomic, assign) long long countDown;    //倒计时    number
@property(nonatomic, weak) id<SACountdownEpisodeDelegate> delegate; //callback On back thread

- (instancetype)initWithDelegate:(id<SACountdownEpisodeDelegate>)delegate NS_DESIGNATED_INITIALIZER;
- (SACountdownEpisode *)start;//start call setData
- (SACountdownEpisode *)stop;

@end
