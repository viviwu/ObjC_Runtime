//
//  XCoreGraphicsDrawView.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XCoreGraphicsDrawView.h"

@implementation XCoreGraphicsDrawView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
//    [self drawDashLine];
    
    [self drawArc];
    
    [super drawRect:rect];
}

- (void)drawDashLine{
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,  UIColor.redColor.CGColor);
    CGFloat phase = 5;  //起始实线段 减去phase
    CGFloat pattern[] = {20, 10};   //实20虚10 交替绘制
    CGContextSetLineDash(context, phase, pattern, 2);
    CGContextMoveToPoint(context, 80.0, 80.0);
    CGContextAddLineToPoint(context, kSelfW-80.0, kSelfH-80.0);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

//画弧线
- (void)drawArc{
    CGPoint centerP = CGPointMake(kSelfW/2, kSelfW/2);
    CGFloat radius = kSelfW/3;
    CGFloat startAngle = 45.0/180.0 * M_PI; //.起始角度
    CGFloat endAngle = 315.0/180.0 * M_PI;  //结束角度

    UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter: centerP radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    [path addLineToPoint:centerP];
    [path moveToPoint:centerP];
    [UIColor.orangeColor set];
    [path stroke];
    [path closePath];
}

- (void)drawTrianglePath {
    
    //初始化
    UIBezierPath *path = [UIBezierPath bezierPath];
    //初始点
    [path moveToPoint:CGPointMake(20, 20)];
    //第二点
    [path addLineToPoint:CGPointMake(self.frame.size.width - 40, 20)];
    //第三个点
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height - 20)];
    
    // 最后的闭合线是可以通过调用closePath方法来自动生成的，也可以调用-addLineToPoint:方法来添加
    //  [path addLineToPoint:CGPointMake(20, 20)];
    
    [path closePath];
    
    // 设置线宽
    path.lineWidth = 1.5;
    
    // 设置填充颜色
    UIColor *fillColor = [UIColor greenColor];
    [fillColor set];
    [path fill];
    
    // 设置画笔颜色
    UIColor *strokeColor = [UIColor blueColor];
    [strokeColor set];
    
    // 根据我们设置的各个点连线
    [path stroke];
}

/**
 *  通过 Quartz 2D 在 UIImageView 绘制虚线
 *
 *  param imageView 传入要绘制成虚线的imageView
 *  return
 */

- (UIImage *)drawLineOfDashByImageView:(UIImageView *)imageView {
    // 开始划线 划线的frame
    UIGraphicsBeginImageContext(imageView.frame.size);
    
    [imageView.image drawInRect:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    
    // 获取上下文
    CGContextRef line = UIGraphicsGetCurrentContext();
    
    // 设置线条终点的形状
    CGContextSetLineCap(line, kCGLineCapRound);
    // 设置虚线的长度 和 间距
    CGFloat lengths[] = {5,5};
    
    CGContextSetStrokeColorWithColor(line, [UIColor greenColor].CGColor);
    // 开始绘制虚线
    CGContextSetLineDash(line, 0, lengths, 2);
    
    CGContextMoveToPoint(line, 0.0, 2.0);
    
    CGContextAddLineToPoint(line, 300, 2.0);
    
    CGContextStrokePath(line);
    
    // UIGraphicsGetImageFromCurrentImageContext()返回的就是image
    return UIGraphicsGetImageFromCurrentImageContext();
}

/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
- (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    
    [shapeLayer setBounds:lineView.bounds];
    
    if (isHorizonal) {
        
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
        
    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }
    
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {
        
        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    
    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
