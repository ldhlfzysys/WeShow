//
//  WSBaseView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/25.
//  Copyright © 2015年 Weibo. All rights reserved.
//

//纯视图
#import <UIKit/UIKit.h>
#import "WSBaseModel.h"

@interface WSBaseView : UIView
@property (nonatomic,strong)WSBaseModel *baseModel;
+ (CGFloat)heightOfObject:(id)object;
@end
