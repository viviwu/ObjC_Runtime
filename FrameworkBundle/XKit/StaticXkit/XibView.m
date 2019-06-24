//
//  XibView.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XibView.h"
#import "NSBundle+X.h"
//#import <XKitS/NSBundle+X.h>

@implementation XibView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = nil;
        UIImage *image = nil;
        
        nib = [NSBundle.xBundle loadNibNamed:@"XibView" owner:self options:nil];
        //        image = [UIImage imageNamed:@"photos" inBundle:[NSBundle xBundle] compatibleWithTraitCollection:nil];
        image = [NSBundle bundleImageName:@"photos"];
         
        [[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
        self.imageView.image = image;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
