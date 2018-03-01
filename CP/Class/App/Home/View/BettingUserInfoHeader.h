//
//  BettingUserInfoHeader.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingUserInfoHeader : UIView
@property(nonatomic, weak) YYLabel *leftLabel;
@property(nonatomic, weak) YYLabel *rightLabel;


@property(nonatomic, copy) NSString *balance;
@property(nonatomic, copy) NSString *phase;
@property(nonatomic, copy) NSString *winMoney;
@end
