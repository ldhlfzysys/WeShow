//
//  NSDictionary+Utils.m
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/5.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "NSDictionary+Utils.h"
@implementation NSDictionary (Utils)
- (NSString*)EA_stringForKey:(NSString*)key
{
    id obj = [self objectForKey:key];
    if (![obj isKindOfClass:[NSString class]])
    {
        if ([obj isKindOfClass:[NSNumber class]])
        {
            return [obj stringValue];
        }
        return nil;

    }
    return obj;
}

- (NSInteger)EA_integerForKey:(NSString*)key{
    id obj = [self objectForKey:key];
    if ([obj respondsToSelector:@selector(integerValue)])
        return [obj integerValue];
    
    return 0;
}
@end
