//
//  EABaseObject.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, EACardType) {
    EACardTypeSingleLineInputCard = 0,

};

@interface EACard : NSObject
+ (Class)CardViewClass;
- (void)updateWithData:(NSDictionary *)dict;
@end

@interface EASingleLineInputCard : EACard
@property BOOL needGender;
@property BOOL needGetCheckCode;
@property (nonatomic, retain) NSString *headTitleText;
@property (nonatomic, retain) NSString *contentText;

@end





