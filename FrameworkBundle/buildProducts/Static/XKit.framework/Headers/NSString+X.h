//
//  NSString+X.h
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (X)

- (const char*)cString;

- (NSArray<NSString*>*)tokenizerUnitWord; //分词


@end

NS_ASSUME_NONNULL_END
