//
//  GADebugNetwork.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugNetwork.h"
#import "GADebugDB.h"
#import <UIKit/UIKit.h>

static NSString *networkDebugModelName = @"Network";        // 网络存储数据表名
static const NSInteger requestMaxCacheAge = 60 * 60 * 12;   // 数据最长保留时间为0.5天
@implementation GADebugNetwork

+ (GADebugNetwork *)sharedInstance{
    static GADebugNetwork *debugNetwork = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        debugNetwork = [[GADebugNetwork alloc] init];
    });
    return debugNetwork;
}

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) init{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanRequest)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(cleanRequest)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

- (GADebugNetworkModel *) beginRequest {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认YES
    GADebugDB *debugDB = [GADebugDB shareInstance];
    GADebugNetworkModel *networkModel = [debugDB insertEntity:networkDebugModelName];
    networkModel.begindate = [NSDate date];
    return networkModel;
}

- (void) endRequest:(GADebugNetworkModel *)networkModel {
//    if (!self.enabled) {
//        return;
//    }
#pragma mark - 默认YES
    networkModel.enddate = [NSDate date];
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB saveContext];
}

- (NSArray *) requests {
    return [self requestsBeginDate:nil endDate:nil];
}

- (NSArray *) requestsBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认YES
    GADebugDB *debugDB = [GADebugDB shareInstance];
    NSPredicate *query = nil;
    if (beginDate && endDate) {
        query = [NSPredicate predicateWithFormat:@"(begindate > %@) AND (begindate < %@) AND enddate != nil",beginDate,endDate];
    }else if(beginDate){
        query = [NSPredicate predicateWithFormat:@"(begindate > %@) AND enddate != nil",beginDate];
    }else if(endDate){
        query = [NSPredicate predicateWithFormat:@"(begindate < %@) AND enddate != nil",endDate];
    }else{
        query = [NSPredicate predicateWithFormat:@"enddate != nil"];
    }
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"begindate" ascending:NO];
    return [debugDB selectDataFromEntity:networkDebugModelName
                                   query:query
                                    sort:sort];
}

- (void) cleanRequest {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认YES
    // 查找过期的请求，并删除requestMaxCacheAge之前的数据
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB removeDataFromEntity:networkDebugModelName
                            query:[NSPredicate predicateWithFormat: @"(begindate < %@)",[[NSDate alloc] initWithTimeIntervalSinceNow:-requestMaxCacheAge]]];
    [debugDB saveContext];
}

- (void) clearRequest {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认YES
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB clearEntity:networkDebugModelName];
    [debugDB saveContext];
}

@end
