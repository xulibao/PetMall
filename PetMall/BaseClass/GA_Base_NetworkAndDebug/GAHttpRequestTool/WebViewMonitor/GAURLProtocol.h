//
//  GAURLProtocol.h
//  GA_Base_NetworkAndDebug
//
//  Created by GhGh on 2017/6/9.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef DEBUG
@interface GAURLProtocol : NSURLProtocol
+ (void)start;
+ (void)end;
@end
#endif
