//
//  Dog.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "Dog.h"


@implementation Dog

- (instancetype)init{
    self = [super init];
    if (self) {
//        _friends = [NSMutableArray array];
        ;
    }
    return self;
}
- (void)yell
{
    NSLog(@"%@ bark:wang!wang!...(%s)", self.name, __func__);
    if (_aBlock) {
        _aBlock(self.name);
    }
}
@end
