//
//  NSDictionary+X.h
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (X)

#pragma mark -- override for Unicode Log
- (NSString *)descriptionWithLocale:(id)locale;

@end

NS_ASSUME_NONNULL_END
