//
//  SAApplication.h
//  SnailAuction
//
//  Created by imeng on 02/03/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLoginViewController.h"

#if DEBUG
//#define DEVELOPER_TEST_VIEWCONTROLLER @"PMLoginViewController"
#endif

typedef enum {
    PMUserTypeDog,
    PMUserTypeCat
}PMUserType;

@class SALotPriceInfoEntity;
@protocol SAPriceUpdateDelegate <NSObject>

- (void)updatePriceInfo:(SALotPriceInfoEntity *)price;
- (NSString *)priceInfoUpdateIdentifier;

@end

@protocol UIViewControllerNeedSignProtocol <NSObject>

@optional
- (BOOL)isNeedSign;

@end

@class SAUserInfoEntity,STTabBarController;
@interface SAApplication : NSObject

+ (SAApplication *)sharedApplication;

@property(nonatomic, strong) UIWindow *window;
//@property(nonatomic, strong) UINavigationController *navigationController;
@property(nonatomic, strong) STTabBarController *mainTabBarController;
@property(nonatomic, strong) PMLoginViewController *signInController;
@property(nonatomic, copy) NSString *userType;
@property(nonatomic, strong) SAUserInfoEntity *userInfo;

@end

@interface SAApplication (User)

+ (NSString *)userID;

+ (BOOL)isSign;
- (void)signIn;
- (void)signInWithCallBack:(void (^)(BOOL succeeded, NSError *error))callBack;
- (void)signOut;

- (void)storeUserInfo:(SAUserInfoEntity *)userInfo;

@end



extern NSNotificationName const SACommonInfoCountDownNotificationName;
extern NSNotificationName const SALotInfoListUpdateNotification;

