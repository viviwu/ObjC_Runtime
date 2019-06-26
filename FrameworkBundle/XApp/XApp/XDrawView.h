//
//  XDrawView.h
//  GeoDraw
//
//  Created by vivi wu on 2019/6/25.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XDrawView : UIView
@property (nonatomic, assign) BOOL redo;
@end

NS_ASSUME_NONNULL_END


//弧度转角度
#define Radians_To_Degrees(radians) ((radians) * (180.0 / M_PI))
//角度转弧度
#define Degrees_To_Radians(angle) ((angle) / 180.0 * M_PI)
