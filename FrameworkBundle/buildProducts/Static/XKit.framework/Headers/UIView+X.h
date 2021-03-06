//
//  UIView+X.h
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (X)
- (UIImage *)generateImageFromCurrentContext;
- (UIImage *)generateImageWithSize:(CGSize)size
                             scale:(CGFloat)scale;
@end

NS_ASSUME_NONNULL_END
