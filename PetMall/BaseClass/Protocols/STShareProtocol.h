//
//  STShareProtocol.h
//  SnailTruck
//
//  Created by imeng on 3/2/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol STShareProtocol <NSObject>

@required
#pragma mark Getter
- (NSString *)st_ShareTitle; //分享的标题
- (NSString *)st_ShareContent; //分享的内容

@optional
#pragma mark Getter
- (NSNumber *)st_ShareIdentifier; //分享的ID
- (NSURL *)st_ShareURL; //分享的网页地址
- (UIImage *)st_ShareImage;//分享的图片
- (NSURL *)st_ShareImageURL; //分享的图片URL

@end
