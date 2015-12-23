//
//  CommontView.h
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommontView : UIView
@property (nonatomic,strong)UILabel *commontLabel;
- (void)updateDatas:(NSDictionary *)dict;
@end
