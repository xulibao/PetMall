//
//  GANetworking.m
//  GA_Base_NetworkAndDebug
//
//  Created by imeng on 12/13/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import "STNetworking.h"
#import "GARequestConfiguration.h"
#import <AFNetworking.h>
#import "UIDevice+Hardware.h"
#import "STNetworkAgent.h"
//#import <Qiniu/QNUploadManager.h>

//static NSDictionary *defaultRequestHeaderFieldValueDictionaryCache;
//增加contentType text/plain
//登录接口返回contentType不正确 text/plain;charset=UTF-8 /truck/api/v1/userLogin
@interface YTKNetworkAgent ()

- (AFJSONResponseSerializer *)jsonResponseSerializer;

@end

static NSString *const STSecurityPolicyCerKey = @"STSecurityPolicyCerKey";//证书文件名key
static NSString *const STShareURLHostKey = @"STShareURLHostKey";//分享host
static NSString *const STURLHostKey = @"SQURLHostKey";//蜗牛host


//适当冗余
//七牛图片前缀 － 测试
static NSString *const STImageUrlPrefixCeShi = @"http://p59is6erd.bkt.clouddn.com/";
//七牛图片前缀 － 正式
static NSString *const STImageUrlPrefixZhengShi = @"http://p57r7pmim.bkt.clouddn.com/";

static NSDictionary<NSString *,NSDictionary<NSString*,NSString*>*> * const StaticServiceHostsGet() {
    static NSDictionary *StaticServiceHosts;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        StaticServiceHosts = @{
#if KOpen_DebugView
                               @"http://www.woniuhuoche.com/truck-auction-app":
                                   @{GAURLHOSTNAMEKEY:@"蜗牛正式",
                                     GAIMAGEURLHOSTKEY:STImageUrlPrefixZhengShi,
                                     STURLHostKey:@"http://www.woniuhuoche.com/truck-auction-app",
//                                     STSecurityPolicyCerKey:@"faBuHttps" //证书文件名
//                                     GAURLHOSTENABLEDKEY:@(YES),
                                     },
                               @"http://222.175.171.242:86/truck-auction-app":
                                   @{GAURLHOSTNAMEKEY:@"蜗拍车测试",
                                     GAIMAGEURLHOSTKEY:STImageUrlPrefixCeShi,
                                     STURLHostKey:@"http://222.175.171.242:86/truck",
                                     GAURLHOSTENABLEDKEY:@(YES),
                                     },
                             @"http://222.175.171.242:9980/mockjs/27":
                                   @{GAURLHOSTNAMEKEY:@"mock数据",
                                     GAIMAGEURLHOSTKEY:STImageUrlPrefixCeShi,
//                                     GAURLHOSTENABLEDKEY:@(YES)
                                     },
#else
                                @"http://www.woniuhuoche.com/truck-auction-app":
                                   @{GAURLHOSTNAMEKEY:@"蜗牛正式",
                                     GAIMAGEURLHOSTKEY:STImageUrlPrefixZhengShi,
                                     GAURLHOSTENABLEDKEY:@(YES),
//                                     STShareURLHostKey:@"http://m.woniuhuoche.com/cn",
                                     STURLHostKey:@"http://www.woniuhuoche.com/truck-auction-app",
//                                STSecurityPolicyCerKey:@"faBuHttps" //证书文件名
                                     },
#endif
                               };
    });
    return StaticServiceHosts;
}

@implementation STNetworking

+ (void)initNetworking {
    
    //增加contentType text/plain
    //登录接口返回contentType不正确 text/plain;charset=UTF-8 /truck/api/v1/userLogin
    [[STNetworkAgent sharedAgent].jsonResponseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/javascript", nil]];
    
    [GARequestConfiguration addServiceHosts:StaticServiceHostsGet()];
    
    NSString *cerFileName = StaticServiceHostsGet()[self.host][STSecurityPolicyCerKey];
    if (cerFileName && cerFileName.length > 0) {
        [GARequestConfiguration setSecurityPolicy:[self securityPolicyWithCerFileName:cerFileName]];
    }
#if DEBUG
    [GARequestConfiguration setDebugLogEnabled:YES];
#endif
}

+ (NSString *)host {
    return [GARequestConfiguration host];
}

+ (NSString *)stHost {
    NSString *host = [GARequestConfiguration host];
    NSDictionary *hostInfo = StaticServiceHostsGet()[host];
    return hostInfo[STURLHostKey];
}

+ (NSString *)imageHost {
    NSString *host = [GARequestConfiguration host];
    NSDictionary *hostInfo = StaticServiceHostsGet()[host];
    return hostInfo[GAIMAGEURLHOSTKEY];
}

+ (NSString *)shareHost {
    NSString *host = [GARequestConfiguration host];
    NSDictionary *hostInfo = StaticServiceHostsGet()[host];
    return hostInfo[STShareURLHostKey];
}

+ (AFSecurityPolicy *)securityPolicyWithCerFileName:(NSString *)cerFileName {
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:cerFileName ofType:@"cer"];
    NSAssert(cerPath, @"%@.cer 证书文件不存在 ", cerFileName);
    if (!cerPath) {
        return nil;
    }
    
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //是否允许CA不信任的证书通过
    securityPolicy.allowInvalidCertificates = YES;
    //是否验证主机名或者验证域名
    securityPolicy.validatesDomainName = NO;
    // 证书cer添加
    [securityPolicy setPinnedCertificates:[NSSet setWithObject:certData]];
    return securityPolicy;
}

// url  header
+ (NSDictionary<NSString *, NSString *> *)defaultRequestHeaderFieldValueDictionary
{
    return [STNetworkingBusiness sharedSTNetworkingBusiness].defaultRequestHeaderCacheDictM.copy;
}

@end

#pragma mark - urlHeader
@implementation STNetworkingBusiness
DEFINE_SINGLETON_FOR_CLASS(STNetworkingBusiness)

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _imageUploadManager = [[QNUploadManager alloc] init];
//        [[NSNotificationCenter defaultCenter] addObserverForName:GALocationDidChangeNotification
//                                                          object:nil
//                                                           queue:[[NSOperationQueue alloc] init]
//                                                      usingBlock:^(NSNotification * _Nonnull note) {
//                                                          _defaultRequestHeaderCacheDictM = nil;
//                                                      }];
    }
    return self;
}

- (NSDictionary *)defaultRequestHeaderCacheDictM
{
    if (_defaultRequestHeaderCacheDictM == nil) {
        NSMutableDictionary *appUserData = [NSMutableDictionary dictionary];
        //手机型号
        NSString *phoneModel = [[UIDevice currentDevice] machineModelName];
        [appUserData setObject:phoneModel forKey:@"phoneModel"];
        //系统版本
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        [appUserData setObject:sysVersion forKey:@"sysVersion"];
        //手机屏幕尺寸
        CGSize size = [UIScreen mainScreen].bounds.size;
        CGFloat scale = [UIScreen mainScreen].scale;
        NSString *w_and_h = [NSString stringWithFormat:@"%.f*%.f", size.width * scale, size.height * scale];
        [appUserData setObject:w_and_h forKey:@"w_and_h"];
        //蜗牛二手货车版本号
        NSString *snailTruckVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        [appUserData setObject:snailTruckVersion forKey:@"version"];
        //用户位置信息
//        NSDictionary *addressDict = GPRS_ALL_NAME_DICT_VALUE;
//
//        if ([addressDict isKindOfClass:[NSDictionary class]] && addressDict.count) {
//            NSMutableDictionary *userAddress = [NSMutableDictionary dictionary];
//            NSString *province = addressDict[@"province"]; //省
//            NSString *city = addressDict[@"city"];         //市
//            NSString *district = addressDict[@"district"]; //县/区
//            NSString *detailsAddress = addressDict[@"streetName"]; //街道
//
//            if (province) {
//                [userAddress setObject:province forKey:@"province"];
//            }else{
//                [userAddress setObject:@"" forKey:@"province"];
//            }
//            if (city) {
//                [userAddress setObject:city forKey:@"city"];
//            }else{
//                [userAddress setObject:@"" forKey:@"city"];
//            }
//            if (district) {
//                [userAddress setObject:district forKey:@"district"];
//            }else{
//                [userAddress setObject:@"" forKey:@"district"];
//            }
//            if (detailsAddress) {
//                [userAddress setObject:detailsAddress forKey:@"detailsAddress"];
//            }else{
//                [userAddress setObject:@"" forKey:@"detailsAddress"];
//            }
//            [appUserData setObject:[STHelpTools dictionaryToJson:userAddress] forKey:@"userAddress"];
//        }
        
        //网络类型
        NSString *network = [[UIDevice currentDevice] currentNetState];
        [appUserData setObject:network forKey:@"network"];
        if ([SAApplication userID]) {
            [appUserData setObject:[SAApplication userID] forKey:@"userId"];
        }else{
            [appUserData setObject:@"" forKey:@"userId"];
        }
        //来源
        [appUserData setObject:@"iOS_WN" forKey:@"comeFrom"];
        //设备唯一标示
//        [appUserData setObject:[STHelpTools gen_uuid] forKey:@"UUID"];
        
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:appUserData options:0 error:&error];
        NSString *appUserDataString = [jsonData base64EncodedString];
        _defaultRequestHeaderCacheDictM = @{@"userData": appUserDataString}.mutableCopy;
    }
    return _defaultRequestHeaderCacheDictM;
}
@end


