//
//  WSBaseModel+UI.h
//  WeShow
//
//  Created by liudonghuan on 15/12/25.
//  Copyright © 2015年 Weibo. All rights reserved.
//

//通过Model获取对应视图Class
//Model的基本数据处理
#import "WSBaseModel.h"

@interface WSBaseModel (UI)
+ (Class)viewClass;
@end
