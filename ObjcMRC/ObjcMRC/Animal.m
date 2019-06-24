//
//  Animal.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "Animal.h"

@implementation Animal

- (instancetype)init{
    self = [super init];
    if (self) {
        _uuid = NSUUID.UUID.UUIDString;
        _name = @"🐒";
        _age = 1;
        _weight = 2.5;
        _unsafe_unretained_obj= [XOBJ new];
    }
    return self;
}

//retain 和copy 的使用区别
- (void)setUuid:(NSString *)uuid
{
    [uuid retain];
    [_uuid release];
    _uuid = uuid;
}

- (void)setName:(NSString *)name
{
    [_name release];
    _name = [name copy];
}

- (void)yell
{
    NSLog(@"%s", __func__); 
}

- (void)descriptionSelf
{
    NSLog(@"{%@ | name:%@ | age:%d | weight:%.1fkg}", NSStringFromClass(self.class), _name, _age, _weight);
}

//- (void)dealloc
//{
//    NSLog(@"%s", __func__);
//    [_name release];
//    [super dealloc];
//}

@end
