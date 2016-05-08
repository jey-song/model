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

@interface Icon : JSModel
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *thumb_url;
@end


@interface User : JSModel
@property (nonatomic, assign) long long uid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) USER_GENDER gender;
@property (nonatomic, assign) NSTimeInterval time;
@property (nonatomic, strong) NSNumber *follower;

@property (nonatomic, strong) NSArray *icons;
@property (nonatomic, strong) NSArray <__kindof Icon *> *icons_class;
@property (nonatomic, strong) NSArray *custom_array;

@property (nonatomic, strong) NSString *error_num;
@property (nonatomic, strong) NSNumber *error_str;
@property (nonatomic, assign) long long error_str1;
@property (nonatomic, strong) NSArray *error_dic;
@end
