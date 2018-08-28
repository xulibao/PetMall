//
//	OMResponse.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import "STAPIResponse.h"

NSString *const kSQResponseData = @"data";
NSString *const kSQResponseResCode = @"resCode";
NSString *const kSQResponseResMsg = @"resMsg";

@interface STAPIResponse ()

@end

@implementation STAPIResponse

#pragma mark - MJKeyValue

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"entity" : @"data",
             @"data" : @"data"};
}

@end
