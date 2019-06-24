//
//  ARCObj.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "ARCObj.h"

@implementation ARCObj

- (instancetype)init{
    self = [super init];
    if (self) {
        _uuid = NSUUID.UUID.UUIDString;
        _marr = [NSMutableArray array];
    }
    return self;
}

- (void)descriptionSelf
{
    NSMutableString * des = [NSMutableString stringWithFormat:@"%@ -->ARR: ", _uuid];
    for (id obj in _marr) {
        [des appendFormat:@"%@ | ", obj];
    }
    NSLog(@"%@", des);
}


- (void)dealloc
{
    NSLog(@"%s", __func__);
    [super dealloc];
}
@end
