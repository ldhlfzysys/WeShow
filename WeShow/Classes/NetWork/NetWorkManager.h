//
//  MXNetEngine.h
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/3.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CallBackHandle)(id responseObject);
@interface NetWorkManager : NSObject
/**
 *  网络单例的获取
 *
 *  @return 获得网络访问管理器
 */
+ (NetWorkManager *)sharedManager;
/**
 *  发起一个Get请求，获得json格式response
 *
 *  @param path   请求路径
 *  @param params 请求的参数字典
 *  @param cb     handle请求结果
 */
- (void)sendGetRequest:(NSString *)path param:(NSDictionary *)params CallBackHandle:(CallBackHandle)cb;
/**
 *  发起一个Post请求，获得json格式response
 *
 *  @param path   请求路径
 *  @param params 请求的参数字典
 *  @param cb     handle请求结果
 */
- (void)sendPostRequest:(NSString *)path param:(NSDictionary *)params CallBackHandle:(CallBackHandle)cb;
@end
