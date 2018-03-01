//
//  AppHelper.m
//  CP
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper



+ (instancetype)helper{
    static AppHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[AppHelper alloc]init];
    });
    return helper;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.screenType = CPScreenSize47;
        if(CGRectGetWidth([UIScreen mainScreen].bounds) == 320){
            self.screenType = CPScreenSize40;
        }else if(CGRectGetWidth([UIScreen mainScreen].bounds) == 375){
            self.screenType = CPScreenSize47;
        }else if(CGRectGetWidth([UIScreen mainScreen].bounds) == 540){
            self.screenType = CPScreenSize40;
        }else if(CGRectGetWidth([UIScreen mainScreen].bounds) == 564){
            self.screenType = CPScreenSize58;
        }
    }
    return self;
}

- (UIWindow *)alertWindow{
    if(!_alertWindow){
        _alertWindow = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _alertWindow.backgroundColor = [UIColor clearColor];
    }
    return _alertWindow;
}
- (NSArray<LotteryModel *> *)lotteryModels{
    if (!_lotteryModels) {
        
        
        
        NSArray *allLtty = @[
                             @{@"lottery_id":@1,
                               @"img":@"icon_bjsc",
                               @"title":@"北京赛车PK拾",
                               @"detail":@"每天179期，每5分钟开奖",
                               @"range_start":@2,
                               @"range_length":@3,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@2,
                               @"img":@"icon_cqssc",
                               @"title":@"重庆时时彩",
                               @"detail":@"全天120期，白天每10分钟开奖，夜间每5分钟开奖",
                               @"range_start":@2,
                               @"range_length":@3,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@3,
                               @"img":@"icon_xyft",
                               @"title":@"幸运飞艇",
                               @"detail":@"每天180期，每5分钟开奖",
                               @"range_start":@2,
                               @"range_length":@3,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@4,
                               @"img":@"icon_xync",
                               @"title":@"重庆幸运农场",
                               @"detail":@"每天97期，每10分钟开奖",
                               @"range_start":@2,
                               @"range_length":@2,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@5,
                               @"img":@"icon_bjklb",
                               @"title":@"北京快乐8",
                               @"detail":@"每天84期，每10分钟开奖",
                               @"range_start":@2,
                               @"range_length":@2,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@6,
                               @"img":@"icon_gdyyxw",
                               @"title":@"广东11选5",
                               @"detail":@"每天179期，每5分钟开奖",
                               @"range_start":@2,
                               @"range_length":@3,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@7,
                               @"img":@"icon_gdks",
                               @"title":@"广东快乐10分",
                               @"detail":@"全天84期，每10分钟开奖",
                               @"range_start":@2,
                               @"range_length":@2,
                               @"pstatus":@"1"
                               },
                             @{@"lottery_id":@8,
                               @"img":@"icon_jsks",
                               @"title":@"江苏快3",
                               @"detail":@"全天82期，每10分钟开奖",
                               @"range_start":@2,
                               @"range_length":@2,
                               @"pstatus":@"1"
                               },
                             ];
        _lotteryModels = [LotteryModel mj_objectArrayWithKeyValuesArray:allLtty];
    }
    return _lotteryModels;
}








@end
