//
//  ShareMainView.m
//  PodTest
//
//  Created by 木鱼 on 16/8/2.
//  Copyright © 2016年 木鱼. All rights reserved.
//

#import "ShareMainView.h"
#import "ShareButtomBar.h"

#import "ShareManager.h"
//#import <YYWebImage/YYWebImage.h>



@interface ShareMainView ()<ShareMenuViewDelegate>

@property (nonatomic, strong) ShareMenuView   *menuView;
@property (nonatomic, strong) UIButton        *cover;
@property (nonatomic, assign) BOOL            isShow;
@property (nonatomic, strong) ShareButtomBar *buttomBar;

@property (nonatomic,   copy) NSString        *title;
@property (nonatomic,   copy) NSString        *message;
@property (nonatomic,   copy) UIImage         *shareImage;
@property (nonatomic,   copy) NSString        *shareUrl;
@property (nonatomic, strong) UIViewController   *presenteController;
@property (nonatomic, strong) NSDictionary    *info;// 有梦统计id

@property(nonatomic, copy) SocialRequestCompletionHandler successBlock;


@end

@implementation ShareMainView

+ (instancetype)shareMainViewWithPlatform:(NSArray *)platforms {
    
    return [[self alloc] initWithPlatform:platforms];
}

- (instancetype)initWithPlatform:(NSArray *)platforms {
  
    if (self =[super init]) {
        
        self.platforms = platforms;
        [self initViews];
    }
    return self;
}

- (void)showShareTitle:(NSString *)title message:(NSString *)message shareImage:(UIImage *)shareImage shareUrl:(NSString *)shareUrl info:(NSDictionary *)info presenteController:(UIViewController *)presenteController success:(SocialRequestCompletionHandler)success cancle:(void (^)(void))cancle {
   
    self.successBlock = success;
    self.title = title;
    self.message = message;
    self.shareUrl = shareUrl;
    self.shareImage = shareImage;
    self.presenteController = presenteController;
    self.info = info;
    self.menuView.backGround =presenteController.view;
    self.menuView.isMoveIn = YES;
    self.cover.alpha = 0.0;
    
    self.buttomBar.isRotate = YES;
    [UIView animateWithDuration:0.15 animations:^{
        self.cover.alpha = 0.4;
        self.menuView.transform= CGAffineTransformMakeTranslation(0,-self.menuView.frame.size.height-kIphoneXBottomHeight);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)showWithShareObject:(id<STShareProtocol>)shareObject presenteController:(UIViewController *)presenteController success:(SocialRequestCompletionHandler)success cancle:(void (^)(void))cancle{
    if (self.isShow) return;
    NSAssert([shareObject respondsToSelector:@selector(st_ShareTitle)], @"%@ 需要实现st_ShareTitle方法", shareObject);
    NSAssert([shareObject respondsToSelector:@selector(st_ShareContent)], @"%@ 需要实现st_ShareContent方法", shareObject);
    
    NSString *title = [shareObject respondsToSelector:@selector(st_ShareTitle)] ? [shareObject st_ShareTitle] : @"";
    NSString *content = [shareObject respondsToSelector:@selector(st_ShareContent)] ? [shareObject st_ShareContent] : @"";

    NSURL *shareUrl = [shareObject respondsToSelector:@selector(st_ShareURL)] ? [shareObject st_ShareURL] : nil;
    UIImage *shareImage = [shareObject respondsToSelector:@selector(st_ShareImage)] ? [shareObject st_ShareImage] : nil;
    NSURL *shareImageURL = [shareObject respondsToSelector:@selector(st_ShareImageURL)] ? [shareObject st_ShareImageURL] : nil;
    
    NSNumber *shareIdentifier = [shareObject respondsToSelector:@selector(st_ShareIdentifier)] ? [shareObject st_ShareIdentifier] : nil;
    
    NSDictionary *info = shareIdentifier ? @{@"id": shareIdentifier} : nil;
    
    if (!shareImage && shareImageURL) {//无图片时使用图片URL填充
//        @weakify(self);
        [self stuffShareImageWithURL:shareImageURL compation:^(UIImage *image, NSError *error) {
//            @strongify(self)
            [self showShareTitle:title message:content shareImage:image shareUrl:shareUrl.absoluteString info:info presenteController:presenteController success:success cancle:cancle];
        }];
        return;
    }
    
    [self showShareTitle:title message:content shareImage:shareImage shareUrl:shareUrl.absoluteString info:info presenteController:presenteController success:success cancle:cancle];
}

- (void)hidden {
    
    self.cover.alpha = 0.4;
    self.buttomBar.isRotate = NO;
    self.menuView.isMoveIn = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.15 animations:^{
            self.cover.alpha = 0.0;
            self.menuView.transform= CGAffineTransformMakeTranslation(0,MainHeight);
            
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    });
}

- (void)initViews{
    
    CGFloat menuHeight = ShareItemHeight + ButtomViewHeight;

    if (self.platforms.count > 0) {
        NSInteger row  = self.platforms.count / 3 + 1;
        menuHeight = row * ShareItemHeight + ButtomViewHeight;
    }
    
    self.cover = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cover.frame = CGRectMake(0, 0, MainWidth, MainHeight - menuHeight);
    [self.cover setBackgroundColor:[UIColor blackColor]];
    [self.cover addTarget:self action:@selector(clickButtomBar) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cover];
    
    self.menuView = [[ShareMenuView alloc] initWithFrame:CGRectMake(0, MainHeight, MainWidth, menuHeight)];
//    self.menuView.backgroundColor= [UIColor whiteColor];
    self.menuView.delegate = self;
    self.menuView.platforms = self.platforms;
    self.menuView.userInteractionEnabled = YES;
    [self addSubview:self.menuView];
    
    self.buttomBar =[ShareButtomBar buttonWithType:UIButtonTypeCustom];
    self.buttomBar.frame = CGRectMake(0, menuHeight - ButtomViewHeight, MainWidth, ButtomViewHeight);
    [self.buttomBar addTarget:self action:@selector(clickButtomBar) forControlEvents:UIControlEventTouchUpInside];
    [self.menuView addSubview:self.buttomBar];
    
}

- (void)selectPlatform:(ShareItem *)item {
    
    [ShareManager shareWithPlatformType:item.platformType title:self.title shareText:self.message image:self.shareImage shareUrl:self.shareUrl location:nil presenteController:self.presenteController completion:self.successBlock];

    [self hidden];
    
    [self sharePlatformTypeAndVehicleStatisticsWithPlatformType:item.platformType];
}

- (void)clickButtomBar {
    [self hidden];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.frame = CGRectMake(0, 0, MainWidth, MainHeight);
}

//统计车辆分享到各平台次数
- (void)sharePlatformTypeAndVehicleStatisticsWithPlatformType:(SharePlatformType)platformType{
    
    
    if (!self.info) return;
    switch (platformType) {
        case SharePlatformTypeForQQ:
    [STHelpTools event:CarShare_QQ attributes:self.info isNeedUserId:YES andIsNeedCity:YES];
            break;
        case SharePlatformTypeForQQZone:
    [STHelpTools event:CarShare_QQZONE attributes:self.info isNeedUserId:YES andIsNeedCity:YES];
            break;
        case SharePlatformTypeForToSms:
    [STHelpTools event:CarShare_SMS attributes:self.info isNeedUserId:YES andIsNeedCity:YES];
            break;
        case SharePlatformTypeForWeChat:
    [STHelpTools event:CarShare_WX attributes:self.info isNeedUserId:YES andIsNeedCity:YES];
            break;
        case SharePlatformTypeForWechatTimeline:
    [STHelpTools event:CarShare_WXTimeLine attributes:self.info isNeedUserId:YES andIsNeedCity:YES];
            break;
        default:
            break;
    }
}

#pragma mark - Helper

- (void)stuffShareImageWithURL:(NSURL *)imageURL compation:(void (^)(UIImage *image, NSError *error))completion {
    YYWebImageManager *manager = [YYWebImageManager sharedManager];
    //从缓存中加载图片
    UIImage *imageFromMemory = [manager.cache getImageForKey:[manager cacheKeyForURL:imageURL] withType:YYImageCacheTypeAll];
    
    if (!imageFromMemory) {
        //下载图片
        [manager requestImageWithURL:imageURL options:kNilOptions progress:nil transform:nil completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            dispatch_main_sync_safe(^{
                if (!error) {
                    completion ? completion(image,nil) : nil;
                } else {
                    completion ? completion(nil,error) : nil;
                }
            });
        }];
    } else {
        completion ? completion(imageFromMemory,nil) : nil;
    }
}

@end
