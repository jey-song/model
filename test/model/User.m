//
//  User.m
//  model
//
//  Created by Jey on 3/22/16.
//  Copyright © 2016 shushujia. All rights reserved.
//

#import "User.h"
@implementation Icon
@end

@implementation User
- (void)update:(NSDictionary *)info {
    [super update:info];
    id value = nil;
    NSString *key = @"custom_array";
    @try {
        value = [[info objectForKey:key] componentsSeparatedByString:@","];
    }
    @catch (NSException *exception) {
    }
    [self setValue:value forKey:key];
}

- (NSArray *)customModelKeys {
    return @[@"custom_array"];
}

- (BOOL)isEqual:(id)object {
    BOOL v = NO;
    if (![object isMemberOfClass:[self class]]) {
        return v;
    }
    return (self.uid == [object uid]);
}
@end
