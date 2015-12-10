//
//  CreateViewController.m
//  WeShow
//
//  Created by liudonghuan on 15/12/10.
//  Copyright © 2015年 Weibo. All rights reserved.
//

#import "CreateViewController.h"

@interface CreateViewController ()

@end

@implementation CreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    IncidentView *test1 = [[IncidentView alloc]initWithFrame:CGRectMake(50,  50, self.view.EA_Width - 40, self.view.EA_Height - self.view.EA_Width * 0.04 - 50)];
    [self.view addSubview:test1];
    
    self.navigationItem.titleView = [Tools getTitleLab:@"创建实况"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
