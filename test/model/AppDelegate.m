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
    NSString *icon_json = @"{\"url\":\"http://xxx.com/1\",\
                            \"thumb_url\":\"http://xxx.com/1/thumb_url\"}";
    
    //\"error_dic\": {\"test\": \"value\"},
    NSString *json = [NSString stringWithFormat:
    @"{\
        \"uid\": 1,\
        \"name\": \"jim\",\
        \"gender\": 0,\
        \"time\": 1458620423,\
        \"follower\": 23,\
        \"error_num\": 23,\
        \"error_str\": \"2s5st\",\
        \"error_str1\": \"429496729843s5st\",\
        \"unuse_key\": \"nodata\",\
        \"icons\": [\"http://xxx.com/1\",\
                      \"http://xxx.com/2\"],\
        \"icons_class\": [%@],\
        \"custom_array\":\"data0,data1,data2\"\
    }", icon_json];
    
    User *user = [User modelFromJSONString:json];
    NSAssert(user != nil, @"model parser error.");
    NSAssert(user.uid == 1, [self errorString:@selector(uid)]);
    NSAssert([@"jim" isEqualToString:user.name], [self errorString:@selector(name)]);
    NSAssert(1458620423 == user.time, [self errorString:@selector(time)]);
    NSAssert(23 == [user.follower intValue], [self errorString:@selector(follower)]);
    NSAssert(2 == [user.icons count], [self errorString:@selector(icons)]);
    NSAssert(1 == [user.icons_class count], [self errorString:@selector(icons_class)]);
    NSAssert([user.icons_class[0] isKindOfClass:[Icon class]], [self errorString:@selector(icons_class)]);
    NSAssert([@"http://xxx.com/1" isEqual:[user.icons_class[0] url]], [self errorString:@selector(icons_class)]);
    NSAssert(3 == [user.custom_array count], [self errorString:@selector(custom_array)]);
    
    NSAssert([user.error_num isKindOfClass:[NSString class]] && [@"23" isEqualToString:user.error_num], [self errorString:@selector(error_num)]);
    NSAssert([user.error_str isKindOfClass:[NSNumber class]] && 2 == [user.error_str longLongValue], [self errorString:@selector(error_str)]);
    NSAssert(429496729843 == user.error_str1, [self errorString:@selector(error_str1)]);
    NSAssert(user.error_dic == nil, [self errorString:@selector(error_dic)]);
    
    NSLog(@"%@", [user jsonString]);
    
    
    NSString *json_h = [NSString stringWithFormat:
    @"{\
        \"address\": \"beijing chaoyang sanlitun\",\
        \"rooms_count\": 3,\
        \"owner\": %@,\
        \"owners\": [%@, %@],\
        \"owners_user\": [%@, %@, %@],\
        \"rooms_name\": [\
                       \"room_01\",\
                       \"room_02\",\
                       \"room_03\"\
                       ]\
    }", json, json, json, json, json, json];
    
    
    Home *home = [Home modelFromJSONString:json_h];
    NSAssert(home != nil, @"model parser error.");
    NSAssert([@"beijing chaoyang sanlitun" isEqualToString:home.address], [self errorString:@selector(address)]);
    NSAssert(3 == [home.rooms_count unsignedIntValue], [self errorString:@selector(rooms_count)]);
    NSAssert([home.owner isKindOfClass:[User class]], [self errorString:@selector(owner)]);
    NSAssert([home.owner isEqual:user], [self errorString:@selector(owner)]);
    NSAssert(3 == [home.rooms_name count], [self errorString:@selector(rooms_count)]);
    NSAssert([home.owners count] == 2, [self errorString:@selector(owners)]);
    NSAssert([home.owners[1] isKindOfClass:[NSDictionary class]], [self errorString:@selector(owners)]);
    //NSAssert([home.owners[1] isKindOfClass:[NSDictionary class]], [self errorString:@selector(owners)]);
    //NSAssert([home.owners_user count] == 3, [self errorString:@selector(owners_user)]);
    //NSAssert([home.owners_user class] == [user class], [self errorString:@selector(owners_user)]);
    //NSAssert([home.owners_user[2] isEqual:user], [self errorString:@selector(owners_user)]);
    
    NSLog(@"%@", [home jsonString]);
    
    return YES;
}

- (NSString *)errorString:(SEL)selector {
    return [NSString stringWithFormat:@"model(%@) parser error.", NSStringFromSelector(selector)];
}

@end
