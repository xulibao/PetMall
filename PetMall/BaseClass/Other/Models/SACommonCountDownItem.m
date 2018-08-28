//
//  SACommonCountDownItem.m
//  SnailAuction
//
//  Created by imeng on 20/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "SACommonCountDownItem.h"

@implementation SACommonCountDownItem

- (instancetype)init {
    self = [super init];
    if (self) {
        _countdownEpisode = [[[SACountdownEpisode alloc] initWithDelegate:self] start];
    }
    return self;
}

#pragma mark - CallDelegate

- (void)callDelegateUpdateInfo {
    NSArray<id<STCommonTableViewItemUpdateDelegate>> *delegates = self.delegates;
    
    for (id<STCommonTableViewItemUpdateDelegate> delegate in delegates) {
        if ([delegate respondsToSelector:@selector(objectDidUpdate:)]) {
            dispatch_main_async_safe(^{
                [delegate objectDidUpdate:self];
            })
        }
    }
}

- (void)callDelegateExpired {
    NSArray<id<STCommonTableViewItemUpdateDelegate>> *delegates = self.delegates;
    
    for (id<STCommonTableViewItemUpdateDelegate> delegate in delegates) {
        if ([delegate respondsToSelector:@selector(objectDidExpired:)]) {
            dispatch_main_async_safe(^{
                [delegate objectDidExpired:self];
            });
        }
    }
}


#pragma mark - SACountdownEpisodeDelegate

- (void)episodeCountdownEvent:(SACountdownEpisode *)episode {
    [self callDelegateUpdateInfo];
}

- (void)episodeExpiredEvent:(SACountdownEpisode *)episode {
    [self callDelegateExpired];
}

@end
