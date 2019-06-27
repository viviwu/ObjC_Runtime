//
//  XGradientLayer.m
//  XKit
//
//  Created by viviwu on 2019/6/27.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XGradientLayer.h"

@implementation XGradientLayer

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setNeedsDisplay];
  }
  return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
  
  size_t gradLocationsNum = 2;
  CGFloat gradLocations[2] = {0.0f,1.0f};
  CGFloat gradColors[8] = {
    1.0f,1.0f,1.0f,0.40f,
    0.0f,0.0f,0.0f,0.05f,
  };
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, gradColors, gradLocations, gradLocationsNum);
  
  CGColorSpaceRelease(colorSpace);
  
   
  CGPoint startCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGFloat startRadius = 100;
  CGPoint endCenter = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
  CGFloat endRadius = 800;
  CGContextDrawRadialGradient(ctx, gradient, startCenter, startRadius, endCenter, endRadius, kCGGradientDrawsBeforeStartLocation);
  
  CGGradientRelease(gradient);
}

@end
