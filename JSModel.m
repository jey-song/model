//
//  JSModel.m
//  model
//
//  Created by Jey on 16/10/14.
//  Copyright © 2015年 Jey All rights reserved.
//

#import "JSModel.h"

@interface JSModel () {
    NSMutableDictionary *__model_userInfo;
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
    NSSet *keys = [self itemKeys];
    for (NSString *key in enumeratorKey) {
        if ((!keys || [keys containsObject:key])
            && [self respondsToSelector:NSSelectorFromString(key)]) {
            NSObject *value = info[key];
            if ([value isKindOfClass:[NSNull class]]) {
                value = nil;
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
    return nil;
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

- (NSSet *)itemKeys {
    return nil;
}

#pragma mark - Helper
- (NSMutableDictionary *)model_userInfo {
    if (__model_userInfo == nil) {
        __model_userInfo = [[NSMutableDictionary alloc] init];
    }
    return __model_userInfo;
}

- (id)valueForKey:(NSString *)key {
    id value = nil;
    @try {
        value = [super valueForKey:key];
    }
    @catch (NSException *exception) {
        NSLog(@"ERROR: current model does not include this key: <%@>", key);
        value = nil;
    }
    return value;
}
@end
