//
//  BuyLotteryListCell.h
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyLotteryListCell : UITableViewCell
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) YYLabel *titleLabel;
@property(nonatomic, weak) YYLabel *detailLabel;
@property(nonatomic, weak) UIImageView *stateBadgeView;


@property(nonatomic, assign) BOOL allowbuy;

@end
