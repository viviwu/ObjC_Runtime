//
//  NSDate+X.h
//  XKit
//
//  Created by vivi wu on 2019/7/5.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface CompareResult : NSObject
@property long long value;          //时间差值
@property NSComparisonResult trend; //哪个大哪个小
@end

//++++++++++++++++++++++++++++++++


@interface NSDate (X)

//当前时间格式化, 例:YYYY-MM-dd-EEEE-HH:mm:ss
+ (NSString *)getCurrentDataWithDateFormate:(NSString *)formate;

//任意NSDate格式化
+ (NSString *)dateFormattingWithDate:(NSDate *)date toFormate:(NSString *)formate;

//获取当天0点时间
+ (NSDate *)returnToDay0Clock;

//获取当天24点时间
+ (NSDate *)returnToDay24Clock;

//获取当前秒数
+ (long long)getCurrentDateSecond;

//NSDate转秒
+ (long long)dateTosecond:(NSDate *)date;

//秒转NSDate
+ (NSDate *)secondToDate:(long long)second;

//是否是12小时制; YES:12小时制 / NO:24小时制
+ (BOOL)is12HourSystem;

//朋友圈/聊天 时间显示样式
+ (NSString *)dateDisplayResult:(long long)secondCount;

//比较两个NsDate对象的时间差
+ (CompareResult *)compareDateDifferenceDate1:(NSDate *)date1 date2:(NSDate *)date2;


@end

NS_ASSUME_NONNULL_END
