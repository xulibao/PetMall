//
//  STAccount.h
//  SnailTruck
//
//  Created by 木鱼 on 15/11/11.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,STLoginType) {
    /** 正常登录 */
    kLoginTypeNormal = 0,
    /** 快速登录 */
    kLoginTypeFast
};


@interface SAAccount : NSObject <NSCoding>

/** 手机号码/用户名 */
@property (nonatomic, copy) NSString *tel;
/** 登录密码 */
@property (nonatomic, copy) NSString *pwd;
/** 登录方式:(0正常登录 1快速登录) */
@property (nonatomic, assign) STLoginType loginType;
/** 登录方式 */
@property (nonatomic, copy) NSString *isanon;
/** 是否冻结(0:正常 frozen:冻结) */
@property (nonatomic, copy) NSString *status;
/** 是否是加盟商 (1是加盟商 0 不是加盟商) */
@property (nonatomic, copy) NSString *isjoin;
/** 登录名 */
@property (nonatomic, copy) NSString *loginName;
/** 用户记录的唯一标识 */
@property (nonatomic, copy) NSString *user_id;
/** 用户名称 */
@property (nonatomic, copy) NSString *name;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 上一次登陆时间 */
@property (nonatomic, copy) NSString *lastLoginTime;
/** 是否是店员 1 表示是店员*/
@property (nonatomic, copy) NSString *isclerk;
/** 身份证*/
@property (nonatomic, copy) NSString *idCard;
/** 是否实名*/
@property (nonatomic, copy) NSString *isRealName; //实名1，未实名0
/** 电话*/
@property (nonatomic, copy) NSString *mobile;
/** 真实姓名*/
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *isSignAgreement; //1 已经签署协议 0 未签署
@property (nonatomic, copy) NSString *agreementNo; //协议编号
@property (nonatomic, copy) NSString *nickName;  //3.4 昵称
@property (nonatomic, copy) NSString *photo;  //3.4 头像
@property (nonatomic, copy) NSString *sellCount; //3.4 预约数量


- (instancetype)initWithDict:(NSDictionary *)dict;
//是否登录
+ (BOOL)isLog;
//是否是店员
+ (BOOL)isClerkPerson;
//获取账号
+ (SAAccount *)shareAccount;
//保存账号
+ (void)saveAccountNumber:(SAAccount *)account;

+ (void)loginOut;



@end
