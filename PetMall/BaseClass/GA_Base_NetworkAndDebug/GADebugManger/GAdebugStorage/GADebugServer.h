//
//  GADebugServer.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugObject.h"
#import "GADebugServerModel.h"

@interface GADebugServer : GADebugObject
@property (nonatomic,strong,readonly) GADebugServerModel *serverModel;
@property (nonatomic,strong,readonly) NSString *serverUrl; // 可以取出默认地址,不提倡使用

+ (GADebugServer *)sharedInstance;

/**
 *  添加服务器
 *
 *  @param name 服务器名
 *  @param url  服务器地址
 */
- (GADebugServerModel *) addServerName:(NSString *)name url:(NSString *)url;

/**
 *  添加服务器
 *
 *  @param name 服务器名
 *  @param url  服务器地址
 *  @param enable  是否开启ServerName
 */
- (GADebugServerModel *) addServerName:(NSString *)name url:(NSString *)url enable:(BOOL)enable;

/**
 *  删除服务器
 *
 *  @param serverModel 服务器Model
 */
- (void) removeServer:(GADebugServerModel *)serverModel;
/**
 *  服务器列表
 *
 *  @return 服务器列表
 */
- (NSArray *)servers;
/**
 *  保存修改后的服务器列表
 *
 *  @param serverModel 服务器模型
 */
- (void) saveServer:(GADebugServerModel *)serverModel;
@end
