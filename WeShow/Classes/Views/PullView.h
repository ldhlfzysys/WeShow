//
//  PullView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/9.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "EABaseCardView.h"

@protocol PullViewDelegate <NSObject>

- (void)pullViewScrollToIndex:(NSInteger)index;

- (void)pullViewPositionChange:(UITapGestureRecognizer *)gesture;

@end

@interface PullView : EABaseCardView<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *mainScorll;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *tapImage;
@property (nonatomic, strong) UIImageView *tapControlImage;
@property (nonatomic, assign) id<PullViewDelegate> delegate;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) BOOL showing;
- (void)scrollToIndex:(NSInteger)index;
@end
