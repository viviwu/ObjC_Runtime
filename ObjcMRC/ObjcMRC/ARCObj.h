//
//  ARCObj.h
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ARCObj : NSObject

@property (nonatomic, copy) NSString  * uuid;
@property (nonatomic, strong) NSMutableArray * marr;

- (void)descriptionSelf;

@end

NS_ASSUME_NONNULL_END
