//
//  GADebugServer.m
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugServer.h"
#import "GADebugDB.h"

static NSString *serverDebugModelName = @"Server";        // 服务器存储数据表名
@implementation GADebugServer
@synthesize serverModel = _serverModel;

+ (GADebugServer *)sharedInstance{
    static GADebugServer *debugServer = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        debugServer = [[GADebugServer alloc] init];
        debugServer.enabled = YES; // 模快启动 debug
    });
    return debugServer;
}

- (GADebugServerModel *) addServerName:(NSString *)name url:(NSString *)url {
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    return [self addServerName:name url:url enable:YES];
}

- (GADebugServerModel *) addServerName:(NSString *)name url:(NSString *)url enable:(BOOL)enable {
    GADebugDB *debugDB = [GADebugDB shareInstance];
    
    NSArray *abc = [debugDB selectDataFromEntity:serverDebugModelName query:[NSPredicate predicateWithFormat:@"url = %@",url]];
    if (abc.count > 1) {
        for (int i = 1; i < abc.count; i ++) {
            GADebugServerModel *existingObject = abc[i];
            [debugDB remove:existingObject];
        }
    }
    GADebugServerModel *existingObject = abc.firstObject;
    existingObject.name = name;
    
    GADebugServerModel *serverModel;
    if (existingObject) {
        serverModel = existingObject;
    } else {
        serverModel = [debugDB insertEntity:serverDebugModelName];
    }
    
    // 新增server model
    serverModel.name = name;
    serverModel.url = url;
    serverModel.enabled = @(NO);
    
    // 先读取所有的server标记为禁用状态
    NSArray *servers = [self servers];
    for (GADebugServerModel *serverModel in servers) {
        if (enable) {
            serverModel.enabled = @(NO);
        } else if ([serverModel.enabled boolValue]) {
            // 当前选中项
            _serverModel = serverModel;
        }
    }
    
    if (enable) {
        // 当前选中项
        serverModel.enabled = @(enable);
        _serverModel = serverModel;
    }
    
    // 存储入库
    [debugDB saveContext];
    
    return serverModel;
}

- (void) removeServer:(GADebugServerModel *)serverModel {
    //        if (!self.enabled) {
    //            return nil;
    //        }
#pragma mark - 默认开启
    
    if (_serverModel == serverModel) {
        _serverModel = nil;
    }
    
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB remove:serverModel];
    [debugDB saveContext];
}

- (void) saveServer:(GADebugServerModel *)serverModel{
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    [debugDB saveContext];
    if ([serverModel.enabled boolValue]) {
        _serverModel = serverModel;
    }
}

- (NSString *)serverUrl{
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    self.enabled = YES;
    if (self.enabled) {
        if (self.serverModel) {
            NSLog(@"Enabled:%@", self.serverModel.url);
            return self.serverModel.url;
        }else{
            [self servers];
            if (self.serverModel) {
                NSLog(@"!Enabled:%@", self.serverModel.url);
                return self.serverModel.url;
            }
            return @"http://115.29.103.166/DrivingTrainingReservation/api/";
        }
    }else{
        return @"http://115.29.103.166/DrivingTrainingReservation/api/";
    }
}

- (NSArray *)servers {
    //    if (!self.enabled) {
    //        return nil;
    //    }
#pragma mark - 默认开启
    GADebugDB *debugDB = [GADebugDB shareInstance];
    NSArray *servers = [debugDB selectDataFromEntity:serverDebugModelName query:nil];
    if (servers && servers.count) {
        for (GADebugServerModel *serverModel in servers) {
            if ([serverModel.enabled boolValue]) {
                _serverModel = serverModel;
            }
        }
    }
    return servers;
}

@end
