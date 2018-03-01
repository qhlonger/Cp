//
//  LotteryNumberView.h
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LotteryNumberModel : NSObject

@property(nonatomic, copy) NSString *text;
@property(nonatomic, copy) UIColor *color;
@property(nonatomic, assign) BOOL haveBoarder;


+ (instancetype)modelWithText:(NSString *)text color:(UIColor *)color haveBoarder:(BOOL)haveBoarder;

@end

@interface LotteryNumberView : UIView

@property(nonatomic, strong) NSArray <LotteryNumberModel *>*line1Models;
@property(nonatomic, strong) NSArray <LotteryNumberModel *>*line2Models;
//0-1
@property(nonatomic, assign)  CGFloat hor_padding;
//0-self.height
@property(nonatomic, assign)  CGFloat ver_padding;

@property(nonatomic, strong) NSArray <UILabel *>*labels;

@property(nonatomic, assign) LotteryType lotteryType;
@property(nonatomic, copy) NSString *originCode;
//使用开奖号
@property(nonatomic, strong) NSArray <NSString *>*originCodeArray;


//直接使用
@property(nonatomic, strong) NSArray <NSString *>*line2Codes;
@property(nonatomic, strong) NSArray <NSString *>*line1Codes;
@end
