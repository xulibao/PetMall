//
//  NSString+JSON.h
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/12/22.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JSON)
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithObject:(id) object;
@end
