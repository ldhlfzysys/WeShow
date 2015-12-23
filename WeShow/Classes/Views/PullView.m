//
//  PullView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "PullView.h"

@interface PullView ()
{
    CGFloat originX;
    NSInteger nowIndex;
}

@end

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
        _tapImage.image = [UIImage imageNamed:@"map_pull_down"];
        [self addSubview:_tapImage];
        
        _tapControlImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tapControlWidth, tapControlHeight)];
        _tapControlImage.userInteractionEnabled = YES;
        _tapControlImage.EA_CenterX = _bgImage.frame.size.width/2;
        [self addSubview:_tapControlImage];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(positionChange:)];
        [_tapControlImage addGestureRecognizer:tapGes];
        
        _mainScorll = [[UIScrollView alloc]initWithFrame:CGRectMake(15, tapControlHeight, self.EA_Width - 30, self.EA_Height - tapControlHeight - 40)];//减去40用于放uipagecontrol
        _mainScorll.contentSize = CGSizeMake((self.EA_Width - 30) * 3, _mainScorll.EA_Height);
        _mainScorll.delegate = self;
        _mainScorll.pagingEnabled = YES;
        _mainScorll.clipsToBounds = NO;

        _mainScorll.autoresizesSubviews = NO;
        _mainScorll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _mainScorll.multipleTouchEnabled = NO;
        [_mainScorll setContentOffset:CGPointMake(self.EA_Width - 30, 0)];
        
        
        [self addSubview:_mainScorll];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 8)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 1;
        _pageControl.EA_CenterX = self.EA_Width / 2;
        _pageControl.EA_Bottom = self.EA_Height - 16;
        [self addSubview:_pageControl];
        
        
        
        
        
    }
    return self;
}

- (void)scrollToIndex:(NSInteger)index
{
    _pageControl.currentPage = index;
    [_mainScorll setContentOffset:CGPointMake(index * _mainScorll.EA_Width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/_mainScorll.EA_Width;
    _pageControl.currentPage = index;
    [self.delegate pullViewScrollToIndex:index];
}

- (void)positionChange:(UITapGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(pullViewPositionChange:)]) {
        [self.delegate pullViewPositionChange:gesture];
    }
    
}





@end
