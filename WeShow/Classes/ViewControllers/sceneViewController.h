//
//  sceneViewController.h
//  WeShow
//
//  Created by insomnia on 15/12/13.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentPostView.h"

@interface BarrageView : UIView
@property (nonatomic,assign)id superView;
@end

@interface VedioControlView : UIView
@property (nonatomic,strong)CommentPostView *commentView;
@property (strong, nonatomic) UIButton *userImagebutton;
@property (strong, nonatomic) UIButton *userNameButton;
@property (strong, nonatomic) UIButton *createVideobutton;
@property (strong, nonatomic) UIButton *likebutton;
@property (strong, nonatomic) UIButton *forbidBarragebutton;
@property (strong, nonatomic) UIButton *backbutton;
@property (strong, nonatomic) UIButton *sendBarragebutton;
@property (strong, nonatomic) UIButton *skipbutton;
@property (assign, nonatomic) BOOL forbidenBarrage;

@end

@interface sceneViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic,strong)VedioControlView *controlView;
@property (nonatomic,strong)BarrageView *barrageView;
@end
