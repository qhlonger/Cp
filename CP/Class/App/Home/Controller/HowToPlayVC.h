//
//  HowToPlayVC.h
//  CP
//
//  Created by Apple on 2018/1/27.
//  Copyright © 2018年 Apple. All rights reserved.
//
//玩法介绍页面
#import "BaseVC.h"


@interface HowToPlayModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *info;
@property(nonatomic, strong) NSArray <NSString *>*ruleContents;
@property(nonatomic, strong) NSArray <NSDictionary *>*playContents;

@end

@interface HowToPlayVC : BaseVC

@property(nonatomic, assign) LotteryType type;


@end
