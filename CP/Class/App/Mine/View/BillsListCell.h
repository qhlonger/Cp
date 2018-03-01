//
//  BillsListCell.h
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillsListCell : UITableViewCell

@property(nonatomic, weak) UIView *line;
@property(nonatomic, weak) UIView *dot;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) UILabel *moneyLabel;
@property(nonatomic, weak) UILabel *balanceLabel;


@end
