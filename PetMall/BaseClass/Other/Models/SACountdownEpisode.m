//
//  SACountdownEpisode.m
//  SnailAuction
//
//  Created by imeng on 20/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SACountdownEpisode.h"

const NSTimeInterval DefaultCountDownInterval = NSNotFound;

@interface SACountdownEpisode ()

@end

@implementation SACountdownEpisode
@synthesize countDownInterval=_countDownInterval;

- (instancetype)init {
    return [self initWithDelegate:nil];
}

- (instancetype)initWithDelegate:(id<SACountdownEpisodeDelegate>)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        _countDownInterval = DefaultCountDownInterval;
    }
    return self;
}

- (void)dealloc {
    [self removeObserver];
}

- (SACountdownEpisode *)start {
    _date = [NSDate date];
    _previousSpendTime = _date.timeIntervalSinceNow;
    return self;
}

- (SACountdownEpisode *)stop {
    [self removeObserver];
    return self;
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SACommonInfoCountDownNotificationName
                                               object:nil];
}

- (void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:SACommonInfoCountDownNotificationName
                                                  object:nil];
}

- (void)setCountDown:(long long)countDown {
    BOOL needAdd = _countDown != countDown;
    _countDown = countDown;
    if (needAdd) {
        [self removeObserver];
        [self addObserver];
    }
}

#pragma mark - Public

- (BOOL)isTimeOver {
    return !(self.countDownSecond > 0);
}

- (NSTimeInterval)spendTime {
    return self.date.timeIntervalSinceNow;
}

- (long long)countDownSecond {
    return self.countDown / 1000 + self.spendTime;
}

- (void)handleNotification:(NSDictionary *)sender {
    if (self.isTimeOver && [self.delegate respondsToSelector:@selector(episodeExpiredEvent:)]) {
        [self.delegate episodeExpiredEvent:self];
    }

    long interval = (long)self.spendTime - (long)self.previousSpendTime;
    if (ABS(interval) < self.countDownInterval) {return;}
    _previousSpendTime = self.spendTime;
    
    if ([self.delegate respondsToSelector:@selector(episodeCountdownEvent:)]) {
        [self.delegate episodeCountdownEvent:self];
    }
}

- (NSTimeInterval)countDownInterval {
    if (DefaultCountDownInterval == _countDownInterval) {
        return self.countDownSecond > (60*60) ? 60 : 1;
    } else {
        return _countDownInterval;
    }
}

@end
