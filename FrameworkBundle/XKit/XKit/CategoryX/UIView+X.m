//
//  UIView+X.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "UIView+X.h"

@implementation UIView (X)

#pragma mark 生成image
- (UIImage *)generateImageFromCurrentContext
{
    CGSize size = self.bounds.size; //目标区域
    CGFloat scale = 0.0; //[UIScreen mainScreen].scale;
    UIImage * image = [self generateImageWithSize:size
                                            scale:scale];
    return image;
}

- (UIImage *)generateImageWithSize:(CGSize)size
                             scale:(CGFloat)scale
{
    BOOL opaque = NO;   //是否透明
    UIGraphicsBeginImageContextWithOptions(size, opaque, scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
