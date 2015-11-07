//
//  EABaseCardView.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EACard;
@interface EABaseCardView : UIView

- (void)setCard:(EACard *)card;

//缩进机制暂不加
//- (UIEdgeInsets)edgInsets;

+ (CGFloat)heightOfCard:(EACard *)card;
@end
