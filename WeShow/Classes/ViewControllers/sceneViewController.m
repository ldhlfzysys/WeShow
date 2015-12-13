//
//  sceneViewController.m
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "sceneViewController.h"
#import "mediaView.h"

#define PADDING 20

@interface sceneViewController()
@property(strong,nonatomic) UIScrollView *photoScrollerView;
@property(strong,nonatomic) mediaView *currentMediaView;
@property(strong,nonatomic) mediaView *nextMediaView;
@property(strong,nonatomic) mediaView *nnextMediaView;

@property (strong,nonatomic) NSArray *mediaURLs;
@property(assign,nonatomic) NSInteger currentPageNum;

@end

@implementation sceneViewController

- (void)viewDidLoad
{
    self.mediaURLs = [NSArray arrayWithObjects:@"1", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    self.currentPageNum = 1;
    [self scrollViewInit];
}

//计算ScrollerView的宽度
- (CGRect)frameForPagingScrollView
{
    CGRect frame = self.view.bounds;
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    return frame;
}

- (void) scrollViewInit
{
    CGRect scrollFrame = [self frameForPagingScrollView];
    if (_photoScrollerView == nil) {
        _photoScrollerView = [[UIScrollView alloc] initWithFrame:scrollFrame];
    }
    [_photoScrollerView setDecelerationRate:0.0];
    
    //暂时定10个
    _photoScrollerView.contentSize = CGSizeMake((self.view.bounds.size.width + 2 * 20) * 10, 0.0f);
    [_photoScrollerView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    _photoScrollerView.pagingEnabled = YES;
    [_photoScrollerView setBackgroundColor:[UIColor clearColor]];
    [_photoScrollerView setAutoresizesSubviews:YES];
    _photoScrollerView.showsHorizontalScrollIndicator = NO;
    _photoScrollerView.showsVerticalScrollIndicator = NO;
    _photoScrollerView.decelerationRate = UIScrollViewDecelerationRateFast;
    [_photoScrollerView setDelegate:self];
    
    if (_currentMediaView == nil) {
        _currentMediaView = [[mediaView alloc] initWithFrame:self.view.bounds URL:[_mediaURLs objectAtIndex:0] isVideo:YES];
    }
    
    if (_nextMediaView == nil) {
        _nextMediaView = [[mediaView alloc] initWithFrame:CGRectZero URL:[_mediaURLs objectAtIndex:1] isVideo:YES];
    }
    
    if (_nnextMediaView == nil) {
        _nnextMediaView = [[mediaView alloc] initWithFrame:CGRectZero URL:[_mediaURLs objectAtIndex:2] isVideo:YES];
    }
    
//    CGPoint offset;
//    offset.x = 0;
//    offset.y = 0;
//    
//    [_photoScrollerView setContentOffset:offset animated:NO];
//    _photoScrollerView.contentSize = CGSizeMake((self.view.bounds.size.width + 2 * 20) * 10, 0.0f);
    

    [_photoScrollerView addSubview:_currentMediaView];
    [_photoScrollerView addSubview:_nextMediaView];
    [_photoScrollerView addSubview:_nnextMediaView];
    
    [self.view addSubview:_photoScrollerView];
    
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index
{
    CGRect bounds = [_photoScrollerView frame];
    CGRect rect = [UIScreen mainScreen].bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.size.height = rect.size.width;
    
    pageFrame.origin.y = 0;
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(_currentMediaView.isVideo)
    {
        [_currentMediaView.avPlayer pause];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    mediaView *tempPage = nil;
    _currentPageNum++;
    
    tempPage = _currentMediaView;
    _currentMediaView = _nextMediaView;
    _nextMediaView = _nnextMediaView;
    _nnextMediaView = tempPage;
    
    _currentMediaView.frame = [self frameForPageAtIndex:_currentPageNum ];
    _nextMediaView.frame = [self frameForPageAtIndex:(_currentPageNum + 1)];
    
    _nnextMediaView = [[mediaView alloc]initWithFrame:[self frameForPageAtIndex:(_currentPageNum + 2)] URL:[_mediaURLs objectAtIndex:(_currentPageNum + 1)] isVideo:YES];
    
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _photoScrollerView.frame.size.width;
    int page = floor((_photoScrollerView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    if (page > _currentPageNum + 1 || page < _currentPageNum - 1) {
        CGPoint point;
        point.x = _currentPageNum * pageWidth;
        point.y = _photoScrollerView.contentOffset.y;
        _photoScrollerView.contentOffset = point;
    }
    
}
@end
