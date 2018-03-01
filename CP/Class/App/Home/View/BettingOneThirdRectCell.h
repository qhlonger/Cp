//
//  BettingOneThirdRectCell.h
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BettingBaseColCell.h"


@interface BettingOneThirdRectCell : BettingBaseColCell
@property(nonatomic, weak) UIView *bgView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *oddsLabel;
@property(nonatomic, assign) BOOL isSel;

@end
