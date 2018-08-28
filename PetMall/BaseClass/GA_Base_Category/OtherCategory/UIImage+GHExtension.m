//
//  UIImage+GHExtension.m
//  GHFrameWork
//
//  Created by GhGh on 15/10/14.
//  Copyright © 2015年 王光辉. All rights reserved.
//

#import "UIImage+GHExtension.h"
#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>

@interface UIImage ()
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size;
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality;
- (CGAffineTransform)transformForOrientation:(CGSize)newSize;
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight;
@end

@implementation UIImage (GHExtension)
- (id)reduceWithQualityPercent:(float)qualityPercent scaledPercent:(float)scaledPercent {
    @autoreleasepool {
        if (qualityPercent == 100.00 && scaledPercent == 1.00) {
            //无须压缩
            return self;
        }else{
            
            CGSize size = CGSizeMake(self.size.width * scaledPercent, self.size.height * scaledPercent);
            
            if (qualityPercent == 100) {
                //如果压缩质量为100,则图片质量无损压缩
                //比例压缩
                return [self imageWithImageSimpleScaledToSize:size];
            }else if (scaledPercent == 1.0) {
                //压缩比例为1，不进行压缩
                return [self reduceWithpercent:qualityPercent/100.00];
            }else {
                return [self reduceWithpercent:qualityPercent/100.00 scaledToSize:size];
            }
        }
    }
    return self;
}

- (NSData *)reduceWithpercent:(float)percent scaledToSize:(CGSize)newSize {
    
    @autoreleasepool {
        
        // Create a graphics image context
        UIGraphicsBeginImageContext(newSize);
        // new size
        [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    }
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    NSData *imageData = UIImageJPEGRepresentation(newImage, percent);
    return imageData;
}

- (NSData *)reduceWithpercent:(float)percent {
    
    NSData *imageData = UIImageJPEGRepresentation(self, percent);
    return imageData;
}

- (UIImage *)imageWithImageSimpleScaledToSize:(CGSize)newSize {
    
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    @autoreleasepool {
        // new size
        [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    }
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}






+ (instancetype)resizableImageWithName:(NSString *)imageName
{
    // 1.创建图片
    UIImage *image = [self imageNamed:imageName];
    
    // 2.计算多宽不拉伸
    CGFloat left = image.size.width * 0.5;
    CGFloat top = image.size.height * 0.5;
    // 3.生成拉伸不变形的图片
    /*
     1 =  width - leftCapWidth
     1 =  height - topCapWidth
     */
    image = [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
    
    // 4.返回图片
    return image;
}


+ (instancetype)waterImageWithBg:(UIImage *)bgImage logo:(NSString *)logo
{
    // 1.创建一个基于位图的上下文(开启一个基于位图的上下文)
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    // 2.画背景
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    // 3.画右下角的水印
    NSString * textWater = logo;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    // NSForegroundColorAttributeName : 文字颜色
    // NSFontAttributeName : 字体
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    CGFloat w = bgImage.size.width;
    CGFloat h = bgImage.size.height/6;
    [textWater drawInRect:CGRectMake(0, 0, w, h) withAttributes:attrs];
    // 4.从上下文中取得制作完毕的UIImage对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 5.结束上下文
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 通过Color快速创建一个UIImage
 */
+(UIImage *)imageFromContextWithColor:(UIColor *)color
{
    CGRect rect=(CGRect){{0.0f,0.0f},{1,1}};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
/**
 通过Color & Size快速创建一个UIImage
 */
+(UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect=(CGRect){{0.0f,0.0f},size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
// 初始化使用
+(id)initImageViewRect:(CGRect )rect andImage:(UIImage *)image andUserInteractionEnabled:(BOOL)enable
{
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.userInteractionEnabled = enable;
    imageView.image = image;
    return imageView;
}

















/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


///////////////////////
// private

- (void)addRoundedRectToPath:(CGContextRef)context rect:(CGRect)rect radius:(float)radius {
    CGContextBeginPath(context);
    CGContextSaveGState(context);
    
    if (radius == 0) {
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextAddRect(context, rect);
    } else {
        CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM(context, radius, radius);
        float fw = CGRectGetWidth(rect) / radius;
        float fh = CGRectGetHeight(rect) / radius;
        
        CGContextMoveToPoint(context, fw, fh/2);
        CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
        CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
        CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
        CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    }
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

+ (UIImage*)imageWithContentsOfURL:(NSURL*)url {
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfURL:url options:0 error:&error];
    if(error || !data) {
        return nil;
    } else {
        return [UIImage imageWithData:data];
    }
}

- (UIImage*)transformWidth:(CGFloat)width height:(CGFloat)height rotate:(BOOL)rotate {
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    if (rotate) {
        if (self.imageOrientation == UIImageOrientationRight
            || self.imageOrientation == UIImageOrientationLeft) {
            sourceW = height;
            sourceH = width;
        }
    }
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL, destW, destH,
                                                CGImageGetBitsPerComponent(imageRef), 4*destW, CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    if (rotate) {
        if (self.imageOrientation == UIImageOrientationDown) {
            CGContextTranslateCTM(bitmap, sourceW, sourceH);
            CGContextRotateCTM(bitmap, 180 * (M_PI/180));
        } else if (self.imageOrientation == UIImageOrientationLeft) {
            CGContextTranslateCTM(bitmap, sourceH, 0);
            CGContextRotateCTM(bitmap, 90 * (M_PI/180));
        } else if (self.imageOrientation == UIImageOrientationRight) {
            CGContextTranslateCTM(bitmap, 0, sourceW);
            CGContextRotateCTM(bitmap, -90 * (M_PI/180));
        }
    }
    
    CGContextDrawImage(bitmap, CGRectMake(0,0,sourceW,sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* result = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return result;
}

- (void)drawInRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
    BOOL clip = NO;
    CGRect originalRect = rect;
    if (self.size.width != rect.size.width || self.size.height != rect.size.height) {
        if (contentMode == UIViewContentModeLeft) {
            rect = CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeRight) {
            rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeTop) {
            rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y,
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeBottom) {
            rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeCenter) {
            rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - self.size.width/2),
                              rect.origin.y + floor(rect.size.height/2 - self.size.height/2),
                              self.size.width, self.size.height);
        } else if (contentMode == UIViewContentModeBottomLeft) {
            rect = CGRectMake(rect.origin.x,
                              rect.origin.y + floor(rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeBottomRight) {
            rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y + (rect.size.height - self.size.height),
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeTopLeft) {
            rect = CGRectMake(rect.origin.x,
                              rect.origin.y,
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeTopRight) {
            rect = CGRectMake(rect.origin.x + (rect.size.width - self.size.width),
                              rect.origin.y,
                              self.size.width, self.size.height);
            clip = YES;
        } else if (contentMode == UIViewContentModeScaleAspectFill) {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width) {
                imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
            } else {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width = rect.size.width;
            }
            rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width, imageSize.height);
        } else if (contentMode == UIViewContentModeScaleAspectFit) {
            CGSize imageSize = self.size;
            if (imageSize.height < imageSize.width) {
                imageSize.height = floor((imageSize.height/imageSize.width) * rect.size.width);
                imageSize.width = rect.size.width;
            } else {
                imageSize.width = floor((imageSize.width/imageSize.height) * rect.size.height);
                imageSize.height = rect.size.height;
            }
            rect = CGRectMake(rect.origin.x + floor(rect.size.width/2 - imageSize.width/2),
                              rect.origin.y + floor(rect.size.height/2 - imageSize.height/2),
                              imageSize.width, imageSize.height);
        }
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (clip) {
        CGContextSaveGState(context);
        CGContextAddRect(context, originalRect);
        CGContextClip(context);
    }
    
    [self drawInRect:rect];
    
    if (clip) {
        CGContextRestoreGState(context);
    }
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius {
    [self drawInRect:rect radius:radius contentMode:UIViewContentModeScaleToFill];
}

- (void)drawInRect:(CGRect)rect radius:(CGFloat)radius contentMode:(UIViewContentMode)contentMode {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    if (radius) {
        [self addRoundedRectToPath:context rect:rect radius:radius];
        CGContextClip(context);
    }
    
    [self drawInRect:rect contentMode:contentMode];
    
    CGContextRestoreGState(context);
}

- (UIImage*)scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), self.CGImage);
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (UIImage*)scaleAndCropToSize:(CGSize)size {
    if(size.height > size.width) {
        if(self.size.height > self.size.width) {
            if((self.size.width  / self.size.height) >= (size.width / size.height)) {
                return [self scaleHeightAndCropWidthToSize:size];
            } else {
                return [self scaleWidthAndCropHeightToSize:size];
            }
        } else {
            return [self scaleHeightAndCropWidthToSize:size];
        }
    } else {
        if(self.size.width > self.size.height) {
            if((self.size.height / self.size.width) >= (size.height / size.width)) {
                return [self scaleWidthAndCropHeightToSize:size];
            } else {
                return [self scaleHeightAndCropWidthToSize:size];
            }
        } else {
            return [self scaleWidthAndCropHeightToSize:size];
        }
    }
}

- (UIImage*)scaleHeightAndCropWidthToSize:(CGSize)size {
    float newWidth = (self.size.width * size.height) / self.size.height;
    return [self scaleToSize:size withOffset:CGPointMake((newWidth - size.width) / 2, 0.0f)];
}

- (UIImage*)scaleWidthAndCropHeightToSize:(CGSize)size {
    float newHeight = (self.size.height * size.width) / self.size.width;
    return [self scaleToSize:size withOffset:CGPointMake(0, (newHeight - size.height) / 2)];
}

- (UIImage*)scaleToSize:(CGSize)size withOffset:(CGPoint)offset {
    UIImage* scaledImage = [self scaleToSize:CGSizeMake(size.width + (offset.x * -2), size.height + (offset.y * -2))];
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect croppedRect;
    croppedRect.size = size;
    croppedRect.origin = CGPointZero;
    
    CGContextClipToRect(context, croppedRect);
    
    CGRect drawRect;
    drawRect.origin = offset;
    drawRect.size = scaledImage.size;
    
    CGContextDrawImage(context, drawRect, scaledImage.CGImage);
    
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return croppedImage;
}

// Returns true if the image has an alpha layer
- (BOOL)hasAlpha {
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(self.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

// Returns a copy of the given image, adding an alpha channel if it doesn't already have one
- (UIImage *)imageWithAlpha {
    if ([self hasAlpha]) {
        return self;
    }
    
    CGImageRef imageRef = self.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL,
                                                          width,
                                                          height,
                                                          8,
                                                          0,
                                                          CGImageGetColorSpace(imageRef),
                                                          kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    
    // Draw the image into the context and retrieve the new image, which will now have an alpha layer
    CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), imageRef);
    CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(offscreenContext);
    UIImage *imageWithAlpha = [UIImage imageWithCGImage:imageRefWithAlpha];
    
    // Clean up
    CGContextRelease(offscreenContext);
    CGImageRelease(imageRefWithAlpha);
    
    return imageWithAlpha;
}

// Returns a copy of the image with a transparent border of the given size added around its edges.
// If the image has no alpha layer, one will be added to it.
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    CGRect newRect = CGRectMake(0, 0, image.size.width + borderSize * 2, image.size.height + borderSize * 2);
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(self.CGImage),
                                                0,
                                                CGImageGetColorSpace(self.CGImage),
                                                CGImageGetBitmapInfo(self.CGImage));
    
    // Draw the image in the center of the context, leaving a gap around the edges
    CGRect imageLocation = CGRectMake(borderSize, borderSize, image.size.width, image.size.height);
    CGContextDrawImage(bitmap, imageLocation, self.CGImage);
    CGImageRef borderImageRef = CGBitmapContextCreateImage(bitmap);
    
    // Create a mask to make the border transparent, and combine it with the image
    CGImageRef maskImageRef = [self newBorderMask:borderSize size:newRect.size];
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(borderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

#pragma mark -
#pragma mark Private helper methods

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

// Creates a mask that makes the outer edges transparent and everything else opaque
// The size must include the entire mask (opaque part + transparent border)
// The caller is responsible for releasing the returned reference by calling CGImageRelease
- (CGImageRef)newBorderMask:(NSUInteger)borderSize size:(CGSize)size {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Build a context that's the same dimensions as the new size
    CGContextRef maskContext = CGBitmapContextCreate(NULL,
                                                     size.width,
                                                     size.height,
                                                     8, // 8-bit grayscale
                                                     0,
                                                     colorSpace,
                                                     kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    
    // Start with a mask that's entirely transparent
    CGContextSetFillColorWithColor(maskContext, [UIColor blackColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height));
    
    // Make the inner part (within the border) opaque
    CGContextSetFillColorWithColor(maskContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(maskContext, CGRectMake(borderSize, borderSize, size.width - borderSize * 2, size.height - borderSize * 2));
    
    // Get an image of the context
    CGImageRef maskImageRef = CGBitmapContextCreateImage(maskContext);
    
    // Clean up
    CGContextRelease(maskContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

// Returns a copy of this image that is cropped to the given bounds.
// The bounds will be adjusted using CGRectIntegral.
// This method ignores the image's imageOrientation setting.
- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

// Returns a copy of this image that is squared to the thumbnail size.
// If transparentBorder is non-zero, a transparent border of the given size will be added around the edges of the thumbnail. (Adding a transparent border of at least one pixel in size has the side-effect of antialiasing the edges of the image when rotating it using Core Animation.)
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality {
    UIImage *resizedImage = [self resizedImageWithContentMode:UIViewContentModeScaleAspectFill
                                                       bounds:CGSizeMake(thumbnailSize, thumbnailSize)
                                         interpolationQuality:quality];
    
    // Crop out any part of the image that's larger than the thumbnail size
    // The cropped rect must be centered on the resized image
    // Round the origin points so that the size isn't altered when CGRectIntegral is later invoked
    CGRect cropRect = CGRectMake(round((resizedImage.size.width - thumbnailSize) / 2),
                                 round((resizedImage.size.height - thumbnailSize) / 2),
                                 thumbnailSize,
                                 thumbnailSize);
    UIImage *croppedImage = [resizedImage croppedImage:cropRect];
    
    UIImage *transparentBorderImage = borderSize ? [croppedImage transparentBorderImage:borderSize] : croppedImage;
    
    return [transparentBorderImage roundedCornerImage:cornerRadius borderSize:borderSize];
}

// Returns a rescaled copy of the image, taking into account its orientation
// The image will be scaled disproportionately if necessary to fit the bounds specified by the parameter
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality {
    BOOL drawTransposed;
    
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            drawTransposed = YES;
            break;
            
        default:
            drawTransposed = NO;
    }
    
    return [self resizedImage:newSize
                    transform:[self transformForOrientation:newSize]
               drawTransposed:drawTransposed
         interpolationQuality:quality];
}

// Resizes the image according to the given content mode, taking into account the image's orientation
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality {
    CGFloat horizontalRatio = bounds.width / self.size.width;
    CGFloat verticalRatio = bounds.height / self.size.height;
    CGFloat ratio;
    
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill:
            ratio = MAX(horizontalRatio, verticalRatio);
            break;
            
        case UIViewContentModeScaleAspectFit:
            ratio = MIN(horizontalRatio, verticalRatio);
            break;
            
        default:
            [NSException raise:NSInvalidArgumentException format:@"Unsupported content mode: %ld", (long)contentMode];
    }
    
    CGSize newSize = CGSizeMake(self.size.width * ratio, self.size.height * ratio);
    
    return [self resizedImage:newSize interpolationQuality:quality];
}

#pragma mark -
#pragma mark Private helper methods

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
- (UIImage *)resizedImage:(CGSize)newSize
                transform:(CGAffineTransform)transform
           drawTransposed:(BOOL)transpose
     interpolationQuality:(CGInterpolationQuality)quality {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGRect transposedRect = CGRectMake(0, 0, newRect.size.height, newRect.size.width);
    CGImageRef imageRef = self.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}

// Returns an affine transform that takes into account the image orientation when drawing a scaled image
- (CGAffineTransform)transformForOrientation:(CGSize)newSize {
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch ((Byte)self.imageOrientation) {
        case UIImageOrientationDown:           // EXIF = 3
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, newSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:           // EXIF = 6
        case UIImageOrientationLeftMirrored:   // EXIF = 5
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:          // EXIF = 8
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, 0, newSize.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
    }
    
    switch ((Byte)self.imageOrientation) {
        case UIImageOrientationUpMirrored:     // EXIF = 2
        case UIImageOrientationDownMirrored:   // EXIF = 4
            transform = CGAffineTransformTranslate(transform, newSize.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:   // EXIF = 5
        case UIImageOrientationRightMirrored:  // EXIF = 7
            transform = CGAffineTransformTranslate(transform, newSize.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
    }
    
    return transform;
}

// Creates a copy of this image with rounded corners
// If borderSize is non-zero, a transparent border of the given size will also be added
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize {
    // If the image does not have an alpha layer, add one
    UIImage *image = [self imageWithAlpha];
    
    // Build a context that's the same dimensions as the new size
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 image.size.width,
                                                 image.size.height,
                                                 CGImageGetBitsPerComponent(image.CGImage),
                                                 0,
                                                 CGImageGetColorSpace(image.CGImage),
                                                 CGImageGetBitmapInfo(image.CGImage));
    
    // Create a clipping path with rounded corners
    CGContextBeginPath(context);
    [self addRoundedRectToPath:CGRectMake(borderSize, borderSize, image.size.width - borderSize * 2, image.size.height - borderSize * 2)
                       context:context
                     ovalWidth:cornerSize
                    ovalHeight:cornerSize];
    CGContextClosePath(context);
    CGContextClip(context);
    
    // Draw the image to the context; the clipping path will make anything outside the rounded rect transparent
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    // Create a CGImage from the context
    CGImageRef clippedImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create a UIImage from the CGImage
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    
    return roundedImage;
}

#pragma mark -
#pragma mark Private helper methods

// Adds a rectangular path to the given context and rounds its corners by the given extents
// Original author: Björn Sållarp. Used with permission. See: http://blog.sallarp.com/iphone-uiimage-round-corners/
- (void)addRoundedRectToPath:(CGRect)rect context:(CGContextRef)context ovalWidth:(CGFloat)ovalWidth ovalHeight:(CGFloat)ovalHeight {
    if (ovalWidth == 0 || ovalHeight == 0) {
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    CGFloat fw = CGRectGetWidth(rect) / ovalWidth;
    CGFloat fh = CGRectGetHeight(rect) / ovalHeight;
    CGContextMoveToPoint(context, fw, fh/2);
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1);
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}

-(UIImage *)resizableImageExtendWithCapInsets:(UIEdgeInsets)capInsets{
    UIImage *newImage = nil;
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        newImage = [self resizableImageWithCapInsets:capInsets];
    } else {
        newImage = [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
    
    return newImage;
}

+ (UIImage *)stretchableImageWithImage:(UIImage *)image top:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    if(image)
    {
        if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)])
        {
            return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right)];
        }
        else
        {
            return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
        }
    }
    return nil;
}

+ (UIImage*)getGrayImage:(UIImage*)sourceImage{
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;
//    CGColorSpaceCreateDeviceGray会创建一个设备相关的灰度颜色空间的引用
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    if (context == NULL) {
        return nil;
    }
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    return grayImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    @autoreleasepool {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return img;
    }
}

- (UIImage *)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            case UIImageOrientationLeft:
            case UIImageOrientationUp:
            case UIImageOrientationRight:
            case UIImageOrientationDown:
            break;
    }
    
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)compressImageWithScale:(CGFloat)scale
{
    float scaleWidth = self.size.width * scale;
    float scaleHeight = self.size.height * scale;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(CGSizeMake(scaleWidth, scaleHeight));
    [self drawInRect:CGRectMake(0, 0, scaleWidth, scaleHeight)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 附加方法 - 20161212
// Helper methods for thumbnailForAsset:maxPixelSize:
static size_t getAssetBytesCallback(void *info, void *buffer, off_t position, size_t count) {
    ALAssetRepresentation *rep = (__bridge id)info;
    
    NSError *error = nil;
    size_t countRead = [rep getBytes:(uint8_t *)buffer fromOffset:position length:count error:&error];
    
    if (countRead == 0 && error) {
        // We have no way of passing this info back to the caller, so we log it, at least.
        NSLog(@"thumbnailForAsset:maxPixelSize: got an error reading an asset: %@", error);
    }
    
    return countRead;
}

static void releaseAssetCallback(void *info) {
    // The info here is an ALAssetRepresentation which we CFRetain in thumbnailForAsset:maxPixelSize:.
    // This release balances that retain.
    CFRelease(info);
}

static CGImageSourceRef imageSourceRefFromAsset(ALAsset* asset) {
    ALAssetRepresentation *rep = [asset defaultRepresentation];
    CGDataProviderDirectCallbacks callbacks = {
        .version = 0,
        .getBytePointer = NULL,
        .releaseBytePointer = NULL,
        .getBytesAtPosition = getAssetBytesCallback,
        .releaseInfo = releaseAssetCallback,
    };
    CGDataProviderRef provider = CGDataProviderCreateDirect((void *)CFBridgingRetain(rep), [rep size], &callbacks);
    CGImageSourceRef src = CGImageSourceCreateWithDataProvider(provider, NULL);
    CFRelease(provider);
    return  src;
}




static CGSize sizeOfImageSourceRef(CGImageSourceRef src){
    CGSize imageSize = CGSizeZero;
    if (src) {
        NSDictionary *options = @{(NSString *)kCGImageSourceShouldCache: @(NO)};
        NSDictionary *properties = (__bridge_transfer NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, 0, (CFDictionaryRef)options);
        if (properties) {
            CGFloat width = [[properties objectForKey:(NSString *)kCGImagePropertyPixelWidth] floatValue];
            CGFloat height = [[properties objectForKey:(NSString *)kCGImagePropertyPixelHeight] floatValue];
            int ori = [[properties objectForKey:(NSString *)kCGImagePropertyOrientation] intValue];
            CGFloat w;
            CGFloat h;
            if (ori > 4) { // see EXIF
                w = height;
                h = width;
            } else {
                w = width;
                h = height;
            }
            imageSize = CGSizeMake(w, h);
        }
    }
    return imageSize;
}


static UIImage* drawImageOfSize(UIImage* oldImage, CGSize size){
    UIGraphicsBeginImageContext(size); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointMake(0, 0);
    thumbnailRect.size.width= size.width;
    thumbnailRect.size.height = size.height;
    [oldImage drawInRect:thumbnailRect];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark -- thumbnail
// Returns a UIImage for the given asset, with size length at most the passed size.
// The resulting UIImage will be already rotated to UIImageOrientationUp, so its CGImageRef
// can be used directly without additional rotation handling.
// This is done synchronously, so you should call this method on a background queue/thread.
+ (UIImage *)thumbnailForImageOfAsset:(ALAsset *)asset maxSidePixels:(NSUInteger)maxSidePixels {
    if (!asset || maxSidePixels <=0) {
        return nil;
    }
    
    CGImageSourceRef src = imageSourceRefFromAsset(asset);
    UIImage* result = [UIImage imageFromImageSourceRef:src withMaxSidePixels:maxSidePixels];
    CFRelease(src);
    return result;
}


+ (UIImage *)thumbnailForImageOfPath:(NSString *)imagePath maxSidePixels:(NSUInteger)maxSidePixels{
    return [self thumbnailForImageOfURL:[NSURL fileURLWithPath:imagePath] maxSidePixels:maxSidePixels];
}

+ (UIImage *)thumbnailForImageOfURL:(NSURL *)imageURL maxSidePixels:(NSUInteger)maxSidePixels {
    //NSParameterAssert(URL != nil && mps > 0);
    if (imageURL == nil || maxSidePixels <= 0) {
        return nil;
    }
    NSError *err;
    if ([imageURL checkResourceIsReachableAndReturnError:&err] == NO){
        return nil;
    }
    // Create the image source (from path)
    CGImageSourceRef src = CGImageSourceCreateWithURL((__bridge CFURLRef)imageURL, NULL);
    
    UIImage* result = [UIImage imageFromImageSourceRef:src withMaxSidePixels:maxSidePixels];
    CFRelease(src);
    return result;
}

+ (UIImage *)thumbnailForImageOfData:(NSData *)imageData maxSidePixels:(NSUInteger)maxSidePixels{
    if (!imageData || maxSidePixels <=0) {
        return nil;
    }
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef) imageData, NULL);
    UIImage* result = [UIImage imageFromImageSourceRef:src withMaxSidePixels:maxSidePixels];
    CFRelease(src);
    return result;
}

+ (UIImage*)imageFromImageSourceRef:(CGImageSourceRef)src withMaxSidePixels:(CGFloat)maxSidePixels{
    if (!src || maxSidePixels <= 0) {
        return nil;
    }
    // Create thumbnail options
    CFDictionaryRef options = (__bridge CFDictionaryRef) @{
                                                           (id) kCGImageSourceCreateThumbnailWithTransform : @YES,
                                                           (id) kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                           (id) kCGImageSourceThumbnailMaxPixelSize : @(maxSidePixels)
                                                           };
    // Generate the thumbnail
    CGImageRef thumbnail = CGImageSourceCreateThumbnailAtIndex(src, 0, options);
    
    UIImage *result = nil;
    if (thumbnail) {
        result = [UIImage imageWithCGImage:thumbnail];
    }
    CGImageRelease(thumbnail);
    return  result;
}



#pragma mark -- image resize

- (UIImage*)imageByScaledForSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0,0,size.width,size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage*)imageByCroppedInRect:(CGRect)rect
{
    
    
    CGFloat scale = self.scale;
    CGRect cropRect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeScale(scale, scale));
    
    CGImageRef croppedImage = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    UIImage *image = [UIImage imageWithCGImage:croppedImage scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(croppedImage);
    
    return image;
}

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
        scaleFactor = widthFactor; // scale to fit height
        else
        scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [self drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

#pragma mark -- image size

+ (CGSize)sizeOfImageOfAsset:(ALAsset *)asset{
    if (!asset) {
        return CGSizeZero;
    }
    CGImageSourceRef src = imageSourceRefFromAsset(asset);
    CGSize size = sizeOfImageSourceRef(src);
    CFRelease(src);
    return size;
}

+ (CGSize)sizeOfImageOfData:(NSData *)imageData{
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    CGSize size = sizeOfImageSourceRef(src);
    CFRelease(src);
    return size;
}

+ (CGSize)sizeOfImageOfPath:(NSString *)imagePath{
    return [UIImage sizeOfImageOfURL:[NSURL fileURLWithPath:imagePath]];
}

+ (CGSize)sizeOfImageOfURL:(NSURL *)imageURL{
    NSError *err;
    if ([imageURL checkResourceIsReachableAndReturnError:&err] == NO){
        return CGSizeZero;
    }
    CGImageSourceRef src = CGImageSourceCreateWithURL((CFURLRef)imageURL, NULL);
    CGSize size = sizeOfImageSourceRef(src);
    CFRelease(src);
    return size;
    
}

#pragma mark -- less than
- (UIImage*)imageOfMemorySizeLessThan:(CGFloat)kbSize{
    //rgba
    kbSize /=4;
    
    CGSize originalSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGFloat kbyteSize = originalSize.width * originalSize.height / 1024;
    if (kbyteSize <= kbSize) {
        return drawImageOfSize(self, originalSize);
    }
    
    CGFloat ratio = sqrt(kbyteSize / kbSize);
    return  drawImageOfSize(self, CGSizeMake(originalSize.width/ratio, originalSize.height/ratio));;
}

+ (UIImage*)imageOfPath:(NSString*)path withMemorySizeLessThan:(CGFloat)kbSize{
    return [UIImage imageOfURL:[NSURL fileURLWithPath:path] withMemorySizeLessThan:kbSize];
}

+ (UIImage*)imageOfURL:(NSURL*)url withMemorySizeLessThan:(CGFloat)kbSize{
    //rgba
    kbSize /=4;
    
    CGSize originalSize = [UIImage sizeOfImageOfURL:url];
    CGFloat kbyteSize = originalSize.width * originalSize.height / 1024;
    if (kbyteSize <= kbSize) {
        return [UIImage imageWithContentsOfFile:[url absoluteString]];
    }else{
        CGFloat ratio = sqrt(kbyteSize / kbSize);
        NSUInteger maxSidePixels = 0;
        if (originalSize.width > originalSize.height) {
            maxSidePixels = originalSize.width/ratio;
        }else{
            maxSidePixels = originalSize.height/ratio;
        }
        return [UIImage thumbnailForImageOfURL:url maxSidePixels:maxSidePixels];
    }
}

+ (UIImage*)imageOfData:(NSData*)data withMemorySizeLessThan:(CGFloat)kbSize{
    //rgba
    kbSize /=4;
    
    CGSize originalSize = [UIImage sizeOfImageOfData:data];
    CGFloat kbyteSize = originalSize.width * originalSize.height / 1024;
    if (kbyteSize <= kbSize) {
        return [UIImage imageWithData:data];
    }else{
        CGFloat ratio = sqrt(kbyteSize / kbSize);
        NSUInteger maxSidePixels = 0;
        if (originalSize.width > originalSize.height) {
            maxSidePixels = originalSize.width/ratio;
        }else{
            maxSidePixels = originalSize.height/ratio;
        }
        return [UIImage thumbnailForImageOfData:data maxSidePixels:maxSidePixels];
    }
}

+ (UIImage*)imageOfAsset:(ALAsset*)asset withMemorySizeLessThan:(CGFloat)kbSize{
    //rgba
    kbSize /=4;
    
    CGSize originalSize = [UIImage sizeOfImageOfAsset:asset];
    CGFloat kbyteSize = originalSize.width * originalSize.height / 1024;
    if (kbyteSize <= kbSize) {
        ALAssetRepresentation *representation = [asset defaultRepresentation];
        return [UIImage imageWithCGImage:representation.fullResolutionImage
                                   scale:[representation scale]
                             orientation:(UIImageOrientation)[representation orientation]];
    }else{
        CGFloat ratio = sqrt(kbyteSize / kbSize);
        NSUInteger maxSidePixels = 0;
        if (originalSize.width > originalSize.height) {
            maxSidePixels = originalSize.width/ratio;
        }else{
            maxSidePixels = originalSize.height/ratio;
        }
        return [UIImage thumbnailForImageOfAsset:asset maxSidePixels:maxSidePixels];
    }
}

@end
