//
//  barrageItemView.m
//  WeShow
//
//  Created by insomnia on 15/12/23.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "barrageItemView.h"
@interface barrageItemView()
@property (strong, nonatomic) UILabel *contentLabel;
@end

@implementation barrageItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 1, 30)];
        [_contentLabel setFont:[UIFont systemFontOfSize:14]];
        [_contentLabel setTextColor:[UIColor whiteColor]];
        [_contentLabel setNumberOfLines:1];
        [self addSubview:_contentLabel];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:15];
        //        [self.layer setBorderColor:[UIColor whiteColor].CGColor];
        //        [self.layer setBorderWidth:1.];
        
        [self setClipsToBounds:YES];
    }
    return self;
}

- (void) setContent:(NSString *)str
{
    [_contentLabel setText:str];
    [_contentLabel sizeToFit];
    self.EA_Width = _contentLabel.EA_Width+10;
}
@end
