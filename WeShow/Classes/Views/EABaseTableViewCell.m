//
//  EABaseTableViewCell.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/15.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EABaseTableViewCell.h"

@interface EABaseTableViewCell()


@end

@implementation EABaseTableViewCell

- (instancetype)initWithCard:(EACard*)card Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
         _cardView = [[[[ card class] CardViewClass] alloc]initWithFrame:self.frame];
        //设置card内容
        [_cardView setCard:card];
        //设置缩进
        [self addSubview:_cardView];
    }
    return self;

}

- (void)dealloc{

}

@end
