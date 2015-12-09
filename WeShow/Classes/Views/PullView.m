//
//  PullView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "PullView.h"

@implementation PullView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        CGFloat tapControlHeight = self.EA_Width * 0.04;
        CGFloat tapControlWidth = self.EA_Width * 0.126;
        
        _bgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _bgImage.image = [UIImage imageNamed:@"map_pull"];
        [self addSubview:_bgImage];
        
        
        _tapImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, tapControlWidth - 10, tapControlHeight - 10)];
        _tapImage.EA_CenterX = _bgImage.frame.size.width/2;
        _tapImage.image = [UIImage imageNamed:@"map_pull_up"];
        [self addSubview:_tapImage];
        
        _tapControlImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tapControlWidth, tapControlHeight)];
        _tapControlImage.userInteractionEnabled = YES;
        _tapControlImage.EA_CenterX = _bgImage.frame.size.width/2;
        [self addSubview:_tapControlImage];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(positionChange:)];
        [_tapControlImage addGestureRecognizer:panGes];
        
        _mainScorll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tapControlHeight, self.EA_Width, self.EA_Height - tapControlHeight - 40)];//减去40用于放uipagecontrol
        _mainScorll.contentSize = CGSizeMake(self.EA_Width * 3, self.EA_Height);
        _mainScorll.delegate = self;
        [self addSubview:_mainScorll];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 8)];
        _pageControl.numberOfPages = 3;
        _pageControl.EA_CenterX = self.EA_Width / 2;
        _pageControl.EA_Bottom = self.EA_Height - 16;
        [self addSubview:_pageControl];
        
        
        
    }
    return self;
}

- (void)positionChange:(UIPanGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(pullViewPositionChange:)]) {
        [self.delegate pullViewPositionChange:gesture];
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(pullViewDidScroll:)]) {
        [self.delegate pullViewDidScroll:scrollView];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
}

@end
