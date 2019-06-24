//
//  XOBJ.m
//  ObjcMRC
//
//  Created by vivi wu on 2019/6/10.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XOBJ.h"

@implementation XOBJ
-(void)dealloc
{
    NSLog(@"dealloc: %s", __func__);
    [super dealloc];
}
@end
