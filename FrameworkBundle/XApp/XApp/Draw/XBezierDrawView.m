//
//  XBezierDrawView.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XBezierDrawView.h"

@implementation XBezierDrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self drawCscoLogo];
    
    [super drawRect:rect];
}


- (void)drawCscoLogo
{
    CGRect rect = self.bounds;
    CGFloat Radius = kSelfW/5;
    rect.size = CGSizeMake(2*Radius, 2*Radius);
    rect.origin.x = kSelfW/2-Radius;
    rect.origin.y = kSelfH/2-Radius;
    [self drawDoitWithRect:rect fillColor:UIColor.whiteColor];
    
    CGFloat R = kSelfW/3.35, r = 20;
    CGFloat startAngle = 45.0/180.0 * M_PI; //起始角度
    CGFloat endAngle = 315.0/180.0 * M_PI;  //结束角度
    CGPoint center = CGPointMake(kSelfW/2, kSelfH/2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:R startAngle:startAngle endAngle:endAngle clockwise:YES];
    CGFloat pattern[] = {15, 10}; //绘制线段交替样式：实8 空8
    [path setLineDash:pattern count:2 phase:5];
    path.lineWidth = 8.0;
    [path stroke];
    
    //draw red sun
    CGFloat x = kSelfW/2 + R * cos(225/180.0 * M_PI);
    CGFloat y = kSelfW/2 + R * sin(225/180.0 * M_PI);
    CGRect rct = CGRectMake(x-r, y-r, 2*r, 2*r);
    UIColor *color = UIColor.redColor;
    [self drawDoitWithRect:rct fillColor:color];
    
}

- (void)drawDoitWithRect:(CGRect)rect
               fillColor:(UIColor *)color
{
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    
    UIColor *fillColor=color;
    if (!fillColor) {
        [UIColor whiteColor];
    }
    [fillColor set];
    [path fill];    //填充
    
    UIColor *sColor=fillColor;  //[UIColor whiteColor];
    [sColor set];
    [path stroke];  //笔画
}


@end
