//
//  CommentPostView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/24.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "CommentPostView.h"

@implementation CommentPostView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xf2f2f2);
        _commentFiled = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20 - 40, self.EA_Height - 20 )];
        _commentFiled.backgroundColor = [UIColor whiteColor];
        [self addSubview:_commentFiled];
        
        _postBtn = [[UIButton alloc]initWithFrame:CGRectMake(_commentFiled.EA_Right + 10, 10, 30, 30)];
        [_postBtn setBackgroundImage:[UIImage imageNamed:@"history_send"] forState:UIControlStateNormal];
        [self addSubview:_postBtn];
        [_postBtn addTarget:self action:@selector(postClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)postClick{
    self.postBtnBlock();
}

@end
