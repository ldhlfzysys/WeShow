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

@end

@implementation sceneViewController

- (void)viewDidLoad
{
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
    
    /**
     *  创建三个 largeview 页面，并且填充缩略图
     */
    if (_currentMediaView == nil) {
        _currentMediaView = [[mediaView alloc] initWithFrame:self.view.bounds URL:@"" isVideo:YES];
    }
    
    if (_nextMediaView == nil) {
        _nextMediaView = [[mediaView alloc] initWithFrame:CGRectZero URL:@"" isVideo:YES];
    }
    
    if (_nnextMediaView == nil) {
        _nnextMediaView = [[mediaView alloc] initWithFrame:CGRectZero URL:@"" isVideo:YES];
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

@end
