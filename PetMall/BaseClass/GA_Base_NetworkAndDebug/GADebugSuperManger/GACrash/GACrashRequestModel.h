//
//  GACrashRequestModel.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/8.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GARequestBaseModel.h"

@interface GACrashRequestModel : GARequestBaseModel
/**
 *  页面名称
 */
@property (nonatomic,copy) NSString *pageName;

/**
 *  异常名称
 */
@property (nonatomic,copy) NSString *exceptionName;

/**
 *  异常类型：0，捕获的异常；1 crash
 */
@property (nonatomic,assign) NSInteger exceptionType;

/**
 *  异常堆栈详细信息
 */
@property (nonatomic,copy) NSString *exceptionsStackDetail;

/**
 *  应用版本号
 */
@property (nonatomic,copy) NSString *appVersion;

/**
 *  系统版本号
 */
@property (nonatomic,copy) NSString *osVersion;

/**
 *  设备型号
 */
@property (nonatomic,copy) NSString *deviceModel;

/**
 *  网络类型 ex：0：无网；1：2G；2：3G;  3:4G  5：WIFI
 */
@property (nonatomic,copy) NSString *netWorkType;

/**
 *  设备状态，记录CPU及内存等信息
 */
@property (nonatomic,copy) NSString *deviceStatus;

/**
 *  渠道号
 */
@property (nonatomic,copy) NSString *channelId;

/**
 *  客户端类型
 */
@property (nonatomic,assign) NSInteger clientType;

/**
 *  通讯运营商
 */
@property (nonatomic,copy) NSString *netWorkCarrier;

/**
 *  crash时间
 */
@property (nonatomic,strong) NSString *crashTime;

/**
 *  应用名称
 */
@property (nonatomic,copy) NSString *appName;

/**
 *  GA帐户
 */
@property (nonatomic,copy) NSString *GAAccount;

/**
 *  手机号码
 */
@property (nonatomic,copy) NSString *phoneNumber;

/**
 *  设备ID
 */
@property (nonatomic,copy) NSString *deviceId;
@end
