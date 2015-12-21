//
//  UserIncidentTableViewCell.m
//  WeShow
//
//  Created by liudonghuan on 15/12/21.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "UserIncidentTableViewCell.h"
#import "ImageMultiLineIncident.h"
#import "OnelineView.h"
#import "MultiIncidentScrollView.h"
#import "CommontView.h"


@implementation UserIncidentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

//281
- (void)loadStyle1{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 281+53.5)];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    [_bgView addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(46, view1.EA_Bottom, self.EA_Width - 56, 10)];
    [_bgView addSubview:view2];
    
    MultiIncidentScrollView *view3 = [[MultiIncidentScrollView alloc]initWithFrame:CGRectMake(46, view2.EA_Bottom, self.EA_Width - 56, 170)];
    [_bgView addSubview:view3];
}

//101
- (void)loadStyle2{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 101+53.5)];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    [_bgView addSubview:view1];
}

//176
- (void)loadStyle3{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 176+53.5)];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    [_bgView addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(46, view1.EA_Bottom, self.EA_Width - 56, 10)];
    [_bgView addSubview:view2];
    
    CommontView *view3 = [[CommontView alloc]initWithFrame:CGRectMake(46, view2.EA_Bottom, self.EA_Width - 56, 65)];
    [_bgView addSubview:view3];
}

- (void)loadStyle4{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 68)];
    [self addSubview:_bgView];
    [_bgView hughMode];
}

@end
