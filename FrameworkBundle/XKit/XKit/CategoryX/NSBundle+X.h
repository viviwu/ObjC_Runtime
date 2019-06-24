//
//  NSBundle+X.h
//  XKitS
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (X)

+ (UIImage *)bundleImageName:(NSString *)name;

+ (UINib * )loadNibWithName:(NSString *)name;

+ (NSBundle *)xBundle;

@end

NS_ASSUME_NONNULL_END
