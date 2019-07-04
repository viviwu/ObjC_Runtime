//
//  XUnitWordView.m
//  XApp
//
//  Created by vivi wu on 2019/6/28.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import "XUnitWordView.h"

@implementation XUnitWordView


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    // Drawing code
    if (!_originSentence) {
        _originSentence = @"中文分词：Chinese Word Segmentation 分词就是将连续的字序列按照一定的规范重新组合成词序列的过程。";
    }
    for (NSString * word in _originSentence.tokenizerUnitWord) {
        NSDictionary * attri = @{NSFontAttributeName : [UIFont systemFontOfSize:arc4random()%10+10], NSForegroundColorAttributeName: UIColor.randomColor};
        CGSize size = [word sizeWithAttributes:attri];
        uint32_t x = arc4random() % (uint32_t)(kSelfW)-size.width;
        uint32_t y = arc4random() % (uint32_t)(kSelfH)-size.height;
        CGPoint  point = CGPointMake(x, y);
        [word drawAtPoint:point withAttributes:attri];
    }
    
}


@end
