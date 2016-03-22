//
//  JSModel.h
//  model
//
//  Created by Jey on 22/3/16.
//  Copyright © 2016年 Jey All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSModelProtocol <NSObject>
- (NSArray *)customModelKeys;// http response contain cunstom json keys, default nil;
- (NSArray *)formatKeys;// default all properties
@end

@interface JSModel : NSObject <JSModelProtocol>

- (NSString *)jsonString;
- (NSData *)jsonData;
- (NSDictionary *)dictionary;

- (void)update:(NSDictionary *)info;// update model

+ (id)model;
+ (id)modelFromJSONString:(NSString *)json;
+ (id)modelFromJSONData:(NSData *)data;
+ (id)modelFromInfo:(NSDictionary *)info;
+ (NSArray *)modelsFromInfos:(NSArray<NSDictionary *> *)infos;

@property (nonatomic, strong, readonly) NSMutableDictionary *model_userInfo;// save custom info

@end
