//
//  UIView+Sizes.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "UIView+Sizes.h"

@implementation UIView (Sizes)

- (CGFloat)EA_Left{
    return self.frame.origin.x;
}

- (void)setEA_Left:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)EA_Top{
    return self.frame.origin.y;
}

- (void)setEA_Top:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)EA_Right{
    return self.frame.origin.y + self.frame.size.width;
}

- (void)setEA_Right:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)EA_Bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEA_Bottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)EA_CenterX{
    return self.center.x;
}

- (void)setEA_CenterX:(CGFloat)x{
    self.center = CGPointMake(x, self.center.y);
}

- (CGFloat)EA_CenterY{
    return self.center.y;
}

- (void)setEA_CenterY:(CGFloat)y{
    self.center = CGPointMake(self.center.x, y);
}

@end
