//
//  AppDelegate.m
//  model
//
//  Created by Jey on 3/22/16.
//  Copyright © 2016 shushujia. All rights reserved.
//

#import "AppDelegate.h"
#import "User.h"
#import "model-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    window.backgroundColor = [UIColor whiteColor];
    [window makeKeyAndVisible];
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view.backgroundColor = [UIColor lightGrayColor];
    window.rootViewController = controller;
    self.window = window;
    
    
    NSString *json =
    @"{\
        \"uid\": 1,\
        \"name\": \"jim\",\
        \"gender\": 0,\
        \"time\": 1458620423,\
        \"follower\": 23,\
        \"unuse_key\": \"nodata\",\
        \"icons\": [\"http://xxx.com/1\",\
                  \"http://xxx.com/2\"],\
        \"custom_array\":\"data0,data1,data2\"\
    }";
    
    User *user = [User modelFromJSONString:json];
    NSAssert(user != nil, @"model parser error.");
    NSAssert(user.uid == 1, [self errorString:@selector(uid)]);
    NSAssert([@"jim" isEqualToString:user.name], [self errorString:@selector(name)]);
    NSAssert(1458620423 == user.time, [self errorString:@selector(time)]);
    NSAssert(23 == [user.follower intValue], [self errorString:@selector(follower)]);
    NSAssert(2 == [user.icons count], [self errorString:@selector(icons)]);
    NSAssert(3 == [user.custom_array count], [self errorString:@selector(custom_array)]);
    
    NSLog(@"%@", [user jsonString]);
    
    
    NSString *json_h = [NSString stringWithFormat:
    @"{\
        \"address\": \"beijing chaoyang sanlitun\",\
        \"rooms_count\": 3,\
        \"owner\": %@,\
        \"rooms_name\": [\
                       \"room_01\",\
                       \"room_02\",\
                       \"room_03\"\
                       ]\
    }", json];
    
    
    Home *home = [Home modelFromJSONString:json_h];
    NSAssert(home != nil, @"model parser error.");
    NSAssert([@"beijing chaoyang sanlitun" isEqualToString:home.address], [self errorString:@selector(address)]);
    NSAssert(3 == [home.rooms_count unsignedIntValue], [self errorString:@selector(rooms_count)]);
    NSAssert([home.owner isKindOfClass:[User class]], [self errorString:@selector(owner)]);
    NSAssert([home.owner isEqual:user], [self errorString:@selector(owner)]);
    NSAssert(3 == [home.rooms_name count], [self errorString:@selector(rooms_count)]);
    
    NSLog(@"%@", [home jsonString]);
    
    return YES;
}

- (NSString *)errorString:(SEL)selector {
    return [NSString stringWithFormat:@"model(%@) parser error.", NSStringFromSelector(selector)];
}

@end
