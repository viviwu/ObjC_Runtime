//
//  Animal.h
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XOBJ.h"
 
NS_ASSUME_NONNULL_BEGIN

@interface Animal : NSObject
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) float weight;

//@property (nonatomic, unsafe_unretained) XOBJ * unsafe_unretained_obj;
@property (nonatomic, retain) XOBJ * unsafe_unretained_obj;

- (void)yell;
- (void)descriptionSelf;

@end

NS_ASSUME_NONNULL_END
