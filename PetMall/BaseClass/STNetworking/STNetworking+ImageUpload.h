//
//  STNetworking+ImageUpload.h
//  SnailTruck
//
//  Created by imeng on 3/3/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import "STNetworking.h"

extern NSString * const STQNImageResultKey;
extern NSString * const STQNImageResultImageURL;
extern NSString * const STQNImageResultResp;

/**
 上传单张图片完成后的回调函数

 @param key 上传时指定的key，原样返回
 @param imageURL image 的 URL
 @param resp QNUpCompletionHandler 中定义的 resp
 */
typedef void (^STUpImageCompletionHandler)(NSString *key, NSString *imageURL, NSString *uploadToken, NSDictionary *resp);


/**
 上传多张图片完成后的回调函数

 @param imageURLs 上传成功的 imageURL 组
 @param failureIndexs 上传失败的 imageIndex
 */
typedef void (^STUpImagesCompletionHandler)(NSArray<NSString*> * imageURLs,NSArray<NSNumber*>* failureIndexs, NSString *uploadToken);

@interface STNetworking (ImageUpload)


/**
 上传单张图片

 @param image 待上传的UIImage
 @param completionHandler 上传完成后的回调函数
 */
+ (void)uploadImage:(UIImage *)image completionHandler:(STUpImageCompletionHandler)completionHandler;

/**
 上传单张图片
 
 @param image 待上传的UIImage
 @param key 自定义的key
 @param completionHandler 上传完成后的回调函数
 */
+ (void)uploadImage:(UIImage *)image key:(NSString *)key token:(NSString *)token completionHandler:(STUpImageCompletionHandler)completionHandler;


/**
 上传多张图片

 @param images 待上传的UIImage
 @param completionHandler 上传完成后的回调函数
 */
+ (void)uploadImages:(NSArray<UIImage*> *)images completionHandler:(STUpImagesCompletionHandler)completionHandler;


/**
 上传多张图片
 */
+ (void)uploadImagesWithInfos:(NSDictionary<NSString*,UIImage*>*)infos completionHandler:(void (^)(NSDictionary<NSString*, NSDictionary*>*, NSArray<NSString*>*, NSString *uploadToken))completionHandler;

@end
