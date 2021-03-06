//
//  XCaptchaView.h
//  XKit
//
//  Created by viviwu on 2019/6/27.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XCaptchaView : UIView

@property (nonatomic, copy) NSString * captcha;
@property (nonatomic, assign) int lenght;

- (void)changeCaptcha;

@end

NS_ASSUME_NONNULL_END

/*
NSFontAttributeName; //字体，value是UIFont对象
NSParagraphStyleAttributeName;//绘图的风格（居中，换行模式，间距等诸多风格），value是NSParagraphStyle对象
NSForegroundColorAttributeName;// 文字颜色，value是UIFont对象
NSBackgroundColorAttributeName;// 背景色，value是UIFont
NSLigatureAttributeName; //  字符连体，value是NSNumber
NSKernAttributeName; // 字符间隔
NSStrikethroughStyleAttributeName;//删除线，value是NSNumber
NSUnderlineStyleAttributeName;//下划线，value是NSNumber
NSStrokeColorAttributeName; //描绘边颜色，value是UIColor
NSStrokeWidthAttributeName; //描边宽度，value是NSNumber
NSShadowAttributeName; //阴影，value是NSShadow对象
NSTextEffectAttributeName; //文字效果，value是NSString
NSAttachmentAttributeName;//附属，value是NSTextAttachment 对象
NSLinkAttributeName;//链接，value是NSURL or NSString
NSBaselineOffsetAttributeName;//基础偏移量，value是NSNumber对象
NSUnderlineColorAttributeName;//下划线颜色，value是UIColor对象
NSStrikethroughColorAttributeName;//删除线颜色，value是UIColor
NSObliquenessAttributeName; //字体倾斜
NSExpansionAttributeName; //字体扁平化
NSVerticalGlyphFormAttributeName;//垂直或者水平，value是 NSNumber，0表示水平，1垂直
*/
