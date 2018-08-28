//
//  SACommonCountDownItem.h
//  SnailAuction
//
//  Created by imeng on 20/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STCommonTableViewBaseItem.h"
#import "SACountdownEpisode.h"

@interface SACommonCountDownItem : STCommonBaseTableRowItem <SACountdownEpisodeDelegate>

@property(nonatomic, strong) SACountdownEpisode *countdownEpisode;

- (void)callDelegateUpdateInfo;
- (void)callDelegateExpired;

#pragma mark - SACountdownEpisodeDelegate
- (void)episodeCountdownEvent:(SACountdownEpisode *)episode;//callDelegateUpdateInfo
- (void)episodeExpiredEvent:(SACountdownEpisode *)episode;//callDelegateExpired

@end
