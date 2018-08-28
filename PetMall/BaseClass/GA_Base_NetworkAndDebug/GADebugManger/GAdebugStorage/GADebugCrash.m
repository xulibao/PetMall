//
//  GADebugCrash.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugCrash.h"
#import "GADebugDB.h"

static NSString *crashDebugModelName = @"Crash";        // Crash数据表名
@implementation GADebugCrash

+ (GADebugCrash *)sharedInstance {
    static GADebugCrash *crash = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        crash = [[GADebugCrash alloc] init];
    });
    return crash;
}

- (GADebugCrashModel *)beginCrash {
//    if (!self.enabled) {
//        return nil;
//    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    GADebugCrashModel *crashModel = [debugDB insertEntity:crashDebugModelName];
    return crashModel;
}

- (void)endCrash {
//    if (!self.enabled) {
//        return;
//    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB saveContext];
}

- (NSArray *)crashes {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    return [debugDB selectDataFromEntity:crashDebugModelName
                                   query:nil];
}

- (void)clearCrash {
    //    if (!self.enabled) {
    //        return;
    //    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB clearEntity:crashDebugModelName];
    [debugDB saveContext];
}
@end
