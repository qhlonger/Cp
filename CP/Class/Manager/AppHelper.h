//
//  AppHelper.h
//  CP
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LotteryModel.h"


typedef NS_ENUM(NSInteger, CPScreenSize) {
    CPScreenSize40,
    CPScreenSize47,
    CPScreenSize55,
    CPScreenSize58
};
@interface AppHelper : NSObject
//原本用于覆盖状态栏的弹窗  因与WSHUD冲突，暂时未使用
@property(nonatomic, strong) UIWindow *alertWindow;

+ (instancetype)helper;

@property(nonatomic, assign) CPScreenSize screenType;

@property(nonatomic, strong) NSArray <LotteryModel *> *lotteryModels;



@end
