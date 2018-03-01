//
//  BettingFooter.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingFooter : UIView

@property(nonatomic, weak) UIButton *resetBtn;
@property(nonatomic, weak) UIButton *buyBtn;
@property(nonatomic, weak) YYLabel *stateLabel;
@property(nonatomic, weak) UITextField *moneyTf;
@property(nonatomic, weak) UIView *line;


@property(nonatomic, copy) NSString *count;
@property(nonatomic, strong) NSString *total;
@end
