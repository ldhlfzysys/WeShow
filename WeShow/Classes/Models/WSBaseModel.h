//
//  WSBaseModel.h
//  WeShow
//
//  Created by liudonghuan on 15/12/25.
//  Copyright © 2015年 Weibo. All rights reserved.
//

//数据解析成Model
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WSModelType){
    WSModelTypeImageMultiLineText   = 0,//左图右文多行文字
    WSModelTypeComment              = 1,//评论
    WSModelTypeOneText              = 2,//单行文字+横线
    WSModelTypeIncidentLive         = 3,//单个时间大图带Live红点标
    WSModelTypeIncidentShadow       = 4,//单个事件大图带蒙层
    WSModelTypeImageUserText        = 5,//带用户数据、赞
    WSModelTypeMultiIncidentScroll  = 6,//多个事件的滚动视图
};

@interface WSBaseModel : NSObject
+ (Class)modelClassFromDict:(NSDictionary *)dict;
- (BOOL)updateFromDict:(NSDictionary *)dict;
@end


@interface ImageMultiLineText : WSBaseModel

@end

@interface Comment  : WSBaseModel

@end

@interface OneText : WSBaseModel

@end

@interface IncidentLive : WSBaseModel

@end

@interface IncidentShadow : WSBaseModel

@end

@interface ImageUserText : WSBaseModel

@end

@interface MultiIncidentScroll : WSBaseModel

@end
