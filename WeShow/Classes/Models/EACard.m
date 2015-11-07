//
//  EABaseObject.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EACard.h"
#import "EABaseCardView.h"
@implementation EACard 
+ (Class)CardViewClass{
    return [EABaseCardView class];
}

- (void)updateWithData:(NSDictionary *)dict{
    
}
@end


@implementation EASingleLineInputCard

+ (Class)CardViewClass{
    return nil;
}
- (void)updateWithData:(NSDictionary *)dict{
    
}

@end
