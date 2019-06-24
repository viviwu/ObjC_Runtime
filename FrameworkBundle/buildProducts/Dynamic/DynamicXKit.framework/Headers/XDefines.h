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
#define XLog(format, ...)  NSLog(format, ## __VA_ARGS__)

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

// ********************************************
#ifndef __OPTIMIZE__

    #define NSLog(...) NSLog(__VA_ARGS__)

#else

    # define NSLog(...) {}

#endif

#endif /* XDefines_h */
