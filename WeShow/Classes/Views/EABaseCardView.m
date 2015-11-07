//
//  EABaseCardView.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EABaseCardView.h"

@implementation EABaseCardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setCard:(EACard *)card{
    
}

- (UIEdgeInsets)edgInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//算高时需要考虑缩进
+ (CGFloat)heightOfCard:(EACard *)card{
    return 0;
}
@end
