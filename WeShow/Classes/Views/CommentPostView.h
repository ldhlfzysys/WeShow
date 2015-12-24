//
//  CommentPostView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/24.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^PostBtnClick) (void);

@interface CommentPostView : UIView

@property (nonatomic,strong)UITextField *commentFiled;
@property (nonatomic,strong)UIButton *postBtn;
@property (nonatomic,strong)PostBtnClick postBtnBlock;
@end
