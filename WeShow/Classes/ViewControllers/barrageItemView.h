//
//  barrageItemView.h
//  WeShow
//
//  Created by insomnia on 15/12/23.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface barrageItemView : UIView
- (void) setContent:(NSString *)str;
@property (assign, nonatomic) NSInteger itemIndex;
@property (strong, nonatomic) UILabel *contentLabel;
@end
