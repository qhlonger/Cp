//
//  UIImage+Extension.h
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/** 将图片压缩至指定文件大小,单位kb */
- (NSData *)imageDataScaledToMaxFileSize:(NSInteger)maxFileSize;
/** 生成指定文件大小的压缩图片,单位kb */
- (UIImage *)imageScaledToMaxFileSize:(NSInteger)maxFileSize;
/** 获取一张拉伸不变形的图片 */
+ (UIImage *)resizableImageNamed:(NSString *)name;
/** 通过颜色获取一张 10 * 10的图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color WithFrame:(CGSize)aSize;
/**
 *  高斯滤镜
 *
 *  @param theImage    需要添加滤镜的图片
 *  @param inputRadius 模糊倍数
 *
 *  @return 添加了滤镜的图片
 */
+ (UIImage*) blur:(UIImage*)theImage inputRadius:(CGFloat)inputRadius;
/**
 *  返回可随意拉升的图片
 *
 *  @param imgName 图片名
 *
 *  @return 返回的图片
 */
//+ (UIImage *)resizeImage:(NSString *)imgName;
//
//+ (UIImage *)resizeImage:(NSString *)imgName CapInsets:(UIEdgeInsets)insets;
/**  返回图片出现最多的颜色  */
-(UIColor*)mostColor;

+ (UIImage *)imageWithView:(UIView *)view;
+ (void) imageForAssetUrl: (NSString *) assetUrl
                  success: (void(^)(UIImage *)) successBlock
                     fail: (void(^)()) failBlock;


@end
