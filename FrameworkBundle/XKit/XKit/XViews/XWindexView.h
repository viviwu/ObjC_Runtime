//
//  XWindexView.h
//  UUtone
//
//  Created by viviwu on 16/1/21.
//  Copyright © 2016年 vivi705wu@sina.com. All rights reserved.
//

#import <UIKit/UIKit.h>


#define XWRGBcolor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

@protocol XWindexViewDelegate <NSObject>

-(void)didSelectedIndex:(int)index;

@end


@interface XWindexView : UIView

@property (nonatomic,assign)id<XWindexViewDelegate>delegate;

//数据
@property (nonatomic,strong)NSArray *indexArr;

@end
