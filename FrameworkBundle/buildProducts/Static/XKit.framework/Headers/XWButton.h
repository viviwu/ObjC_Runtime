//
//  XWButton.h
//  XWiOS
//
//  Created by viviwu on 16/6/16.
//  Copyright © 2016年 viviwu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XWButtonType){
    XWButtonTypeMenu=0,
    XWButtonTypeBadge,
};

@interface XWButton : UIButton

-(id)initWithFrame:(CGRect)frame;

@property(nonatomic, assign) float titleFontSize ;
@property(nonatomic, assign) NSInteger badge;
//@property(nonatomic, assign) float badgeFontSize ;
@property(nonatomic, assign) XWButtonType titleType;

-(void)setBadge:(NSInteger)badge;
@end
