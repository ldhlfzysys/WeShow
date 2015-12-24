//
//  PullViewNew.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "NewPullView.h"

@interface NewPullView ()
{
    CGFloat originX;
    NSInteger nowIndex;
}

@end
@implementation NewPullView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGB(0x373b47);
        _myScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(12.5, 20, self.EA_Width - 25, self.EA_Height - 48 - 15)];//减去40用于放uipagecontrol
        _myScroll.contentSize = CGSizeMake(_myScroll.EA_Width * 3, _myScroll.EA_Height);

        _myScroll.delegate = self;
        _myScroll.pagingEnabled = YES;
        _myScroll.clipsToBounds = NO;
        _myScroll.showsHorizontalScrollIndicator = NO;
        _myScroll.showsVerticalScrollIndicator = NO;
//
        _myScroll.autoresizesSubviews = NO;
        _myScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _myScroll.multipleTouchEnabled = NO;
        
        
        [self addSubview:_myScroll];
        
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 8)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.EA_CenterX = self.EA_Width / 2;
        _pageControl.EA_Bottom = self.EA_Height - 15;
        [self addSubview:_pageControl];
    }
    return self;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/_myScroll.EA_Width;
    _pageControl.currentPage = index;
}



- (void)positionChange:(UITapGestureRecognizer *)gesture
{
    
    
}


@end
