//
//  XWButton.m
//  XWiOS
//
//  Created by viviwu on 16/6/16.
//  Copyright © 2016年 viviwu. All rights reserved.
//

#import "XWButton.h"

#define contentX0 contentRect.origin.x
#define contentY0 contentRect.origin.y
#define content_W contentRect.size.width
#define content_H contentRect.size.height



@interface XWButton()
{
    CGRect titleRect;
}
@end

@implementation XWButton

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame ];
    if (self) {
        _badge=0;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    if (XWButtonTypeBadge ==_titleType) { 
        self.titleLabel.text=[NSString stringWithFormat:@"%d", (int)_badge];
        self.titleLabel.backgroundColor=[UIColor redColor];
        self.titleLabel.textColor=[UIColor whiteColor];
        self.titleLabel.layer.cornerRadius=self.titleLabel.frame.size.height*0.5;
        self.titleLabel.clipsToBounds=YES;
        
        if (_badge>0) {
            if (_badge>9) {
                self.titleLabel.font=[UIFont systemFontOfSize:10];
            }else{
                self.titleLabel.font=[UIFont systemFontOfSize:12];
            }
            self.titleLabel.hidden=NO;
        }else{
            self.titleLabel.hidden=YES;
        }
    }else{
        self.titleLabel.font=[UIFont systemFontOfSize:_titleFontSize];
    }
}

-(void)setBadge:(NSInteger)badge
{
    _badge=badge;
    self.titleLabel.text=[NSString stringWithFormat:@"%d", (int)_badge];
    if (_badge>0) {
        if (_badge>9) {
            self.titleLabel.font=[UIFont systemFontOfSize:10];
        }else{
            self.titleLabel.font=[UIFont systemFontOfSize:12];
        }
        self.titleLabel.hidden=NO;
    }else{
        self.titleLabel.hidden=YES;
    }
}
 
//1.重写方法,改变 图片的位置  在  titleRect..方法后执行
- ( CGRect )imageRectForContentRect:( CGRect )contentRect
{
    CGRect  rect = contentRect;
    if (XWButtonTypeBadge ==_titleType){
        rect = CGRectMake(0, 0, content_W, content_H);
    }else if(XWButtonTypeMenu ==_titleType){
        rect = CGRectMake(content_W*0.2f, content_H*0.1, content_W*0.6f, content_H*0.6f);
    }
    return rect;
}
//2.改变title文字的位置,构造title的矩形即可
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect  rect = contentRect;
    if (XWButtonTypeBadge ==_titleType){
        rect=CGRectMake(content_W*0.6, 0, content_W*0.45, content_W*0.45);
        titleRect=rect;
    }else if(XWButtonTypeMenu ==_titleType){
        rect=CGRectMake(0, content_H*0.75f, content_W, content_H*0.25);
    }
    return rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

#if 0
// default is UIEdgeInsetsZero
@property(nonatomic) UIEdgeInsets contentEdgeInsets UI_APPEARANCE_SELECTOR;
@property(nonatomic) UIEdgeInsets titleEdgeInsets;

@property(nullable, nonatomic,readonly,strong) UILabel     *titleLabel NS_AVAILABLE_IOS(3_0);
@property(nullable, nonatomic,readonly,strong) UIImageView *imageView  NS_AVAILABLE_IOS(3_0);

- (CGRect)titleRectForContentRect:(CGRect)contentRect;
- (CGRect)imageRectForContentRect:(CGRect)contentRect;
#endif
*/

@end
