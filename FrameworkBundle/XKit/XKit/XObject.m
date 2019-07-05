//
//  XObject.m
//  XKit
//
//  Created by vivi wu on 2019/6/24.
//  Copyright © 2019 vivi wu. All rights reserved.
//
#import <objc/runtime.h>
#import <XKit/NSDictionary+X.h>
#import "XObject.h"

@implementation XObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    // NSLog(@"发现不匹配json: %@ -> %@", key, value);
}

/** 通过字典初始化数据 */
- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if (self) {
        
        [self setValuesForKeysWithDictionary:dictionary];
    }
    
    return self;
}

/** 字典赋值数据 */
- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
{
    if ([keyedValues isKindOfClass:[NSNull class]]) {
        return;
    }
    
    [XObject objectClass:[self class] keys:^(NSString *key) {
        
        // 属性赋值
        if (keyedValues[key] != nil) {
            
            if ([keyedValues[key] isKindOfClass:[NSNull class]]) {
                //剔除空值
                ;
            }
            else {
                
                [self setValue:keyedValues[key] forKey:key];
            }
        }
    }];
    
    NSArray *bsKeys = [self keys];
    
    // 遍历出与字典不匹配的key
    for (NSString *key in keyedValues.allKeys) {
        
        if (![bsKeys containsObject:key]) {
            
            [self setValue:keyedValues[key] forUndefinedKey:key];
        }
    }
}

/** 遍历模型键值对 */
+ (void)objectClass:(Class)baseSubClass keys:(void (^)(NSString *key))block
{
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList(baseSubClass, &count);
    
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        
        block(key);
    }
    
    free(properties);
    
    
    // 判断父类是否是XObject 如果是则递归到父类方法
    XObject *bs = [[XObject alloc] init];
    
    if (![bs isKindOfClass:[baseSubClass superclass]]) {
        
        [self objectClass:[baseSubClass superclass] keys:block];
    }
    
}

/** 对象json数据, 自雷类型, 返回多个对象 */
+ (NSArray *)arrayForArray:(NSArray *)array class:(Class)cls
{
    NSMutableArray *ary = [NSMutableArray array];
    
    if ([array isKindOfClass:[NSNull class]] ||
        array.count == 0 ||
        array == nil) return nil;
    
    for (NSDictionary *dic in array) {
        
        XObject *bs = [[cls alloc] init];
        
        [bs setValuesForKeysWithDictionary:dic];
        
        [ary addObject:bs];
    }
    
    return [NSArray arrayWithArray:ary];
}

/** 对象所有值 */
- (NSArray *)keys
{
    NSMutableArray *array = [NSMutableArray array];
    
    [XObject objectClass:[self class] keys:^(NSString *key) {
        
        [array addObject:key];
    }];
    
    return [NSArray arrayWithArray:array];
}

/** 对象转字典 */
- (NSDictionary *)dictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [XObject objectClass:[self class] keys:^(NSString *key) {
        
        if ([key isEqualToString:@"superclass"] || [key isEqualToString:@"description"] ||[key isEqualToString:@"debugDescription"] ) return ;
        
        id value = [self valueForKey:key];
        
        // 临时增加
        if (value == nil ) return; // value = [NSNull class];
        
        [dictionary setObject:value forKey:key];
    }];
    
    return [NSDictionary dictionaryWithDictionary:dictionary];
}


/** debug输出对象 */

- (NSString *)debugDescription
{
    return [self description];
}

- (NSString*)description{
    NSString * desc=nil;
    /*
     #if 0
     NSData * data = [self.propertyMap modelToJSONData];
     NSJSONSerialization * json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil ];
     desc = [NSString stringWithFormat:@"%@", json];
     #elseif
     desc = [NSString stringWithFormat:@"%@", self.propertyMap];
     #endif
     */
    desc = [NSString stringWithFormat:@"%@", self.propertyMap];
    return desc;
}


/** 转Json字符串 */
+ (NSString *)toJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        //NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}


- (NSDictionary *)propertyMap
{
    NSMutableDictionary *dictionaryFormat = [NSMutableDictionary dictionary];
    
    //  取得当前类类型
    Class cls = [self class];
    
    unsigned int ivarsCnt = 0;
    //　获取类成员变量列表，ivarsCnt为类成员数量
    Ivar *ivars = class_copyIvarList(cls, &ivarsCnt);
    
    //　遍历成员变量列表，其中每个变量都是Ivar类型的结构体
    for (const Ivar *p = ivars; p < ivars + ivarsCnt; ++p)
    {
        Ivar const ivar = *p;
        
        const char * ivar_name = ivar_getName(ivar);    //　获取变量名
        // 若此变量未在类结构体中声明而只声明为Property，则变量名加前缀 '_'下划线
        // 比如 @property(retain) NSString *abc;则 key == _abc;
        if (ivar_name != NULL) {
            NSString *key = [NSString stringWithUTF8String:ivar_name];
            key = [key substringFromIndex:1];   // 去掉前面的_
            /*
             //　取得变量类型 通过 type[0]可以判断其具体的内置类型
             const char *type = ivar_getTypeEncoding(ivar);
             NSLog(@"ivar type:%s", type);   //@"NSString"\@"NSArray"
             */
            
            id value = [self valueForKey:key];  //　获取变量值
            
            //            const char *type = ivar_getTypeEncoding(ivar);  // 通过 type[0]可以判断其具体的内置类型
            
            if (!value) value = @"0";
            if (value)  [dictionaryFormat setObject:value forKey:key];
        }
    }
    return dictionaryFormat;
}

- (NSString *)searchTerms {
    
    if (!_searchTerms) {
        NSMutableString * mString = [NSMutableString string];
        for (id val in self.propertyMap.allValues) {
            NSString *valStr =[NSString stringWithFormat:@"%@", val];
            if (valStr.length>1) {
                //                valStr = [valStr substringFromIndex:1];
                [mString appendFormat:@"%@ ", valStr];
            }
        }
        _searchTerms = [mString copy];
    }
    //    NSLog(@"_searchTerms: %@", _searchTerms);
    return _searchTerms;
    
    return self.description;
}

/** 输出对象 */
/*
 - (NSString *)description
 {
 NSString *string = @"";
 
 unsigned int outCount, i;
 objc_property_t *properties = class_copyPropertyList([self class], &outCount);
 
 for (i = 0; i < outCount; i++) {
 objc_property_t property = properties[i];
 const char *char_f = property_getName(property);
 if (char_f != NULL) {
 NSString *propertyName = [NSString stringWithUTF8String:char_f];
 id propertyValue = [self valueForKey:(NSString *)propertyName];
 if (!propertyValue) propertyValue = @"0";
 if (propertyValue && propertyName)  string = [string stringByAppendingString:[NSString stringWithFormat:@"%@: %@\n", propertyName, propertyValue]];
 }
 }
 
 free(properties);
 
 return string;
 }
 */

@end
