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
    @try {
        NSString *key = @"custom_array";
        id value = nil;
        value = [[info objectForKey:key] componentsSeparatedByString:@","];
        [self setValue:value forKey:key];
        
        self.icons_class = [Icon modelsFromInfos:[info objectForKey:@"icons_class"]];
    }
    @catch (NSException *exception) {
    }
}

- (NSArray *)customModelKeys {
    return @[@"custom_array", @"icons_class"];
}

- (BOOL)isEqual:(id)object {
    BOOL v = NO;
    if (![object isMemberOfClass:[self class]]) {
        return v;
    }
    return (self.uid == [object uid]);
}
@end
