//
//  BettingBallColCell.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BettingBaseColCell.h"

@interface BettingBallColCell : BettingBaseColCell
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *oddsLabel;
@property(nonatomic, assign) BOOL isSel;
@end
