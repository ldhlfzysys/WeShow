//
//  WSBaseModel.m
//  WeShow
//
//  Created by liudonghuan on 15/12/25.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "WSBaseModel.h"

@implementation WSBaseModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self updateFromDict:dict];
    }
    return self;
}

- (BOOL)updateFromDict:(NSDictionary *)dict
{
    return YES;
}

+ (Class)modelClassByType:(WSModelType)type
{
    Class modelCalss = nil;
    switch (type)
    {
        case WSModelTypeImageMultiLineText:
            modelCalss = [ImageMultiLineText class];
            break;
        case WSModelTypeComment:
            modelCalss = [Comment class];
            break;
        case WSModelTypeOneText:
            modelCalss = [OneText class];
            break;
        case WSModelTypeIncidentLive:
            modelCalss = [IncidentLive class];
            break;
        case WSModelTypeIncidentShadow:
            modelCalss = [IncidentShadow class];
            break;
        case WSModelTypeImageUserText:
            modelCalss = [ImageUserText class];
            break;
        case WSModelTypeMultiIncidentScroll:
            modelCalss = [MultiIncidentScroll class];
            break;
            
        default:
            break;
    }
    return modelCalss;
}

+ (Class)modelClassFromDict:(NSDictionary *)dict
{
    WSModelType type = [[dict objectForKey:@"type"] integerValue];
    return [[self class] modelClassByType:type];
}
@end


@implementation ImageMultiLineText

@end

@implementation Comment

@end

@implementation OneText

@end

@implementation IncidentLive

@end

@implementation IncidentShadow

@end

@implementation ImageUserText

@end

@implementation MultiIncidentScroll

@end