//
//  AppUser.m
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/5.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "AppUser.h"
#import "NSDictionary+Utils.h"
@implementation AppUser

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (dict == nil || ![dict isKindOfClass:[NSDictionary class]])
    {
        return nil;
    }
    if (self == [super init])
    {
        [self userFromDictionary:dict];
    }
    return self;
}

- (BOOL)userFromDictionary:(NSDictionary *)dict
{
    self.uuid = [dict EA_stringForKey:@"uuid"];
    self.name = [dict EA_stringForKey:@"name"];
    self.password = [dict EA_stringForKey:@"password"];
    self.gender = [dict EA_stringForKey:@"gender"];
    self.mobile = [dict EA_stringForKey:@"mobile"];
    self.ifDelete = [dict EA_integerForKey:@"ifDelete"];
    self.insertTime = [dict EA_stringForKey:@"insertTime"];
    return true;
}



@end
