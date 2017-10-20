//
//  UIImage+ImageAction.m
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import "UIImage+ImageAction.h"

@implementation UIImage (ImageAction)


#pragma mark - 拉伸图片
+ (UIImage *)pullImage:(UIImage *)sourceImage
{
    //设置端盖的值
    CGFloat top = sourceImage.size.height *0.5;
    CGFloat left = sourceImage.size.width *0.5;
    CGFloat bottom = sourceImage.size.height *0.5;
    CGFloat right = sourceImage.size.width *0.5;
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    //设置拉伸的模式
    UIImageResizingMode model = UIImageResizingModeStretch;
    UIImage *newImage = [sourceImage resizableImageWithCapInsets:edgeInsets resizingMode:model];
    return newImage;
}

#pragma mark - 截取图片

#pragma mark ==按指定的位置大小截取图中的一部分

+ (UIImage *)clipSubImageFromImage:(UIImage *)sourceImage inSubRect:(CGRect)rect
{
    CGImageRef sourceImageRef = [sourceImage CGImage];
    CGImageRef newIamgeRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newIamgeRef];
    return newImage;
}

#pragma mark ==根据给定的size的宽高比自动缩放原图片,自动判断截取位置,进行图片截取

+ (UIImage *)adaptiveClipImage:(UIImage *)sourceImage toRect:(CGSize)size
{
    //被切图片的宽比例小于或者等于高比例,以图片宽进行放大
    if (sourceImage.size.width *size.height <= sourceImage.size.height *size.width) {
        //以被裁剪图片的宽度为基准,得到剪切范围的大小
        CGFloat width = sourceImage.size.width;
        CGFloat height = sourceImage.size.width * size.height/size.width;
        //调用剪切方法
        //这里是以中心位置剪切,也可以通过改变rect的想x,y值调整剪切位置
        return [self clipSubImageFromImage:sourceImage inSubRect:CGRectMake(0, (sourceImage.size.height - height)/2, width, height)];
    }else{//被切图片宽比例大于高的比例,以图片高进行裁剪
        CGFloat width = sourceImage.size.height * size.width / size.height;
        CGFloat height = sourceImage.size.height;
        return [self clipSubImageFromImage:sourceImage inSubRect:CGRectMake((sourceImage.size.width - width)/2, 0, width, height)];
    }
    return nil;
}
#pragma mark - 压缩图片

#pragma mark ==压缩图片至目标大小
+ (UIImage *)compressImageSize:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth
{
    CGSize imageSize = sourceImage.size;    //原图大小
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetHeight = (targetWidth/width)*height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}



#pragma mark ==按比例缩放
+ (UIImage *)imageCompressForWithScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    UIImage *newImage = nil;
    
    CGFloat width = sourceImage.size.width;
    CGFloat height = sourceImage.size.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height/(width/targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaleWidth = targetWidth;
    CGFloat scaleHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if (CGSizeEqualToSize(sourceImage.size, size) == NO) {
        CGFloat widthFactor = targetWidth/width;
        CGFloat heightFactor = targetHeight/height;
        
        if (widthFactor > heightFactor) {
            scaleFactor = widthFactor;
        }else{
            scaleFactor = heightFactor;
        }
        
        scaleWidth = width *scaleFactor;
        scaleHeight = height *scaleFactor;
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaleHeight) *0.5;
        }else if (widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth -scaleWidth)*0.5;
        }

    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaleWidth;
    thumbnailRect.size.height = scaleHeight;
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if (newImage == nil) {
        NSLog(@"新图片时空的");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark ==压缩图片至指定尺寸
+ (UIImage *)compressImage:(UIImage *)sourceImage toSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    [sourceImage drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark ==压缩图片至指定像素
+ (UIImage *)compressImage:(UIImage *)sourceImage toPx:(CGFloat)pixel
{
    CGSize size = sourceImage.size;
    if (size.width <= pixel && size.height <= pixel) {
        return sourceImage;
    }
    CGFloat scale = size.width/size.height;
    if (size.width > size.height) {
        size.width = pixel;
        size.height = size.width/scale;
    }else{
        size.height = pixel;
        size.width = size.height * scale;
    }
    return [UIImage compressImage:sourceImage toSize:size];
}


#pragma mark - 生成图片

#pragma mark ==根据size生成一个平铺的图片
- (UIImage *)generateImageWithSize:(CGSize)size
{
    UIView *tempView = [[UIView alloc]init];
    tempView.bounds = CGRectMake(0, 0, size.width, size.height);
    tempView.backgroundColor = [UIColor colorWithPatternImage:self];
    
    UIGraphicsBeginImageContext(size);
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark ==UIview转化为UIImage
+ (UIImage *)generateImageWithView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark ==将两个图片生成一张图片

+ (UIImage *)mergeImageWithFirstImage:(UIImage *)firstImage withSecondImage:(UIImage *)secondImage
{
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeigh = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeigh, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeigh)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 颜色

#pragma mark ==生成纯色的图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark ==获取图片某一像素的颜色

- (UIColor *)colorWithImagePixel:(CGPoint)point
{
    if (!CGRectContainsPoint(CGRectMake(0, 0, self.size.width, self.size.height), point)) {
        return nil;
    }
    
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int byteesPerPixel = 4;
    int bytesPerRow = byteesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0,0,0,0};
    CGContextRef context = CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - 获得灰度图片
- (UIImage *)convertToGrayImage
{
    int width = self.size.width;
    int height = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil,width,height,8,0,colorSpace,kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL)
    {
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef contextRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:contextRef];
    CGContextRelease(context);
    CGImageRelease(contextRef);
    
    return grayImage;
}


#pragma mark - 旋转图片

#pragma mark ==按给定方向旋转
+ (UIImage *)rotateImage:(UIImage *)sourceImage withOrientation:(UIImageOrientation)orientation
{
    CGRect bounds = CGRectZero;
    UIImage *copy = nil;
    CGContextRef ctxt = nil;
    CGImageRef image = sourceImage.CGImage;
    CGRect rect = CGRectZero;
    
    CGAffineTransform tran = CGAffineTransformIdentity;
    rect.size.width = CGImageGetWidth(image);
    rect.size.height = CGImageGetWidth(image);
    
    bounds = rect;
    
    switch (orientation) {
        case UIImageOrientationUp:
        {
            return sourceImage;
            break;
        }
        case UIImageOrientationUpMirrored:
        {
            tran = CGAffineTransformMakeTranslation(rect.size.width, 0.0);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            break;
        }
        case UIImageOrientationDown:
        {
            tran = CGAffineTransformMakeTranslation(rect.size.width,rect.size.height);
            tran = CGAffineTransformRotate(tran, M_PI);
            break;
        }
        case UIImageOrientationDownMirrored:
        {
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.height);
            tran = CGAffineTransformScale(tran, 1.0, -1.0);
            break;
        }
        case UIImageOrientationLeft:
        {
            bounds = swapWidthAndHeight(bounds);
            tran = CGAffineTransformMakeTranslation(0.0, rect.size.width);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationLeftMirrored:
        {
            bounds = swapWidthAndHeight(bounds);
            tran = CGAffineTransformMakeTranslation(rect.size.height,
                                                    rect.size.width);
            tran = CGAffineTransformScale(tran, -1.0, 1.0);
            tran = CGAffineTransformRotate(tran, 3.0 * M_PI / 2.0);
            break;
        }
        case UIImageOrientationRight:
        {
            bounds = swapWidthAndHeight(bounds);
            tran = CGAffineTransformMakeTranslation(rect.size.height, 0.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
        }
        case UIImageOrientationRightMirrored:
        {
            bounds = swapWidthAndHeight(bounds);
            tran = CGAffineTransformMakeScale(-1.0, 1.0);
            tran = CGAffineTransformRotate(tran, M_PI / 2.0);
            break;
        }
        default:
            return sourceImage;
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    ctxt = UIGraphicsGetCurrentContext();
    
    switch (orientation)
    {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextScaleCTM(ctxt, -1.0, 1.0);
            CGContextTranslateCTM(ctxt, -rect.size.height, 0.0);
            break;
            
        default:
            CGContextScaleCTM(ctxt, 1.0, -1.0);
            CGContextTranslateCTM(ctxt, 0.0, -rect.size.height);
            break;
    }
    
    CGContextConcatCTM(ctxt, tran);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, image);
    
    copy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return copy;
}


/** 交换宽和高 */
static CGRect swapWidthAndHeight(CGRect rect)
{
    CGFloat swap = rect.size.width;
    
    rect.size.width = rect.size.height;
    rect.size.height = swap;
    
    return rect;
}

@end
