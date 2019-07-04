//
//  XUIView.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XUIView.h"

@implementation XUIView

- (instancetype )initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
