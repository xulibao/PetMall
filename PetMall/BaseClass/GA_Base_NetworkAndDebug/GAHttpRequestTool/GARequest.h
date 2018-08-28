//
//  GARequest.h
//  GA_Base_NetworkAndDebug
//  此层实现了 request 参数 模型转字典 和 response 字典转模型
//  Created by imeng on 12/12/16.
//  Copyright © 2016 GhGh. All rights reserved.
//

#import "GABaseRequest.h"

#define GARequestInterface(SubClass,SuperClass,EntityClass) \
@class EntityClass;\
@interface SubClass : SuperClass \
- (EntityClass *)responseEntity;\
- (void)setCompletionBlockWithSuccess:(void (^ __nullable)(SubClass *request))success \
failure:(void (^ __nullable)(SubClass *request))failure;\
- (SubClass *)startWithCompletionBlockWithSuccess:(void (^ __nullable)(SubClass *request))success \
failure:(void (^ __nullable)(SubClass *request))failure;


#define GARequestImplementation(SubClass) \
@implementation SubClass \
- (__kindof NSObject *)responseEntity { \
    return [super responseEntity]; \
} \
- (void)setCompletionBlockWithSuccess:(void (^ __nullable)(SubClass *request))success \
failure:(void (^ __nullable)(SubClass *request))failure { \
    [super setCompletionBlockWithSuccess:success failure:failure]; \
} \
- (SubClass *)startWithCompletionBlockWithSuccess:(void (^ __nullable)(SubClass *request))success \
failure:(void (^ __nullable)(SubClass *request))failure {\
    return [super startWithCompletionBlockWithSuccess:success failure:failure]; \
}

@interface GARequest : GABaseRequest

@property (nonatomic, strong) __kindof NSObject *responseEntity;

@end

/**
 请先阅读此文: https://github.com/yuantiku/YTKNetwork/blob/master/Docs/BasicGuide_cn.md
 
 GARequest 不能直接被使用
 GARequest 继承自 YTKRequest
 
 每一种请求都需要继承 GARequest 类，通过覆盖父类的一些方法来构造指定的网络请求。
 每一种网络请求继承 GARequest 类后，需要用方法覆盖（overwrite）的方式，来指定网络请求的具体信息。
 
 可使用 GARequestInterface GARequestImplementation 来声明实现子类 提供了类型override
 GARequestInterface 需要提供实体类型 实体类有命名要求 命名规则固定为 请求类: GARequest 实体类 GAResponseEntity
 
 GARequest 默认实现了 请求参数 requestArgument 方法的 overwrite 如需自定义 overwrite即可
 GARequest 默认实现 中会将 继承自 GARequest 的类中属性转换为 map 作为 requestArgument
 
 在 YTKRequest 的 response 属性(
 responseData;
 responseString;
 responseObject;
 responseJSONObject 
 ) 基础上 
 
 GARequest 增加了 responseEntity 将 responseJSONObject 转换为对应类的实体对象
 responseEntity 在使用前需添加对应的实体类 命名规则固定为 请求类: GARequest 实体类 GAResponseEntity
 
 ❌⚠️ requestUrl 务必要实现
 在未实现 baseUrl 时需要 配合 GARequestHostConfiguration 使用 也可直接食用 YTKNetworkConfig
 GANetworking 提供了一个 GARequestHostConfiguration 使用的样板代码 可复制修改直接使用
 
**/

/**
如下是一个示例：

@interface GAVersionCheckResponseEntity : NSObject

@property (nonatomic, strong) GARepBodyResponseEntity * repBody;
@property (nonatomic, strong) NSString * resCode;
@property (nonatomic, strong) NSString * resMsg;

@end

@implementation GAVersionCheckResponseEntity

@end

GARequestInterface(GAVersionCheckRequest,GAVersionCheckResponseEntity)

@property (nonatomic,copy) NSString *mobileType;

@end

GARequestImplementation(GAVersionCheckRequest)

- (NSString *)requestUrl {
    return @"api/v1/appversion/ulastVersion";
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    GAVersionCheckRequest *request = [GAVersionCheckRequest new];
    request.mobileType = @"1";
    
    [request startWithCompletionBlockWithSuccess:^(GAVersionCheckRequest *request) {
        NSLog(@"%@", request.responseEntity);
    } failure:^(GAVersionCheckRequest *request) {
        NSLog(@"%@", request.responseEntity);
    }];
}

**/
