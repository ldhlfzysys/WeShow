//
//  EABaseTableViewCell.h
//  EasyApp
//
//  Created by liudonghuan on 15/8/15.
//  Copyright (c) 2015年 ldh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EABaseCardView.h"
#import "EACard.h"

@interface EABaseTableViewCell : UITableViewCell

@property (nonatomic, retain) EABaseCardView *cardView;

- (instancetype)initWithCard:(EACard*)card Style:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
