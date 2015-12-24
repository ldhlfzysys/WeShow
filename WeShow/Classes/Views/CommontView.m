//
//  CommontView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "CommontView.h"

@implementation CommontView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *mark = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 35, 35)];
        mark.image = [UIImage imageNamed:@"history_mark"];
        [self addSubview:mark];
        
        _commontLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, self.EA_Width - 30, 35)];
        _commontLabel.font = [UIFont systemFontOfSize:14];
        _commontLabel.textColor = UIColorFromRGB(0x636466);
        _commontLabel.numberOfLines = 2;
        _commontLabel.text = @"asdlfkj asdkjf alskdjf laksdjflkaskdjf laksdjflkskdjf laksdjflkskdjf laksdjflk sjdlfkajsd lfkjasdlkf ";
        [self addSubview:_commontLabel];
    }
    return self;
}

- (void)updateDatas:(NSDictionary *)dict{
    NSString *commmontLabel = [dict objectForKey:@"commontLabel"];
    _commontLabel.text = commmontLabel;
}
@end
