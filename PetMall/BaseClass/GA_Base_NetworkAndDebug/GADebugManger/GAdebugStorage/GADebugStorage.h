//
//  GADebugStorage.h
//  GA_Base_FrameWork
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugObject.h"
#import "GADebugUserDefaultModel.h"
#import "GADebugKeychainModel.h"
@interface GADebugStorage : GADebugObject

+ (GADebugStorage *)sharedInstance;

/**
 *  NSUserDefault数据
 *
 *  @return NSUserDefaults
 */
- (NSArray *)userDefaults;

/**
 *  Keychain数据
 *
 *  @return Keychains
 */
- (NSArray *)keychains;
@end
