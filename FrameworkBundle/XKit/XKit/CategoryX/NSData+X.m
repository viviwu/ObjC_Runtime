//
//  NSData+X.m
//  XKit
//
//  Created by vivi wu on 2019/7/5.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "NSData+X.h"

@implementation NSData (X)
 
- (NSString *)utf8String {
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}
@end
