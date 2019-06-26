//
//  NSBundle+X.m
//  XKitS
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "NSBundle+X.h"

@implementation NSBundle (X)

+ (NSBundle *)xBundle { 
    return [NSBundle bundleWithPath: [[NSBundle mainBundle] pathForResource:@"XBundle" ofType:@"bundle"]];
}

+ (UINib * )loadNibWithName:(NSString *)name {
    return  [[[NSBundle xBundle] loadNibNamed:name owner:nil options:nil] lastObject];
}

+ (UIImage *)xImageNamed:(NSString *)name {
    return [UIImage imageNamed:name inBundle:[NSBundle xBundle] compatibleWithTraitCollection:nil];
}

@end
