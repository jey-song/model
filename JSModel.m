//
//  JSModel.m
//  model
//
//  Created by Jey on 22/3/16.
//  Copyright © 2016年 Jey All rights reserved.
//

#import "JSModel.h"
#import <objc/runtime.h>

@interface JSModel () {
    NSMutableDictionary *__model_userInfo;
    NSArray *__model_allkeys;
}

@end

@implementation JSModel
+ (id)model {
    id model = [[self alloc] init];
    return model;
}

+ (id)modelFromJSONString:(NSString *)json {
    if (!json || ![json isKindOfClass:[NSString class]]) {
        return nil;
    }
    NSData *data = [(NSString *)json dataUsingEncoding:NSUTF8StringEncoding];
    return [self modelFromJSONData:data];
}

+ (id)modelFromJSONData:(NSData *)data {
    if ([data isKindOfClass:[NSString class]]) {
        data = [(NSString *)data dataUsingEncoding:NSUTF8StringEncoding];
    }
    if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    id value = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    return [self modelFromInfo:value];
}

+ (id)modelFromInfo:(NSDictionary *)info {
    id model = [[self alloc] init];
    [model update:info];
    return model;
}

+ (NSArray *)modelsFromInfos:(NSArray *)infos {
    NSMutableArray *models = nil;
    @try {
        models = [NSMutableArray arrayWithCapacity:[infos count]];
        for (NSDictionary *info in infos) {
            id obj = [self modelFromInfo:info];
            if (obj)
                [models addObject:obj];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"////Data format ERROR////");
        models = nil;
    }
    return models;
}

# pragma mark - Set Values
- (void)update:(NSDictionary *)info {
    if (!info) {
        return;
    }
    NSEnumerator *enumeratorKey = [info keyEnumerator];
    NSArray *keys = [self customModelKeys];
    for (NSString *key in enumeratorKey) {
        if (!(keys && [keys containsObject:key])
            && [self respondsToSelector:NSSelectorFromString(key)]) {
            NSObject *value = info[key];
            if ([value isKindOfClass:[NSNull class]]) {
                value = nil;
            } else {
                objc_property_t p = class_getProperty(self.class, [key UTF8String]);
                NSString *attributes = [NSString stringWithUTF8String:property_getAttributes(p)];
                NSArray *sp = [attributes componentsSeparatedByString:@"\""];
                NSString *className = nil;
                if ([sp count] >= 2) {
                    className = [sp objectAtIndex:1];
                }
                if (className) {
                    Class c = NSClassFromString(className);
                    if (c && ![value isKindOfClass:c]) {
                        if ([value isKindOfClass:[NSNumber class]] && [c isSubclassOfClass:[NSString class]]) {
                            value = [(NSNumber *)value stringValue];
                        } else if ([value isKindOfClass:[NSString class]] && [c isSubclassOfClass:[NSNumber class]]) {
                            value = @([(NSString *)value longLongValue]);
                        } else if ([value isKindOfClass:[NSDictionary class]] && [c isSubclassOfClass:[JSModel class]]) {
                            id model = [c modelFromInfo:(NSDictionary *)value];
                            value = model;
                        } else {
                            NSString *reason = [NSString stringWithFormat:@"model: (%@) property: (%@) type: (%@), value type: (%@)", [self class], key, c, [value class]];
                            NSException *exception = [NSException exceptionWithName:@"JSJsonDataFormatException" reason:reason userInfo:@{key: value}];
//#ifdef DEBUG
                            [exception raise];
//#else
//                            NSLog(@"JSJsonDataFormatError: %@", exception);
//                            value = nil;
//#endif
                        }
                    }
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        if (className && ![className hasPrefix:@"NSDictionary"]) {
                            
                        }
                    }
                }
            }
            [self setValue:value forKey:key];
        }
    }
}

- (void)setValue:(id)value forKey:(NSString *)key {
    @try {
        if ([self respondsToSelector:NSSelectorFromString(key)]) {
            [super setValue:value forKey:key];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"model key \"%@\" update exception. : %@", key, exception);
    }
}

#pragma mark - Data
- (NSDictionary *)dictionary {
    NSUInteger count = [[self formatKeys] count];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:count];
    @try {
        for (NSString *key in [self formatKeys]) {
            id value = [self valueForKey:key];
            if (value
                && [value isKindOfClass:[JSModel class]]) {
                [dic setObject:[value dictionary] forKey:key];
            } else {
                [dic setObject:value ? : [NSNull null] forKey:key];
            }
        }
    } @catch (NSException *exception) {
        NSLog(@"Model To dictionary format error : %@", exception);
    }
    return [dic copy];
    //return [self dictionaryWithValuesForKeys:[self formatKeys]];
}

- (NSData *)jsonData {
    NSDictionary *data = [self dictionary];
    NSData *jsonData = nil;
    if (data) {
        jsonData = [NSJSONSerialization dataWithJSONObject:data
                                                   options:kNilOptions
                                                     error:nil];
        
    }
    return jsonData;
}

- (NSString *)jsonString {
    NSData *data = [self jsonData];
    NSString *j = nil;
    if (data) {
        j = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return j;
}

- (NSArray *)customModelKeys {
    return nil;
}

- (NSArray *)formatKeys {
    return [self allPropertyNames];
}

// http://stackoverflow.com/questions/11774162/list-of-class-properties-in-objective-c
- (NSArray *)allPropertyNames {
    if (!__model_allkeys) {
        unsigned count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        NSMutableArray *rv = [NSMutableArray array];
        unsigned i;
        for (i = 0; i < count; i++) {
            objc_property_t property = properties[i];
            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
            [rv addObject:name];
        }
        free(properties);
        __model_allkeys = [rv copy];
    }
    return __model_allkeys;
}
#pragma mark - Helper
- (NSMutableDictionary *)model_userInfo {
    if (__model_userInfo == nil) {
        __model_userInfo = [[NSMutableDictionary alloc] init];
    }
    return __model_userInfo;
}

//- (id)valueForKey:(NSString *)key {
//    id value = nil;
//    @try {
//        value = [super valueForKey:key];
//        if ([value isKindOfClass:[JSModel class]]) {
//            value = [value dictionary];
//        }
//    }
//    @catch (NSException *exception) {
//        NSLog(@"ERROR: current model does not include this key: <%@>", key);
//        value = nil;
//    }
//    return value;
//}
@end
