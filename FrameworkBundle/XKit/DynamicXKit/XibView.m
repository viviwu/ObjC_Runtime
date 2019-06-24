//
//  XibView.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XibView.h"

@implementation XibView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nib = nil;
        UIImage *image = nil;
        
        nib = [NSBundle.mainBundle loadNibNamed:@"XibView" owner:self options:nil];
        image = [UIImage imageNamed:@"photos"];
        
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
