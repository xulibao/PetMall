//
//  GADebugManager.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//

#import "GADebugManager.h"
#ifdef DEBUG
@implementation GADebugManager


+ (GADebugNetwork *)networkInstance{
    return [GADebugNetwork sharedInstance];
}

+ (GADebugServer *)serverInstance{
    return [GADebugServer sharedInstance];
}

+ (GADebugPerformance *)performanceInstance{
    return [GADebugPerformance sharedInstance];
}

+ (GADebugStorage *)storageInstance{
    GADebugStorage *debugStorage = [GADebugStorage sharedInstance];
    debugStorage.enabled = YES; // 模快启动 debug
    return debugStorage;
}

+ (GADebugUILineView *)UILineInstance{
    return [GADebugUILineView sharedInstance];
}

+ (GADebugAdsView *)adsInstance{
    return [GADebugAdsView sharedInstance];
}

+ (GADebugCrash *)crashInstance{
    return [GADebugCrash sharedInstance];
}

@end
#endif
