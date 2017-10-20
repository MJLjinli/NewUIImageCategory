//
//  UIImage+ImageAction.h
//  AboutImage_Demo
//
//  Created by 马金丽 on 17/10/19.
//  Copyright © 2017年 majinli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageAction)




#pragma mark - 拉伸图片

/**
 拉伸图片

 @param sourceImage 原图
 @return 目标图片
 */
+ (UIImage *)pullImage:(UIImage *)sourceImage;

#pragma mark - 截取图片

/**
 按指定的位置大小截取图中的一部分

 @param sourceImage 原图
 @param rect 要截取的区域
 @return 截取的图片
 */
+ (UIImage *)clipSubImageFromImage:(UIImage *)sourceImage inSubRect:(CGRect)rect;

/**
 根据给定的size的宽高比自动缩放原图片,自动判断截取位置,进行图片截取
 
 @param sourceImage 原图片
 @param size 截取图片的size
 @return 裁剪之后的图片
 */
+ (UIImage *)adaptiveClipImage:(UIImage *)sourceImage toRect:(CGSize)size;


#pragma mark - 压缩图片

/**
 压缩图片至目标大小
 
 @param sourceImage 原图片
 @param targetWidth 图片最终的宽
 @return 目的图片
 */
+ (UIImage *)compressImageSize:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;


/**
 按比例缩放

 @param sourceImage 原图
 @param defineWidth 指定宽度按比例缩放
 @return self
 */
+ (UIImage *)imageCompressForWithScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


/**
 压缩图片至指定尺寸

 @param sourceImage 原图
 @param size 指定大小
 @return self
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toSize:(CGSize)size;


/**
 压缩图片至指定像素

 @param sourceImage 原图
 @param pixel 指定像素
 @return self
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toPx:(CGFloat)pixel;

#pragma mark - 生成图片

/**
 根据指定的size生成一个平铺的图片

 @param size 指定的size
 @return self
 */
- (UIImage *)generateImageWithSize:(CGSize)size;


/**
 UIview转化为Image

 @param view view
 @return self
 */
+ (UIImage *)generateImageWithView:(UIView *)view;


/**
 将两个图片生成一张图片

 @param firstImage 第一个图片
 @param secondImage 第二个图片
 @return self
 */
+ (UIImage *)mergeImageWithFirstImage:(UIImage *)firstImage withSecondImage:(UIImage *)secondImage;


#pragma mark - 颜色

/**
 生成纯色的图片

 @param color 颜色
 @return self
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 获取图片某一像素的颜色

 @param point 某点
 @return 颜色
 */
- (UIColor *)colorWithImagePixel:(CGPoint)point;

#pragma mark - 获得灰度图片

- (UIImage *)convertToGrayImage;

#pragma mark - 旋转图片

/**
 按给定方向旋转

 @param sourceImage 原图
 @param orientation 方向
 @return self
 */
+ (UIImage *)rotateImage:(UIImage *)sourceImage withOrientation:(UIImageOrientation)orientation;

@end
