//
//  Tools.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+(UINavigationController *)getNavByType:(NavType)type controller:(UIViewController *)con
{
    //MLNavtigationController 重写了uinavigationcontroller。MLNavigationController有返回手势
    //右滑返回手势和百度地图冲突了，在没有别的方法之前就暂时放弃使用右滑返回
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:con];
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]init];
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    navC.tabBarItem = tabBarItem;
    
    navC.navigationBar.translucent = NO;//半透明有光泽
    navC.navigationBar.barTintColor = UIColorFromRGB(0x495262);
    //自定义标题
    UILabel *label = [[UILabel alloc] init];
    navC.navigationBar.topItem.titleView=label;
    switch (type) {
        case NavTypeMainPage:
        {
            tabBarItem.image  = [UIImage imageNamed:@"tabbar_1.png"];
            //后面那句就让图片能正常显示了
            tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_1_se.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            tabBarItem.title = @"发现";
            label.text = @"WeShow";
            break;
        }

        default:
            break;
    }
    [label setFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    return navC;
}

+ (UILabel *)getTitleLab:(NSString *)title{
    UILabel *label = [[UILabel alloc] init];
    [label setFrame:CGRectMake(0, 0, 160, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    label.text = title;
    return label;
    
}

+ (UIButton *)getBackBarBtn{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 24, 40)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 13, 14, 14)];
    img.image = [UIImage imageNamed:@"back.png"];
    [btn addSubview:img];
    return btn;
}

+ (UIButton *)getNavigationItemWithImage:(NSString *)imageName{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    img.image = [UIImage imageNamed:imageName];
    [btn addSubview:img];
    return btn;
}
@end
