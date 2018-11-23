//
//  ShareMainView.h
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareMenuView.h"
#import "STShareProtocol.h"
#import "STShareComponent.h"

@interface ShareMainView : UIView

@property (nonatomic, strong) NSArray *platforms;

+ (instancetype)shareMainViewWithPlatform:(NSArray *)platforms;

- (void)showShareTitle:(NSString *)title message:(NSString *)message shareImage:(UIImage *)shareImage shareUrl:(NSString *)shareUrl info:(NSDictionary *)info presenteController:(UIViewController *)controller success:(SocialRequestCompletionHandler)success cancle:(void (^)(void))cancle;

- (void)showWithShareObject:(id<STShareProtocol>)shareObject presenteController:(UIViewController *)presenteController success:(SocialRequestCompletionHandler)success cancle:(void (^)(void))cancle;

- (void)hidden;
@end
