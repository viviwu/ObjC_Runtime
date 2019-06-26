//
//  XGridView.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XGridView.h"

#if BUNDLE_FLAG
    #import "NSBundle+X.h"
#endif

@implementation XGridView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = nil;
#if BUNDLE_FLAG
        nib = [NSBundle.xBundle loadNibNamed:@"XGridView" owner:self options:nil];
#else
        nib = [NSBundle.mainBundle loadNibNamed:@"XGridView" owner:self options:nil];
#endif
        
        [[nib objectAtIndex:0] setFrame:frame];
        self = [nib objectAtIndex:0];
        
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 3;
    self.clipsToBounds = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
