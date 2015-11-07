//
//  DataCenterManager.h
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/5.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUser.h"
@interface DataCenterManager : NSObject
/**
 *  应用内当前用户
 */
@property(nonatomic,retain)AppUser *currentUser;
/**
 *  获取单例
 *
 *  @return DataCenterMangaer
 */
+ (DataCenterManager *)sharedManager;
@end
