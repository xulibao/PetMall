//
//  UIImage+GHExtension.h
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface UIImage (GHExtension)
// 压缩图片质量/图片尺寸
//压缩图片质量\图片尺寸
- (id)reduceWithQualityPercent:(float)qualityPercent scaledPercent:(float)scaledPercent;
/**
 *  根据图片名称创建一张拉伸不变形的图片
 *
 *  @param imageName 需要创建的图片名称
 *
 *  @return 拉伸不变形的图片
 */
+ (instancetype)resizableImageWithName:(NSString *)imageName;

/**
 *  打水印
 *
 *  @param bgImage   背景图片
 *  @param logo 右下角的水印图片
 */
+ (instancetype)waterImageWithBg:(UIImage *)bgImage logo:(NSString *)logo;

/**
 通过Color快速创建一个UIImage
 */
+(UIImage *)imageFromContextWithColor:(UIColor *)color;
/**
   通过Color & Size快速创建一个UIImage
 */
+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size;
// 初始化使用
+(id)initImageViewRect:(CGRect )rect andImage:(UIImage *)image andUserInteractionEnabled:(BOOL)enable;







/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/*
 * Creates an image from the contents of a URL
 */
+ (UIImage*)imageWithContentsOfURL:(NSURL*)url;

/*
 * Resizes and/or rotates an image.
 */
- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate;

/**
 * Draws the image using content mode rules.
 */
- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 * Draws the image as a rounded rectangle.
 */
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius;
- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode;

/*
 * Scales the image to the given size
 */
- (UIImage*)scaleToSize:(CGSize)size;

/*
 * Scales and crops the image to the given size
   对给定大小的图像进行修剪
 * Automatically detects the size/height and offset
   自动监测的大小/高度和偏移量
 * Sides of the image will be cropped so the result is centered
   图像的侧面会被裁剪，所以结果是居中的
 */
- (UIImage*)scaleAndCropToSize:(CGSize)size;

/*
 * Scales the height and crops the width to the size
 * Sides of the image will be cropped so the result is centered
 */
- (UIImage*)scaleHeightAndCropWidthToSize:(CGSize)size;

/*
 * Scales the width and crops the height to the size
 * Sides of the image will be cropped so the result is centered
 */
- (UIImage*)scaleWidthAndCropHeightToSize:(CGSize)size;

/*
 * Scales image to the size, crops to the offset
 * Provide offset based on scaled size, not original size
 *
 * Example:
 * Image is 640x480, scaling to 480x320
 * This will then scale to 480x360
 *
 * If you want to vertically center the image, set the offset to CGPointMake(0.0,-20.0f)
 * Now it will clip the top 20px, and the bottom 20px giving you the desired 480x320
 */
- (UIImage*)scaleToSize:(CGSize)size withOffset:(CGPoint)offset;

- (UIImage *)fixOrientation;
- (UIImage *)compressImageWithScale:(CGFloat)scale;

- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

/*
 *  extend stretchableImageWithLeftCapWidth:topCapHeight on ios5++
 *
 *  on ios4 make sure your capInsets's left as stretchableImageWithLeftCapWidth:topCapHeight 's width and capInsets'top as stretchableImageWithLeftCapWidth:topCapHeight 's height
 *  on ios5&ios5++ like call resizableImageWithCapInsets:
 */
- (UIImage *)resizableImageExtendWithCapInsets:(UIEdgeInsets)capInsets;
// 拉伸不变形
+ (UIImage *)stretchableImageWithImage:(UIImage *)image top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
+ (UIImage*)getGrayImage:(UIImage*)sourceImage;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 * 根据传入最大边长等比缩放图片，返回缩略图。支持大图的读取。
 * 如果maxSidePixels > max(image.size.width, image.size.height),则返回原图；
 * 如果maxSidePixels < max(image.size.width, image.size.height),则返回等比缩放之后的图片；
 * @param maxSidePixels 最大边长
 * @param asset 本地文件路径
 */

+ (UIImage *)thumbnailForImageOfAsset:(ALAsset *)asset maxSidePixels:(NSUInteger)maxSidePixels;

+ (UIImage *)thumbnailForImageOfPath:(NSString *)imagePath maxSidePixels:(NSUInteger)maxSidePixels;

+ (UIImage *)thumbnailForImageOfURL:(NSURL *)imageURL maxSidePixels:(NSUInteger)maxSidePixels;

+ (UIImage *)thumbnailForImageOfData:(NSData *)imageData maxSidePixels:(NSUInteger)maxSidePixels;


/**
 * 获取图片尺寸。
 */
+ (CGSize)sizeOfImageOfAsset:(ALAsset *)asset;

+ (CGSize)sizeOfImageOfPath:(NSString *)imagePath;

+ (CGSize)sizeOfImageOfURL:(NSURL *)imageURL;

+ (CGSize)sizeOfImageOfData:(NSData *)imageData;


/**
 * 等比缩放之后，获取重绘图片，总大小小于kbSize。
 */
- (UIImage*)imageOfMemorySizeLessThan:(CGFloat)kbSize;

+ (UIImage*)imageOfPath:(NSString*)path withMemorySizeLessThan:(CGFloat)kbSize;

+ (UIImage*)imageOfURL:(NSURL*)url withMemorySizeLessThan:(CGFloat)kbSize;

+ (UIImage*)imageOfData:(NSData*)data withMemorySizeLessThan:(CGFloat)kbSize;

+ (UIImage*)imageOfAsset:(ALAsset*)asset withMemorySizeLessThan:(CGFloat)kbSize;


/**
 * 直接裁剪。根据传入矩形，裁剪图片。如果裁剪矩形rect的区域大于或者有大于图片矩形的尺寸，将会按照两个矩形的交集进行裁剪。
 * 返回裁剪后的图片。
 */
- (UIImage*)imageByCroppedInRect:(CGRect)rect;


/**
 * 非等比缩略绘制。根据传入矩形，进行非等比缩略绘制。
 * 返回缩放重绘之后的图片。
 */
- (UIImage*)imageByScaledForSize:(CGSize)size;


/**
 * 等比缩略裁剪。根据传入矩形，进行等比缩略裁剪，即先等比缩放，再裁剪。
 * 返回等比缩放裁剪后的图片。
 */
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;
@end
