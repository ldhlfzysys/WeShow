//
//  MultiIncidentTableViewCell.m
//  WeShow
//
//  Created by liudonghuan on 15/12/20.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "MultiIncidentTableViewCell.h"
#import "ImageMultiLineIncident.h"
#import "MultiIncidentScrollView.h"
#import "OnelineView.h"
#import "CommontView.h"

@implementation MultiIncidentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = UIColorFromRGB(0x373b47);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}

//281
- (void)loadStyle1{
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, 81)];
    [self addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(10, view1.EA_Bottom, self.EA_Width - 20, 10)];
    [self addSubview:view2];
    
    MultiIncidentScrollView *view3 = [[MultiIncidentScrollView alloc]initWithFrame:CGRectMake(10, view2.EA_Bottom, self.EA_Width - 20, 170)];
    [self addSubview:view3];
}

//101
- (void)loadStyle2{
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, 81)];
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 3;
    [self addSubview:view1];
}

//176
- (void)loadStyle3{
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(10, 10, self.EA_Width - 20, 81)];
    [self addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(10, view1.EA_Bottom, self.EA_Width - 20, 10)];
    [self addSubview:view2];
    
    CommontView *view3 = [[CommontView alloc]initWithFrame:CGRectMake(10, view2.EA_Bottom, self.EA_Width - 20, 65)];
    [self addSubview:view3];
}



@end
