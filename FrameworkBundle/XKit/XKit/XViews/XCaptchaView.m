//
//  XCaptchaView.m
//  XKit
//
//  Created by viviwu on 2019/6/27.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XCaptchaView.h"

//@interface UIColor (X)
//+ (UIColor *)randomLightColor;
//@end

@implementation UIColor (X)
+ (UIColor *)randomLightColor{
  float red = arc4random() % 100 / 100.0;
  float green = arc4random() % 100 / 100.0;
  float blue = arc4random() % 100 / 100.0;
  UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:0.2];
  return color;
}
@end

@implementation XCaptchaView


- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.lenght = 4;   //default
    self.backgroundColor = UIColor.randomLightColor;
    [self changeCaptcha0];
  }
  return self;
}


- (void)changeCaptcha{
   [self changeCaptcha0];
   [self setNeedsDisplay];
}

- (void)changeCaptcha0
{
  NSArray * characters = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N", @"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", @"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n", @"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"];
  
  NSMutableString * mCaptcha = [NSMutableString string];
  for (int i=0; i<_lenght; i++) {
    NSInteger index = arc4random()%(characters.count-1);
    NSString * cha =  [characters objectAtIndex:index];
    [mCaptcha appendString:cha];
  }
  self.captcha = [NSString stringWithFormat:@"%@", mCaptcha];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
  NSDictionary * attri = @{NSFontAttributeName : [UIFont systemFontOfSize:20]};
  CGSize cSize = [@"S" sizeWithAttributes:attri];
  int width = rect.size.width / self.captcha.length - cSize.width;
  int height = rect.size.height - cSize.height;
  CGPoint point;
  
  float pX = 0, pY = 0;
  for (int i = 0; i < self.captcha.length; i++)
  {
    pX = arc4random() % width + rect.size.width / self.captcha.length * i;
    pY = arc4random() % height;
    point = CGPointMake(pX, pY);
    unichar c = [self.captcha characterAtIndex:i];
    NSString *textC = [NSString stringWithFormat:@"%C", c];
    [textC drawAtPoint:point withAttributes:attri];
  }
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 1.0);
  for(int cout = 0; cout < 10; cout++)
  {
    CGContextSetStrokeColorWithColor(context, UIColor.randomLightColor.CGColor);
    
    pX = arc4random() % (int)rect.size.width;
    pY = arc4random() % (int)rect.size.height;
    CGContextMoveToPoint(context, pX, pY);
    
    pX = arc4random() % (int)rect.size.width;
    pY = arc4random() % (int)rect.size.height;
    CGContextAddLineToPoint(context, pX, pY);
    
    CGContextStrokePath(context);
  }
 
  [super drawRect:rect];
}


@end
