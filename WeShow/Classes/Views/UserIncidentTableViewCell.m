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
#import "CommentView.h"


@implementation UserIncidentTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
    }
    return self;
}

//281
- (void)loadStyle1:(NSDictionary *)dict{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 281+53.5)];
    [_bgView updateDatas:[dict objectForKey:@"userInfoData"]];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    [view1 updateDatas:[dict objectForKey:@"imageMultiLineIncidentData"]];
    [_bgView addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(46, view1.EA_Bottom, self.EA_Width - 56, 10)];
    [view2 updateDatas:[dict objectForKey:@"onelineViewData"]];
    [_bgView addSubview:view2];
    
    MultiIncidentScrollView *view3 = [[MultiIncidentScrollView alloc]initWithFrame:CGRectMake(46, view2.EA_Bottom, self.EA_Width - 56, 170)];
    [view3 updateDatas:[dict objectForKey:@"multiIncidentData"]];
    [_bgView addSubview:view3];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view1.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view1.bounds;
    maskLayer.path = maskPath.CGPath;
    view1.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:view3.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = view3.bounds;
    maskLayer1.path = maskPath1.CGPath;
    view3.layer.mask = maskLayer1;

}

//101
- (void)loadStyle2:(NSDictionary *)dict{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 101+53.5)];
    [_bgView updateDatas:[dict objectForKey:@"userInfoData"]];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    view1.layer.masksToBounds = YES;
    view1.layer.cornerRadius = 5;
    [view1 updateDatas:[dict objectForKey:@"imageMultiLineIncidentData"]];
    [_bgView addSubview:view1];
}

//176
- (void)loadStyle3:(NSDictionary *)dict{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 176+53.5)];
    [_bgView updateDatas:[dict objectForKey:@"userInfoData"]];
    [self addSubview:_bgView];
    
    ImageMultiLineIncident *view1 = [[ImageMultiLineIncident alloc]initWithFrame:CGRectMake(46, 40, self.EA_Width - 56, 81)];
    [view1 updateDatas:[dict objectForKey:@"imageMultiLineIncidentData"]];
    [_bgView addSubview:view1];
    
    OnelineView *view2 = [[OnelineView alloc]initWithFrame:CGRectMake(46, view1.EA_Bottom, self.EA_Width - 56, 10)];
    [view2 updateDatas:[dict objectForKey:@"onelineViewData"]];
    [_bgView addSubview:view2];
    
    CommentView *view3 = [[CommentView alloc]initWithFrame:CGRectMake(46, view2.EA_Bottom, self.EA_Width - 56, 65)];
    [view3 updateDatas:[dict objectForKey:@"commontData"]];
    [_bgView addSubview:view3];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view1.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view1.bounds;
    maskLayer.path = maskPath.CGPath;
    view1.layer.mask = maskLayer;
    
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:view3.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = view3.bounds;
    maskLayer1.path = maskPath1.CGPath;
    view3.layer.mask = maskLayer1;
    
}

- (void)loadStyle4:(NSDictionary *)dict{
    _bgView = [[UserIncidentView alloc]initWithFrame:CGRectMake(0, 0, self.EA_Width, 68)];
    [_bgView updateDatas:[dict objectForKey:@"userInfoData"]];    
    [self addSubview:_bgView];
    [_bgView hughMode];
}

@end
