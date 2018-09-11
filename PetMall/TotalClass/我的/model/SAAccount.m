//
//  STAccount.m
//  SnailTruck
//
//  Created by 木鱼 on 15/11/11.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "SAAccount.h"
//#import "JPUSHService.h"
//#import "Growing.h" // Growing IO统计
#import "STNetworking.h" // 重置url header
//#import "STHuanXinChartBusiness.h" // 环信
@implementation SAAccount

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.tel forKey:@"tel"];
    [encoder encodeObject:self.pwd forKey:@"pwd"];
    [encoder encodeObject:@(self.loginType) forKey:@"loginType"];
    [encoder encodeObject:self.status forKey:@"status"];
    [encoder encodeObject:self.isjoin forKey:@"isjoin"];
    [encoder encodeObject:self.loginName forKey:@"loginName"];
    [encoder encodeObject:self.user_id forKey:@"user_id"];
    [encoder encodeObject:self.sex forKey:@"sex"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.isanon forKey:@"isanon"];
    [encoder encodeObject:self.isclerk forKey:@"isclerk"];
    [encoder encodeObject:self.idCard forKey:@"idCard"];
    [encoder encodeObject:self.isRealName forKey:@"isRealName"];
    [encoder encodeObject:self.mobile forKey:@"mobile"];
    [encoder encodeObject:self.realName forKey:@"realName"];
    [encoder encodeObject:self.isSignAgreement forKey:@"isSignAgreement"];
    [encoder encodeObject:self.agreementNo forKey:@"agreementNo"];
    [encoder encodeObject:self.photo forKey:@"photo"];
    [encoder encodeObject:self.nickName forKey:@"nickName"];
    [encoder encodeObject:self.sellCount forKey:@"sellCount"];
}

-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.tel = [decoder decodeObjectForKey:@"tel"];
        self.pwd = [decoder decodeObjectForKey:@"pwd"];
        self.loginType = [[decoder decodeObjectForKey:@"loginType"] integerValue];
        self.status = [decoder decodeObjectForKey:@"status"];
        self.isjoin = [decoder decodeObjectForKey:@"isjoin"];
        self.loginName = [decoder decodeObjectForKey:@"loginName"];
        self.user_id = [decoder decodeObjectForKey:@"user_id"];
        self.sex = [decoder decodeObjectForKey:@"sex"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.isanon = [decoder decodeObjectForKey:@"isanon"];
        self.isclerk = [decoder decodeObjectForKey:@"isclerk"];
        self.idCard = [decoder decodeObjectForKey:@"idCard"];
        self.isRealName = [decoder decodeObjectForKey:@"isRealName"];
        self.mobile = [decoder decodeObjectForKey:@"mobile"];
        self.realName = [decoder decodeObjectForKey:@"realName"];
        self.isSignAgreement = [decoder decodeObjectForKey:@"isSignAgreement"];
        self.agreementNo = [decoder decodeObjectForKey:@"agreementNo"];
        self.photo = [decoder decodeObjectForKey:@"photo"];
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.sellCount = [decoder decodeObjectForKey:@"sellCount"];
    }
    return self;
}

+ (void)saveAccountNumber:(SAAccount *)account
{
    NSString *uid = [NSString stringWithFormat:@"000000%@",account.user_id];
    NSSet *jpushSet = nil;
    if (KOpen_DebugView) {
       jpushSet = [NSSet setWithObjects:JPUSH_ON_LINE, @"dev",nil];
    }else{
       jpushSet = [NSSet setWithObject:JPUSH_ON_LINE];
    }
//    [JPUSHService setTags:jpushSet alias:uid callbackSelector:nil object:nil];
    // growing IO - cs1
//    NSString *beMakeString1 = [NSString stringWithFormat:@"%@",account.loginName];
//    if (KOpen_DebugView) {
//        [Growing disable];
//    }else{
//    [Growing setCS1Value:beMakeString1 forKey:@"loginName"];
//    // cs2
//    NSString *beMakeString2 = [NSString stringWithFormat:@"%@",account.user_id];
//    [Growing setCS2Value:beMakeString2 forKey:@"id"];
//    }

    NSString * docum = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ST_US_N.data"];
    [NSKeyedArchiver archiveRootObject:account toFile:docum];
    // 重置url header
    [STNetworkingBusiness sharedSTNetworkingBusiness].defaultRequestHeaderCacheDictM = nil;
}
- (NSString *)loginName{
    return _loginName ? _loginName: [SAAccount shareAccount].tel;
}
//保存账号
+ (SAAccount *)shareAccount{
    NSString * docum = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"ST_US_N.data"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:docum];
}

//是否登录
+ (BOOL)isLog
{
    if ([self shareAccount].tel.length) {
        return YES;
    }else{
        return NO;
    }
}
//是否是店员
+ (BOOL)isClerkPerson
{
    if ([[self shareAccount].isclerk integerValue] == 1) {
        return YES;
    }else{
        return NO;
    }
}
// 退出
+ (void)loginOut{
    NSSet *jpushSet = nil;
    [self clearWebViewCookie]; //清楚webView缓存
//    [[STHuanXinChartBusiness sharedSTHuanXinChartBusiness] logOutHuanxin];
    if (KOpen_DebugView) {
        jpushSet = [NSSet setWithObjects:JPUSH_OFF_LINE, @"dev",nil];
    }else{
        jpushSet = [NSSet setWithObject:JPUSH_OFF_LINE];
    }
//    [JPUSHService setTags:jpushSet alias:@"" callbackSelector:@selector(setTagsSuccess) object:self];
//    if (KOpen_DebugView) {
//        [Growing disable];
//    }else{
//    [Growing setCS1Value:nil forKey:@"loginName"];
//    [Growing setCS2Value:nil forKey:@"id"];
//    }
    
    NSString *doumPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *sdDoumPath = [doumPath stringByAppendingPathComponent:@"ST_US_N.data"];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL success = [manager removeItemAtPath:sdDoumPath error:nil];
    if (success) {
//        [STHelpTools showToastWithMessage:@"退出登录"];
    }
    // 重置url header
    [STNetworkingBusiness sharedSTNetworkingBusiness].defaultRequestHeaderCacheDictM = nil;
}
// 清楚webView缓存
+ (void)clearWebViewCookie
{
    //清空Cookie
    NSHTTPCookieStorage *myCookie = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookiein in [myCookie cookies])
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookiein];
    }
    //删除沙盒自动生成的Cookies.binarycookies文件
    NSString *path = NSHomeDirectory();
    NSString *filePath = [path stringByAppendingPathComponent:@"/Library/Cookies/Cookies.binarycookies"];
    NSFileManager *manager = [NSFileManager defaultManager];
    [manager removeItemAtPath:filePath error:nil];
}
- (void)setTagsSuccess
{
    NSLog(@"setTagsSuccess");
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.tel = dict[@"tel"];
        self.status = dict[@"status"];
        self.isjoin = dict[@"isjoin"];
        self.loginName = dict[@"loginName"];
        self.user_id = dict[@"id"];
        self.sex = dict[@"sex"];
        self.name = dict[@"name"];
        self.isclerk = dict[@"isclerk"];
        self.idCard = dict[@"idCard"];
        self.isRealName = dict[@"isRealName"];
        self.mobile = dict[@"mobile"];
        self.realName = dict[@"realName"];
        self.isSignAgreement = dict[@"isSignAgreement"];
        self.agreementNo = dict[@"agreementNo"];
        self.photo = dict[@"photo"];
        self.nickName = dict[@"nickName"];
        self.sellCount = dict[@"sellCount"];
    }
    return self;
}
- (NSString *)user_id
{
    if ([_user_id isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)_user_id stringValue];
    }
    return _user_id;
}
@end
