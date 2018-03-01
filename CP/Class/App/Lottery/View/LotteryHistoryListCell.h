//
//  LotteryHistoryListCell.h
//  CP
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseCardCell.h"
#import "LotteryNumberView.h"

@interface LotteryHistoryListCell : BaseCardCell

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *phaseLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) LotteryNumberView *numbersView;
@end
