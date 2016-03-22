//
//  AppDelegate.m
//  model
//
//  Created by Jey on 3/22/16.
//  Copyright © 2016 shushujia. All rights reserved.
//

#import "AppDelegate.h"

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
    
    
    NSDictionary *dic = @{@"uid": @(111),
                          @""};
    
    return YES;
}

@end
