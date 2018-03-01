//
//  BettingLotteryInfoHeader.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingLotteryInfoHeader : UIView

@property(nonatomic, weak) YYLabel *leftLabel;
@property(nonatomic, weak) YYLabel *midLabel;
@property(nonatomic, weak) YYLabel *rightLabel;


@property(nonatomic, copy) NSString *phase;
@property(nonatomic, copy) NSString *state;
@property(nonatomic, copy) NSString *countdown;

@end
