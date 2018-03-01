//
//  LotteryListCell.h
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseCardCell.h"
#import "LotteryNumberView.h"
//typedef NS_ENUM(NSInteger, ) <#new#>;

@interface LotteryListCell : BaseCardCell
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *phaseLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) LotteryNumberView *numbersView;
//@property(nonatomic, weak) UIImageView *stateBadgeView;

@end
