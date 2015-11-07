//
//  AppUser.h
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/5.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EABaseModel.h"

@interface AppUser : EABaseModel
@property (nonatomic, retain) NSString *uuid;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *gender;//性别
@property (nonatomic, retain) NSString *mobile;//手机号
@property (nonatomic, assign) NSInteger ifDelete;
@property (nonatomic, retain) NSString *insertTime;


@end
