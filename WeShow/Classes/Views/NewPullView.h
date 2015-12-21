//
//  PullViewNew.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewPullViewDelegate <NSObject>

- (void)pullViewScrollToIndex:(NSInteger)index;

- (void)pullViewPositionChange:(UITapGestureRecognizer *)gesture;

@end

@interface NewPullView : UIView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *myScroll;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, assign) id<NewPullViewDelegate> delegate;
@property (nonatomic, strong) UIPageControl *pageControl;
- (void)scrollToIndex:(NSInteger)index;
@end
