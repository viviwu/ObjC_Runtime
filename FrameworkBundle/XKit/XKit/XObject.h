//
//  XObject.h
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XObject : NSObject
{
    NSString* _searchTerms;
}

//@property (strong, nonatomic) NSString* searchTerms;
- (NSString *)searchTerms;

- (NSDictionary *)propertyMap;



/** 通过字典初始化数据 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/** 对象json数据, 自雷类型, 返回多个对象 */
+ (NSArray *)arrayForArray:(NSArray<NSDictionary *> *)array class:(Class)cls;

/** 对象转字典 */
- (NSDictionary *)dictionary;

/** 转Json字符串 */
+ (NSString *)toJsonString:(id)object;



@end

NS_ASSUME_NONNULL_END
