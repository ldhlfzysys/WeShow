//
//  OnelineView.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "OnelineView.h"

@implementation OnelineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 10)];
        _nameLabel.font = [UIFont systemFontOfSize:10];
        _nameLabel.textColor = UIColorFromRGB(0xdddee2);
        _nameLabel.text = @"我发布的";
        [_nameLabel sizeToFit];
        [self addSubview:_nameLabel];
        
        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(_nameLabel.EA_Right + 10, 0, self.EA_Width - _nameLabel.EA_Right - 20, 1)];
        line.backgroundColor = UIColorFromRGB(0xdddee2);
        line.EA_CenterY = self.EA_Height/2;
        [self addSubview:line];
    }
    return self;
}

- (void)updateDatas:(NSDictionary *)dict{
    NSString *nameLabel = [dict objectForKey:@"name"];
    if (nameLabel.length > 0 ) {
    _nameLabel.text = nameLabel;        
    }

}

@end
