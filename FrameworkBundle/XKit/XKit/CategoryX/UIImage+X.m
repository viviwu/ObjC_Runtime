//
//  UIImage+X.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "UIImage+X.h"
#import <Accelerate/Accelerate.h>
//veclib  vImage


@implementation UIImage (X)


+ (UIImage*)imageWithColor: (UIColor*) color size:(CGSize)size
{
    CGRect rect = CGRectMake(0,0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

#pragma mark -- Scale
- (UIImage*) scaledToSize:(CGSize)newSize {
  UIGraphicsBeginImageContext(newSize);
  [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}

#pragma mark -- ResizeMagick

- (CGImageRef) CGImageWithCorrectOrientation CF_RETURNS_RETAINED
{
  if (self.imageOrientation == UIImageOrientationDown) {
    //retaining because caller expects to own the reference
    CGImageRef cgImage = [self CGImage];
    CGImageRetain(cgImage);
    return cgImage;
  }
  UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  if (self.imageOrientation == UIImageOrientationRight) {
    CGContextRotateCTM (context, 90 * M_PI/180);
  } else if (self.imageOrientation == UIImageOrientationLeft) {
    CGContextRotateCTM (context, -90 * M_PI/180);
  } else if (self.imageOrientation == UIImageOrientationUp) {
    CGContextRotateCTM (context, 180 * M_PI/180);
  }
  
  [self drawAtPoint:CGPointMake(0, 0)];
  
  CGImageRef cgImage = CGBitmapContextCreateImage(context);
  UIGraphicsEndImageContext();
  
  return cgImage;
}


- (UIImage *) resizedImageByWidth:  (NSUInteger) width
{
  CGImageRef imgRef = [self CGImageWithCorrectOrientation];
  CGFloat original_width  = CGImageGetWidth(imgRef);
  CGFloat original_height = CGImageGetHeight(imgRef);
  CGFloat ratio = width/original_width;
  CGImageRelease(imgRef);
  return [self drawImageInBounds: CGRectMake(0, 0, width, round(original_height * ratio))];
}

- (UIImage *) resizedImageByHeight:  (NSUInteger) height
{
  CGImageRef imgRef = [self CGImageWithCorrectOrientation];
  CGFloat original_width  = CGImageGetWidth(imgRef);
  CGFloat original_height = CGImageGetHeight(imgRef);
  CGFloat ratio = height/original_height;
  CGImageRelease(imgRef);
  return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * ratio), height)];
}

- (UIImage *) resizedImageWithMinimumSize: (CGSize) size
{
  CGImageRef imgRef = [self CGImageWithCorrectOrientation];
  CGFloat original_width  = CGImageGetWidth(imgRef);
  CGFloat original_height = CGImageGetHeight(imgRef);
  CGFloat width_ratio = size.width / original_width;
  CGFloat height_ratio = size.height / original_height;
  CGFloat scale_ratio = width_ratio > height_ratio ? width_ratio : height_ratio;
  CGImageRelease(imgRef);
  return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}

- (UIImage *) resizedImageWithMaximumSize: (CGSize) size
{
  CGImageRef imgRef = [self CGImageWithCorrectOrientation];
  CGFloat original_width  = CGImageGetWidth(imgRef);
  CGFloat original_height = CGImageGetHeight(imgRef);
  CGFloat width_ratio = size.width / original_width;
  CGFloat height_ratio = size.height / original_height;
  CGFloat scale_ratio = width_ratio < height_ratio ? width_ratio : height_ratio;
  CGImageRelease(imgRef);
  return [self drawImageInBounds: CGRectMake(0, 0, round(original_width * scale_ratio), round(original_height * scale_ratio))];
}

- (UIImage *) drawImageInBounds: (CGRect) bounds
{
  UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0.0);
  [self drawInRect: bounds];
  UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return resizedImage;
}

- (UIImage*) croppedImageWithRect: (CGRect) rect {
  
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, self.size.width, self.size.height);
  CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
  [self drawInRect:drawRect];
  UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return subImage;
}


#pragma mark -- ImageEffects

- (UIImage *)applyLightEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
  return [self applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}



- (UIImage *)applyExtraLightEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
  return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyDarkEffect
{
  UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
  return [self applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}


- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor
{
  const CGFloat EffectColorAlpha = 0.6;
  UIColor *effectColor = tintColor;
  int componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
  if (componentCount == 2) {
    CGFloat b;
    if ([tintColor getWhite:&b alpha:NULL]) {
      effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
    }
  }
  else {
    CGFloat r, g, b;
    if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
      effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
    }
  }
  return [self applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}


- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
  // Check pre-conditions.
  if (self.size.width < 1 || self.size.height < 1) {
    NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
    return nil;
  }
  if (!self.CGImage) {
    NSLog (@"*** error: image must be backed by a CGImage: %@", self);
    return nil;
  }
  if (maskImage && !maskImage.CGImage) {
    NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
    return nil;
  }
  
  CGRect imageRect = { CGPointZero, self.size };
  UIImage *effectImage = self;
  
  BOOL hasBlur = blurRadius > __FLT_EPSILON__;
  BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
  if (hasBlur || hasSaturationChange) {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectInContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(effectInContext, 1.0, -1.0);
    CGContextTranslateCTM(effectInContext, 0, -self.size.height);
    CGContextDrawImage(effectInContext, imageRect, self.CGImage);
    
    vImage_Buffer effectInBuffer;
    effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
    effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
    effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
    effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
    vImage_Buffer effectOutBuffer;
    effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
    effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
    effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
    effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
    
    if (hasBlur) {
      // A description of how to compute the box kernel width from the Gaussian
      // radius (aka standard deviation) appears in the SVG spec:
      // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
      //
      // For larger values of 's' (s >= 2.0), an approximation can be used: Three
      // successive box-blurs build a piece-wise quadratic convolution kernel, which
      // approximates the Gaussian kernel to within roughly 3%.
      //
      // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
      //
      // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
      //
      CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
      NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
      if (radius % 2 != 1) {
        radius += 1; // force radius to be odd so that the three box-blur methodology works.
      }
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
    }
    BOOL effectImageBuffersAreSwapped = NO;
    if (hasSaturationChange) {
      CGFloat s = saturationDeltaFactor;
      CGFloat floatingPointSaturationMatrix[] = {
        0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
        0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
        0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
        0,                    0,                    0,  1,
      };
      const int32_t divisor = 256;
      NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
      int16_t saturationMatrix[matrixSize];
      for (NSUInteger i = 0; i < matrixSize; ++i) {
        saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
      }
      if (hasBlur) {
        vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        effectImageBuffersAreSwapped = YES;
      }
      else {
        vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
      }
    }
    if (!effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  
  // Set up output context.
  UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
  CGContextRef outputContext = UIGraphicsGetCurrentContext();
  CGContextScaleCTM(outputContext, 1.0, -1.0);
  CGContextTranslateCTM(outputContext, 0, -self.size.height);
  
  // Draw base image.
  CGContextDrawImage(outputContext, imageRect, self.CGImage);
  
  // Draw effect image.
  if (hasBlur) {
    CGContextSaveGState(outputContext);
    if (maskImage) {
      CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
    }
    CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
    CGContextRestoreGState(outputContext);
  }
  
  // Add in color tint.
  if (tintColor) {
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
    CGContextFillRect(outputContext, imageRect);
    CGContextRestoreGState(outputContext);
  }
  
  // Output image is ready.
  UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return outputImage;
}

- (UIImage *)urb_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage {
  // Check pre-conditions.
  if (self.size.width < 1 || self.size.height < 1) {
    NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
    return nil;
  }
  if (!self.CGImage) {
    NSLog (@"*** error: image must be backed by a CGImage: %@", self);
    return nil;
  }
  if (maskImage && !maskImage.CGImage) {
    NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
    return nil;
  }
  
  CGRect imageRect = { CGPointZero, self.size };
  UIImage *effectImage = self;
  
  BOOL hasBlur = blurRadius > __FLT_EPSILON__;
  BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
  if (hasBlur || hasSaturationChange) {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectInContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(effectInContext, 1.0, -1.0);
    CGContextTranslateCTM(effectInContext, 0, -self.size.height);
    CGContextDrawImage(effectInContext, imageRect, self.CGImage);
    
    vImage_Buffer effectInBuffer;
    effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
    effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
    effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
    effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
    vImage_Buffer effectOutBuffer;
    effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
    effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
    effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
    effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
    
    if (hasBlur) {
      // A description of how to compute the box kernel width from the Gaussian
      // radius (aka standard deviation) appears in the SVG spec:
      // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
      //
      // For larger values of 's' (s >= 2.0), an approximation can be used: Three
      // successive box-blurs build a piece-wise quadratic convolution kernel, which
      // approximates the Gaussian kernel to within roughly 3%.
      //
      // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
      //
      // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
      //
      CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
      NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
      if (radius % 2 != 1) {
        radius += 1; // force radius to be odd so that the three box-blur methodology works.
      }
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
      vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
    }
    BOOL effectImageBuffersAreSwapped = NO;
    if (hasSaturationChange) {
      CGFloat s = saturationDeltaFactor;
      CGFloat floatingPointSaturationMatrix[] = {
        0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
        0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
        0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
        0,                    0,                    0,  1,
      };
      const int32_t divisor = 256;
      NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
      int16_t saturationMatrix[matrixSize];
      for (NSUInteger i = 0; i < matrixSize; ++i) {
        saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
      }
      if (hasBlur) {
        vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        effectImageBuffersAreSwapped = YES;
      }
      else {
        vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
      }
    }
    if (!effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (effectImageBuffersAreSwapped)
      effectImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
  }
  
  // Set up output context.
  UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
  CGContextRef outputContext = UIGraphicsGetCurrentContext();
  CGContextScaleCTM(outputContext, 1.0, -1.0);
  CGContextTranslateCTM(outputContext, 0, -self.size.height);
  
  // Draw base image.
  CGContextDrawImage(outputContext, imageRect, self.CGImage);
  
  // Draw effect image.
  if (hasBlur) {
    CGContextSaveGState(outputContext);
    if (maskImage) {
      CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
    }
    CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
    CGContextRestoreGState(outputContext);
  }
  
  // Add in color tint.
  if (tintColor) {
    CGContextSaveGState(outputContext);
    CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
    CGContextFillRect(outputContext, imageRect);
    CGContextRestoreGState(outputContext);
  }
  
  // Output image is ready.
  UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return outputImage;
}


@end
