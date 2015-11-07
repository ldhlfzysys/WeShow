//
//  URLAPI.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#ifndef EasyApp_URLAPI_h
#define EasyApp_URLAPI_h


#define NETWORKERROR            @"networkerror"
#define BASEURL                 @"http://kuaipin.51dzb.com/"
#define APIURL(url) [NSString stringWithFormat:@"%@%@",BASEURL,url]
//用户接口
#define APIsendCheckNum            APIURL(@"user/sendCheckNum.htm")
#define APIregister                APIURL(@"user/register.htm")
#define APIlogin                   APIURL(@"user/login.htm")
#define APIupdate                  APIURL(@"user/update.htm")
//劳工接口
#define APIaddworker               APIURL(@"worker/add.htm")
#define APIfindworker              APIURL(@"worker/find.htm")
//任务接口
#define APIaddtask                 APIURL(@"task/add.htm")
#define APIfindtask                APIURL(@"task/find.htm")

#endif
