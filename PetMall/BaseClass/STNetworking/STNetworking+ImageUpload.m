//
//  STNetworking+ImageUpload.m
//  SnailTruck
//
//  Created by imeng on 3/3/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STNetworking+ImageUpload.h"
#import "STQNTokenRequest.h"
#import "QNUploadManager.h"
NSString * const STQNImageResultKey = @"STQNImageResultKey";
NSString * const STQNImageResultImageURL = @"STQNImageResultImageURL";
NSString * const STQNImageResultResp = @"STQNImageResultResp";

@implementation STNetworking (ImageUpload)

+ (void)uploadImage:(UIImage *)image completionHandler:(STUpImageCompletionHandler)completionHandler {
    NSString *key = [STHelpTools getImageName];
    [self uploadImage:image key:key completionHandler:completionHandler];
}

+ (void)uploadImage:(UIImage *)image key:(NSString *)key completionHandler:(STUpImageCompletionHandler)completionHandler {
    STQNTokenRequest *tokenRequest = [[STQNTokenRequest alloc] init];
    [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof STQNTokenRequest * _Nonnull request) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            STQNTokenResponseEntity *entity = request.responseEntity;
            
            [self uploadImage:image key:key token:entity.upToken completionHandler:completionHandler];
        });
        
    } failure:^(__kindof GABaseRequest * _Nonnull request) {
        completionHandler(nil, nil ,nil, nil);
    }];
}

+ (void)uploadImage:(UIImage *)image key:(NSString *)key token:(NSString *)token completionHandler:(STUpImageCompletionHandler)completionHandler {
    if (![image isKindOfClass:[UIImage class]]) {
        NSAssert(0, @"%@ 必须传入UIImage对象", image);
        return;
    }
    
    UIImage *compressImage = [STHelpTools minImageFile:image wantSize:100 isWatermark:NO];
    NSData * imageDate = UIImageJPEGRepresentation(compressImage, 1);

    QNUploadManager *upload = [STNetworkingBusiness sharedSTNetworkingBusiness].imageUploadManager;

    [upload putData:imageDate key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        if (!resp) {
            NSLog(@"图片上传失败 %@ ", key);
            completionHandler(key, nil, token, nil);
            return;
        }

        NSString *imageURL = [NSString stringWithFormat:@"%@%@",[STNetworking imageHost],key];

        NSLog(@"图片上传成功 %@ \nimageURL %@", key, imageURL);
        completionHandler(key, imageURL ,token ,resp);
    } option:nil];
}

+ (void)uploadImages:(NSArray<UIImage*> *)images completionHandler:(STUpImagesCompletionHandler)completionHandler {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *_images = [images copy];

        NSMutableDictionary *infos = [NSMutableDictionary dictionaryWithCapacity:_images.count];
        NSMutableDictionary<NSNumber*,NSString*> *imageIndexKeyMap = [NSMutableDictionary dictionaryWithCapacity:_images.count];
        
        [_images enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *key = [STHelpTools getImageNameWithIndex:idx];
            infos[key] = obj;
            imageIndexKeyMap[@(idx)] = key;
        }];

        [self uploadImagesWithInfos:infos completionHandler:^(NSDictionary<NSString *,NSDictionary *> *result, NSArray<NSString*> *failureImages,NSString *uploadToken) {
            
            NSMutableArray *imageURLs = [NSMutableArray arrayWithCapacity:result.count];
            NSMutableArray *failureIndexs = [NSMutableArray arrayWithCapacity:failureImages.count];
            
            for (int i = 0; i < imageIndexKeyMap.count; i ++) {
                NSString *indexKey = imageIndexKeyMap[@(i)];
                NSDictionary *aResult = result[indexKey];
                if (result) {
                    NSString *URL = aResult[STQNImageResultImageURL];
                    [imageURLs addObject:URL];
                } else {
                    [failureIndexs addObject:@(i)];
                }
            }
            if (imageURLs.count == 0) {
                imageURLs = nil;
            }
            
            if (failureIndexs.count == 0) {
                failureIndexs = nil;
            }
            
            completionHandler(imageURLs, failureIndexs, uploadToken);
        }];
    });
}

+ (void)uploadImagesWithInfos:(NSDictionary<NSString*,UIImage*>*)infos completionHandler:(void (^)(NSDictionary<NSString*, NSDictionary*>*, NSArray<NSString*>*, NSString *uploadToken))completionHandler {
    
    STQNTokenRequest *tokenRequest = [[STQNTokenRequest alloc] init];
    [tokenRequest startWithCompletionBlockWithSuccess:^(__kindof STQNTokenRequest * _Nonnull request) {
        
        STQNTokenResponseEntity *entity = request.responseEntity;
        [self uploadImagesWithInfos:infos token:entity.upToken completionHandler:completionHandler];
        
    } failure:^(__kindof GABaseRequest * _Nonnull request) {
        completionHandler(nil, nil, nil);
    }];
}

+ (void)uploadImagesWithInfos:(NSDictionary<NSString *,UIImage *> *)infos token:(NSString *)token completionHandler:(void (^)(NSDictionary<NSString *,NSDictionary *> *, NSArray<NSString *> *, NSString *uploadToken))completionHandler {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        dispatch_group_t imageUploadGroup = dispatch_group_create();
        NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:infos.count];
        
        [infos enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
            dispatch_group_enter(imageUploadGroup);
            [self uploadImage:obj key:key token:token completionHandler:^(NSString *key, NSString *imageURL, NSString* uploadToken, NSDictionary *resp) {
                if (key && resp) {
                    NSDictionary *value = @{STQNImageResultImageURL: imageURL, STQNImageResultResp: resp};
                    result[key] = value;
                }
                
                dispatch_group_leave(imageUploadGroup);
            }];
        }];
        
        dispatch_group_notify(imageUploadGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSMutableArray *failureImages = [NSMutableArray array];
            for (NSString * key in infos) {
                if (!result[key]) {
                    [failureImages addObject:key];
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result.count > 0) {
                    completionHandler([result copy], [failureImages copy], token);
                } else {
                    completionHandler(nil, infos.allKeys, token);
                }
            });
        });
    });
}


@end
