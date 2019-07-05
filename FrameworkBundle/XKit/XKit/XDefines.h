//
//  XDefines.h
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#ifndef XDefines_h
#define XDefines_h


// ********************************************
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height

#define kUserDef [NSUserDefaults standardUserDefaults]
#define UserDefObjForKey(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define UserDefBoolForKey(key) [[NSUserDefaults standardUserDefaults] boolForKey:key]
//+++++++++++++Compile Environment ++++++++++++++++++++++++++++++++++++++++

#ifndef __OPTIMIZE__

    #define NSLog(...) NSLog(__VA_ARGS__)

#else

    # define NSLog(...) {}

#endif

// ********************************************
#ifndef log4Debug
#define log4Debug(format, ...) printf("%s", [[NSString stringWithFormat:(@"[DEBUG] %s - %d: " format "\n"), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__] UTF8String])
#endif
// ********************************************
#define XLog(format, ...)  NSLog(format, ## __VA_ARGS__)

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


//----------------------内存----------------------------
//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }
#endif
//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色
#define fRGBA_COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define fRGB(r,g,b) RGBA_COLOR(r,g,b,1.0f)
//+++++++++++++ ++++++++++++++++++++++++++++++++++++++++

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])


#endif /* XDefines_h */
