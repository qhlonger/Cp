//
//  BettingHistoryCell.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingHistoryCellBgView : UIView
@property(nonatomic, weak) CAShapeLayer *shapeLayer;
@property(nonatomic, strong) UIColor *bgColor;
@end


@interface BettingHistoryCell : UITableViewCell


@property(nonatomic, weak) BettingHistoryCellBgView *bgView;

@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *phaseLabel;


@property(nonatomic, weak) UILabel *moneyLabel;


@property(nonatomic, weak) UILabel *betNumberLabel;

@property(nonatomic, weak) UILabel *betMoneyLabel;
@property(nonatomic, weak) UILabel *betOddsLabel;
@property(nonatomic, weak) UILabel *betTimeLabel;


@property(nonatomic, weak) UILabel *betMoneyContentLabel;
@property(nonatomic, weak) UILabel *betOddsContentLabel;
@property(nonatomic, weak) UILabel *betTimeContentLabel;

@end
