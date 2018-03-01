//
//  Utility.h
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LotteryModel.h"


typedef NS_ENUM(NSInteger, LotteryType) {
    LotteryTypePK10 = 1,
    LotteryTypeCQSSC = 2,
    LotteryTypeXYFT = 3,
    LotteryTypeXYNC = 4,
    LotteryTypeBJKL8 = 5,
    LotteryTypeGD11X5 = 6,
    LotteryTypeKl10F = 7,
    LotteryTypeJSK3 = 8
};

@class INSDefaultInfiniteIndicator, INSDefaultPullToRefresh;

@interface Utility : NSObject


+ (BOOL)isIphoneX;
+ (BOOL)isIphone40orLow;
+ (BOOL)isIphone47;
+ (BOOL)isIphone55;



+ (void)showStatus:(NSString *)status;
+ (void)showSuccess:(NSString *)status;
+ (void)showError:(NSString *)status;
+ (void)showProgress:(CGFloat)progress;
+ (void)showHUD;
+ (void)dismissHUD;



//数字逗号分隔

+ (NSString *)countNumAndChangeformat:(NSString *)num;


+ (CGFloat)getRatioWithMax:(CGFloat)max min:(CGFloat)min mid:(CGFloat)mid;
+ (CGFloat)getMidWithMax:(CGFloat)max min:(CGFloat)min ratio:(CGFloat)ratio;
+ (CGRect)getRectWithMaxRect:(CGRect)maxRect minRect:(CGRect)minRect Ratio:(CGFloat)ratio;
+ (CGRect)frame:(CGRect)frame byInsets:(UIEdgeInsets)insets;

+ (UIViewController *)getCurrentVC;


+ (UIButton *)submitBtn;

+ (UITextField *)normalTextField;



+ (BOOL)isString:(NSString *)string validate:(NSString *)pattern;
+ (NSArray <NSString *>*)getSubstringFromString:(NSString *)string validate:(NSString *)pattern;


+ (UIFont *)equalWidthFontWithSize:(NSInteger)size;




+ (INSDefaultInfiniteIndicator *)defultFooter;

+ (INSDefaultPullToRefresh *)defultHeader;

+ (NSURL *)getImgUrl:(NSString *)urlStr;


+ (LotteryModel *)getLotteryByID:(NSString *)aID;

+ (CGFloat)ptOn40:(CGFloat)pt;
+ (CGFloat)ptOn47:(CGFloat)pt;
+ (CGFloat)ptOn55:(CGFloat)pt;
+ (CGFloat)ptOn58:(CGFloat)pt;



+ (void)showToLoginAlertWith:(UIViewController *)vc callback:(void(^)(BOOL success))callback;
+ (void)toLoginVC;

+ (void)toWechat;
+ (void)toWechatScan;
+ (void)toWechatAddFriends;

+ (void)callWithPhoneNumber:(NSString *)number;
@end
