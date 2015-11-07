//
//  Tools.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    NavTypeMainPage = 0,
}NavType;

@interface Tools : NSObject
+(UINavigationController *)getNavByType:(NavType)type controller:(UIViewController *)con;
+ (UILabel *)getTitleLab:(NSString *)title;
+ (UIButton *)getBackBarBtn;
@end
