//
//  MXNetEngine.m
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/3.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "NetWorkManager.h"
#import "AFNetworking.h"
#import "URLAPI.h"
@interface NetWorkManager()
//@property(nonatomic,retain)AFHTTPRequestOperationManager *AFManager;
@end
@implementation NetWorkManager

#pragma mark - LifeCycle
+ (NetWorkManager *)sharedManager
{
    static NetWorkManager *sharedMXNetManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMXNetManagerInstance = [[self alloc]init];
    });
    return sharedMXNetManagerInstance;
}

- (instancetype)init
{
    if (self = [super init])
    {
       // _AFManager =[AFHTTPRequestOperationManager manager];
       // _AFManager.responseSerializer = [AFJSONResponseSerializer serializer];
       // _AFManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

- (void)dealloc
{
    //[_AFManager release],_AFManager = nil;

}

#pragma Get&Post
- (void)sendGetRequest:(NSString *)path param:(NSDictionary *)params CallBackHandle:(CallBackHandle)cb
{
    AFHTTPRequestOperationManager *AFManager = [AFHTTPRequestOperationManager manager];
    [AFManager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        cb(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:NETWORKERROR object:nil];
    }];
}

- (void)sendPostRequest:(NSString *)path param:(NSDictionary *)params CallBackHandle:(CallBackHandle)cb
{
    AFHTTPRequestOperationManager *AFManager = [AFHTTPRequestOperationManager manager];
    [AFManager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        cb(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
        //[[NSNotificationCenter defaultCenter] postNotificationName:NETWORKERROR object:nil];
    }];
}

@end
