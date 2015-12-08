//
//  EABaseTableViewController.m
//  EasyApp
//
//  Created by liudonghuan on 15/8/9.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import "EABaseTableViewController.h"
#import "EABaseTableViewCell.h"

@implementation EABaseTableViewController

- (instancetype)init{
    if(self = [super init]){
        _cards = [[NSMutableArray alloc]initWithCapacity:0];
        self.tableView = [[UITableView alloc]initWithFrame:EAFrame];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    EACard *card = [_cards objectAtIndex:indexPath.row];
    return [[[[card class] CardViewClass] class] heightOfCard:card];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    EACard *card = [_cards objectAtIndex:indexPath.row];
    NSString *cardReuseIdentifier = [card description];
    EABaseTableViewCell *cell = [[EABaseTableViewCell alloc]initWithCard:card Style:UITableViewCellStyleDefault reuseIdentifier:cardReuseIdentifier];
    return cell;
}

- (void)dealloc{

}

@end
