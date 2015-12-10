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
        _tapImage.image = [UIImage imageNamed:@"map_pull_up"];
        [self addSubview:_tapImage];
        
        _tapControlImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tapControlWidth, tapControlHeight)];
        _tapControlImage.userInteractionEnabled = YES;
        _tapControlImage.EA_CenterX = _bgImage.frame.size.width/2;
        [self addSubview:_tapControlImage];
        
        UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(positionChange:)];
        [_tapControlImage addGestureRecognizer:panGes];
        
        _mainScorll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, tapControlHeight, self.EA_Width, self.EA_Height - tapControlHeight - 40)];//减去40用于放uipagecontrol
        _mainScorll.contentSize = CGSizeMake(self.EA_Width * 3, _mainScorll.EA_Height);
        _mainScorll.delegate = self;
        _mainScorll.userInteractionEnabled = NO;
        [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width, 0)];
        
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

- (void)positionChange:(UIPanGestureRecognizer *)gesture
{
    if ([self.delegate respondsToSelector:@selector(pullViewPositionChange:)]) {
        [self.delegate pullViewPositionChange:gesture];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    originX = [touch locationInView:self].x;
    if (_mainScorll.contentOffset.x == 30) {//第一屏
        nowIndex = 1;
    }else if (_mainScorll.contentOffset.x == 375){//第二屏
        nowIndex = 2;
    }else{//第三屏
        nowIndex = 3;
    }
    
}

- (void)scrollToIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            [UIView animateWithDuration:1 animations:^{
                [_mainScorll setContentOffset:CGPointMake(30, 0)];
            }];
            break;
        }
        case 1:
        {
            [UIView animateWithDuration:1 animations:^{
                [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width, 0)];
            }];
            break;
        }
        case 2:
        {
            [UIView animateWithDuration:1 animations:^{
                [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width * 2 - 30, 0)];
            }];
            break;
        }
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGFloat endX = [touch locationInView:self].x;;
    
    switch (nowIndex) {
        case 1:
        {
            if (originX < endX) {//上一个
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(30, 0)];
                }];
                _pageControl.currentPage = 0;
                [self.delegate pullViewScrollToIndex:0];
            }else{
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width, 0)];
                }];
                _pageControl.currentPage = 1;
                [self.delegate pullViewScrollToIndex:1];
            }
            break;
        }
        case 2:
        {
            if (originX < endX) {//上一个
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(30, 0)];
                }];
                _pageControl.currentPage = 0;
                [self.delegate pullViewScrollToIndex:0];
            }else{
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width * 2 - 30, 0)];
                }];
                _pageControl.currentPage = 2;
                [self.delegate pullViewScrollToIndex:2];
            }
            break;
        }
        case 3:
        {
            if (originX < endX) {//上一个
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width, 0)];
                }];
                _pageControl.currentPage = 1;
                [self.delegate pullViewScrollToIndex:1];
            }else{
                [UIView animateWithDuration:1 animations:^{
                    [_mainScorll setContentOffset:CGPointMake(_mainScorll.EA_Width * 2 - 30, 0)];
                }];
                _pageControl.currentPage = 2;
                [self.delegate pullViewScrollToIndex:2];
            }
            break;
        }
            
        default:
            break;
    }
    
}


@end
