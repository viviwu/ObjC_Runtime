//
//  XWindexView.m
//  UUtone
//
//  Created by viviwu on 16/1/21.
//  Copyright © 2016年 vivi705wu@sina.com. All rights reserved.
//

#import "XWindexView.h"

//=================================================
@interface XWindexLabel : UILabel
@property (nonatomic,assign) int fromValue;
@end

@implementation XWindexLabel
@end

//=================================================
@interface XWindexView ()

@property (nonatomic,assign)CGFloat indexLabelH;
@property (nonatomic,assign)int selectedIndex;

@end

@implementation XWindexView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.selectedIndex=-1;
    }
    return self;
}

//数据过来之后创建子控件
-(void)setIndexArr:(NSArray *)indexArr
{
    _indexArr = indexArr;
//    NSLog(@"%@", _indexArr);
    for (int i = 0; i<_indexArr.count; i++) {
        
        XWindexLabel *titleLabel = [[XWindexLabel alloc]init];
        titleLabel.text = _indexArr[i];
        titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor =XWRGBcolor(50, 100, 200);
        titleLabel.tag=i;
        [self addSubview:titleLabel];
    }

}

//为子控件设置frame
-(void)layoutSubviews{
    
    [super layoutSubviews];
    for (XWindexLabel *label in self.subviews)
    {
        CGFloat labelH=self.frame.size.height/(_indexArr.count);
        CGFloat labelY=label.tag * labelH;
        CGFloat labelW=self.frame.size.width;
        CGFloat labelX=0;
        label.frame=CGRectMake(labelX, labelY, labelW, labelH);
    }
    self.indexLabelH =self.frame.size.height / self.indexArr.count;
}


#pragma mark--UIresponder
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch * touch=[touches anyObject];
    CGPoint beganPoint=[touch locationInView:self];
    int index=beganPoint.y/self.indexLabelH;
    
    for (XWindexLabel *label in self.subviews)
    {
        //中间的那个
        if (label.tag==index) {
            
            [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
        }
        //上边的四个或者少于四个
        if (label.tag>=index-4 && label.tag>=0 && label.tag<index) {
            int toValue =(int)-(4-(index-label.tag))*10 ;
            [self makeLabelMove:label andToValue:toValue andFromValue:label.fromValue];
        }
        //下边的四个或者少于四个
        if (label.tag<self.indexArr.count && label.tag<=index+4 && label.tag>index) {
            [self makeLabelMove:label andToValue:(int)-(4-(-index+label.tag))*10 andFromValue:label.fromValue];
        }
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:self];
    int index=movePoint.y/self.indexLabelH;
    if (index==self.selectedIndex) {
        return;
    }
    self.selectedIndex = index;
    
    //其余的
    for (XWindexLabel *label in self.subviews)
    {
        assert(label.tag>=0);
        assert(label.tag<self.indexArr.count);
        //最在上面几个 或者没有 回归原位
        if (index-4>label.tag) {
            [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
        }
        //上边的四个或者少于四个
        else if (label.tag>=index-4 && label.tag<index) {
            [self makeLabelMove:label andToValue:(int)-(4-(index-label.tag))*10 andFromValue:label.fromValue];
        }
        //中间的那个
        else if (label.tag==index) {
            [self makeLabelMove:label andToValue:-40 andFromValue:label.fromValue];
        }
        //下边的
        else if (label.tag<index+4 && label.tag>index) {
            [self makeLabelMove:label andToValue:(int)-(4-(-index+label.tag))*10 andFromValue:label.fromValue];
        }
        //最下面的几个 或者没有 回归原位 条件是//(label.tag>index+4)
        else {
            [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
        } 
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    
    int index = endPoint.y/self.indexLabelH;
    
    //通知代理 滑动tableView
    if ([self.delegate respondsToSelector:@selector(didSelectedIndex:)]) {
        [_delegate didSelectedIndex:index];
    }
    //所有的回归原位
    for (XWindexLabel *label in self.subviews) {
        [self makeLabelMove:label andToValue:0 andFromValue:label.fromValue];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)makeLabelMove:(XWindexLabel *)label andToValue:(int)toValue andFromValue:(int)fromValue{
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.duration=0.3;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.keyPath = @"transform.translation.x";
    anim.fromValue = @(fromValue);
    anim.toValue = @(toValue);
    label.fromValue=toValue;
    [label.layer addAnimation:anim forKey:nil];
    
    //改变颜色
    int colorMultiple = -toValue/10;
    
    if (colorMultiple!=4) {
        int colorAdd = colorMultiple * 35 + 123;
        label.textColor = XWRGBcolor(colorAdd, colorAdd, colorAdd);
    }else {
        label.textColor = XWRGBcolor(0, 250.0, 0);
    }
}


@end
