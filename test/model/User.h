//
//  User.h
//  model
//
//  Created by Jey on 3/22/16.
//  Copyright © 2016 shushujia. All rights reserved.
//

#import "JSModel.h"
typedef enum: NSInteger {
    MALE = 0,
    FEMALE,
} USER_GENDER;


@interface User : JSModel
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) USER_GENDER gender;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, assign) int follower;

@property (nonatomic, strong) NSArray *icons;

@property (nonatomic, strong) NSArray *custom_array;
@end
