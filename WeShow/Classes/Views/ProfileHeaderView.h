//
//  ProfileHeaderView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoLineButton : UIButton
@property (nonatomic,strong)UILabel *numLabel;
@property (nonatomic,strong)UILabel *descLabel;
@end

@interface ProfileHeaderView : UIView
@property (nonatomic,strong)UIImageView *topImage;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *descLabel;
@property (nonatomic,strong)TwoLineButton *viewer;
@property (nonatomic,strong)TwoLineButton *follower;
@property (nonatomic,strong)TwoLineButton *history;
@end
