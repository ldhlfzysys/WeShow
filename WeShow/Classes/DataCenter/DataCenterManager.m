//
//  DataCenterManager.m
//  ShopNCApp
//
//  Created by liudonghuan on 15/6/5.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "DataCenterManager.h"
#import "FMDB.h"


@interface DataCenterManager()
@property (nonatomic,retain) NSString *dbPath;
@property (nonatomic,retain) FMDatabase *db;
@property (nonatomic,retain) FMDatabaseQueue *queue;
@property (nonatomic,retain) FMDatabasePool *pool;
@end



@implementation DataCenterManager

#pragma mark LifeCycle
+ (DataCenterManager *)sharedManager
{
    static DataCenterManager *dataCenterManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataCenterManager = [[DataCenterManager alloc]init];
    });
    return dataCenterManager;
}

- (instancetype)init
{
    if (self == [super init])
    {
        NSString * doc = PATH_OF_DOCUMENT;
        NSString * path = [doc stringByAppendingPathComponent:@"user.sqlite"];
        self.dbPath = path;
        //[self creatTable];
    }
    return self;
}

- (void)creatTable{
        // create it
        FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
        if ([db open]) {
            NSString * sql = @"CREATE TABLE 'user' ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'name' VARCHAR(30), 'password' VARCHAR(30))";
            BOOL res = [db executeUpdate:sql];
            if (!res) {
                NSLog(@"error when creating db table");
            } else {
                NSLog(@"succ to creating db table");
            }
            [db close];
        } else {
            NSLog(@"error when open db");
        }
    [self insert];

}


- (void)insert{
    static int idx = 1;
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"insert into user (name, password) values(?, ?) ";
        NSString * name = [NSString stringWithFormat:@"tangqiao%d", idx++];
        BOOL res = [db executeUpdate:sql, name, @"boy"];
        if (!res) {
            NSLog(@"error to insert data");
        } else {
            NSLog(@"succ to insert data");
        }
        [db close];
    }
    [self find];
}

- (void)find{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString * sql = @"select * from user";
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int userId = [rs intForColumn:@"id"];
            NSString * name = [rs stringForColumn:@"name"];
            NSString * pass = [rs stringForColumn:@"password"];
            NSLog(@"user id = %d, name = %@, pass = %@", userId, name, pass);
        }
        [db close];
    }
}


@end
