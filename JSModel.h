//
//  JSModel.h
//  model
//
//  Created by Jey on 16/10/14.
//  Copyright © 2015年 Jey All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSModelProtocol <NSObject>
- (NSSet *)itemKeys;
@end

@interface JSModel : NSObject <JSModelProtocol>

- (NSString *)jsonString;
- (NSData *)jsonData;
- (NSDictionary *)dictionary;
- (void)update:(NSDictionary *)info;

+ (id)model;
+ (id)modelFromJSONString:(NSString *)json;
+ (id)modelFromJSONData:(NSData *)data;
+ (id)modelFromInfo:(NSDictionary *)info;
+ (NSArray *)modelsFromInfos:(NSArray *)infos;

@property (nonatomic, strong, readonly) NSMutableDictionary *model_userInfo;

@end
