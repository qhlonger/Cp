//
//  LotteryNumberView.m
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#define LotteryNumberViewNeedFill 0

#import "LotteryNumberView.h"


@implementation LotteryNumberModel
+ (instancetype)modelWithText:(NSString *)text color:(UIColor *)color haveBoarder:(BOOL)haveBoarder{
    LotteryNumberModel *model = [[LotteryNumberModel alloc]init];
    model.text = text;
    model.color = color;
    model.haveBoarder = haveBoarder;
    
    
    return model;
}


@end



@implementation LotteryNumberView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    NSMutableArray *labels = [@[] mutableCopy];
    for (int i = 0; i < 20; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.adjustsFontSizeToFitWidth = YES;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        
        label.font = CPFont(14);
        label.layer.borderWidth = 0.5;
        label.clipsToBounds = YES;
        
        label.hidden = YES;
        [self addSubview:label];
        [labels addObject:label];
    }
    self.labels = labels;
}
- (void)setLine1Models:(NSArray<LotteryNumberModel *> *)line1Models{
    _line1Models = line1Models;
    int i = 0;
    
    
    for (UILabel *label in self.labels) {
        if(i > 10){
            return;
        }
        
        if(i < line1Models.count){
            LotteryNumberModel *numberModel = line1Models[i];
            
            
            
            label.backgroundColor =  numberModel.haveBoarder ? (LotteryNumberViewNeedFill ? numberModel.color : [UIColor clearColor]) : [UIColor clearColor];
            label.textColor =  numberModel.haveBoarder ? (LotteryNumberViewNeedFill ? [UIColor whiteColor] : numberModel.color) : numberModel.color;
            
            label.layer.borderColor = numberModel.haveBoarder ? numberModel.color.CGColor : [UIColor clearColor].CGColor;
            label.text = numberModel.text;
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
        
        i++;
    }
    
    
}
- (void)setLine2Models:(NSArray<LotteryNumberModel *> *)line2Models{
    _line2Models = line2Models;
    int i = 0;
    
    for (UILabel *label in self.labels) {
        if(i < 10){
            i++;
            continue;
        }
        if(i-10 < line2Models.count){
            
            LotteryNumberModel *numberModel = line2Models[i-10];
            
            
            
            label.backgroundColor =  numberModel.haveBoarder ? (LotteryNumberViewNeedFill ? numberModel.color : [UIColor clearColor]) : [UIColor clearColor];
            
            label.textColor =  numberModel.haveBoarder ? (LotteryNumberViewNeedFill ? [UIColor whiteColor] : numberModel.color) : numberModel.color;
            label.layer.borderColor = numberModel.haveBoarder ? numberModel.color.CGColor : [UIColor clearColor].CGColor;
            label.text = line2Models[i-10].text;
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
        
        
        
        
        i++;
    }
    
    
}
- (void)layoutSubviews{
    int i = 0;
    
    CGFloat maxHp = 10;
    CGFloat minHp = 1;
    
    CGFloat hp = [Utility getMidWithMax:maxHp min:minHp ratio:self.hor_padding];
    
    CGFloat labelWH = MIN((self.height - self.ver_padding)/2, (self.width - hp*9)  / 10);
//    NSLog(@"%f  \n  %f  \n  %f",self.width,self.height, labelWH);
    
//    CGFloat maxHp = (self.width - labelWH * 10)/9;
//    CGFloat minHp = 1;
    

    
    
        for (UILabel *label in self.labels) {
            label.frame = CGRectMake(labelWH * (i % 10) + (i % 10) * hp, i / 10 ? self.height - labelWH : 0, labelWH, labelWH);
            label.layer.cornerRadius = label.width / 2;
            
            i++;
        }
    
}



//- (void)setLotteryType:(LotteryType)lotteryType{
//    _lotteryType = lotteryType;
//    NSLog(@"%d",lotteryType);
//}



- (void)setLine1Codes:(NSArray<NSString *> *)line1Codes{
    _line1Codes = line1Codes;
    
    
   
    for (int i = 0; i < self.labels.count/2; i++) {
        UILabel *label = self.labels[i];
        if(i < line1Codes.count){
            label.text = line1Codes[i];
            label.textColor = [self getBlueOrRedColor:line1Codes[i]];
            label.layer.borderColor = [self getBlueOrRedColor:line1Codes[i]].CGColor;
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
    }
}
- (void)setLine2Codes:(NSArray<NSString *> *)line2Codes{
    _line2Codes = line2Codes;
    
    for (int i = 0; i < self.labels.count/2; i++) {
        UILabel *label = self.labels[i+10];
        if(i < line2Codes.count){
            NSString *code = line2Codes[i];
            
            label.text = code;
            if([code isEqualToString:@"虎"] ||
               [code isEqualToString:@"小"] ||
               [code isEqualToString:@"单"]){
                label.textColor = GrayBallColor;
            }else{
                label.textColor = RedBallColor;
            }
            
            
            label.layer.borderColor = [UIColor clearColor].CGColor;
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
    }
}


- (void)setOriginCode:(NSString *)originCode{
    _originCode = originCode;
    self.originCodeArray = [originCode componentsSeparatedByString:@","];
}
- (void)setOriginCodeArray:(NSArray<NSString *> *)originCodeArray{
    _originCodeArray = originCodeArray;
    [self buildResultArray];
    
}
- (void)buildResultArray{
    
    switch (self.lotteryType) {
        case LotteryTypePK10:{
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
            }
            self.line1Models = line1;
            
            NSMutableArray *line2 = [@[] mutableCopy];
            NSInteger sum = [self.originCodeArray[0] integerValue] + [self.originCodeArray[1] integerValue];
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum > 11 ? @"大" : @"小" color:sum > 11 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            
            if(self.originCodeArray.count)
                [line2 addObjectsFromArray:[self getDragonOrTigerOfArray:self.originCodeArray]];
            self.line2Models = line2;
        }break;
        case LotteryTypeCQSSC:{//时时彩
            
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
            }
            self.line1Models = line1;
            
            
            
            NSMutableArray *line2 = [@[] mutableCopy];
            NSInteger sum = [self getSum:self.originCodeArray];
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            if(sum > 30){
                [line2 addObject:[LotteryNumberModel modelWithText:@"大" color:GrayBallColor haveBoarder:NO]];
            }else if(sum < 30){
                [line2 addObject:[LotteryNumberModel modelWithText:@"小" color:GrayBallColor haveBoarder:NO]];
            }else{
                [line2 addObject:[LotteryNumberModel modelWithText:@"和" color:GrayBallColor haveBoarder:NO]];
            }
            if(self.originCodeArray.count)
                [line2 addObject:[self getDragonOrTigerOfArray:self.originCodeArray].firstObject];
            
            [line2 addObjectsFromArray:[self getStraightArrayFrom5Numbers:self.originCodeArray]];
            
            self.line2Models = line2;
            
        }break;
        case LotteryTypeXYFT:{//幸运飞艇
            
            NSMutableArray *lin1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [lin1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
            }
            self.line1Models = lin1;
            
            NSMutableArray *line2 = [@[] mutableCopy];
            NSInteger sum = [self.originCodeArray[0] integerValue] + [self.originCodeArray[1] integerValue];
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum > 11 ? @"大" : @"小" color:sum > 11 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            
            if(self.originCodeArray.count)
                [line2 addObjectsFromArray:[self getDragonOrTigerOfArray:self.originCodeArray]];
            self.line2Models = line2;
            
        }break;
        case LotteryTypeXYNC:{//幸运农场
            
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];\
            }
            self.line1Models = line1;
            
            
            NSMutableArray *line2 = [@[] mutableCopy];
            
            NSInteger sum = [self getSum:self.originCodeArray];
            
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            if(sum > 84){
                [line2 addObject:[LotteryNumberModel modelWithText:@"大" color:GrayBallColor haveBoarder:NO]];
            }else if(sum < 84){
                [line2 addObject:[LotteryNumberModel modelWithText:@"小" color:GrayBallColor haveBoarder:NO]];
            }else{
                [line2 addObject:[LotteryNumberModel modelWithText:@"和" color:GrayBallColor haveBoarder:NO]];
            }
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 10 >= 5 ? @"尾大" : @"尾小" color:sum % 10 >= 5 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            
            if(self.originCodeArray.count)
                [line2 addObjectsFromArray:[self getDragonOrTigerOfArray:self.originCodeArray]];
            self.line2Models = line2;
            
        }break;
        case LotteryTypeBJKL8:{//北京快乐8
            
            int i = 0;
            NSMutableArray *line1 = [@[] mutableCopy];
            NSMutableArray *line2 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                if(i < self.originCodeArray.count / 2){
                    [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
                }else{
                    [line2 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
                }
                i++;
            }
            self.line1Models = line1;
            self.line2Models = line2;
        }break;
        case LotteryTypeGD11X5:{//广东11选5
            
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
            }
            self.line1Models = line1;
            
            
            
            NSMutableArray *line2 = [@[] mutableCopy];
            NSInteger sum = [self getSum:self.originCodeArray];
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            if(sum > 30){
                [line2 addObject:[LotteryNumberModel modelWithText:@"大" color:GrayBallColor haveBoarder:NO]];
            }else if(sum < 30){
                [line2 addObject:[LotteryNumberModel modelWithText:@"小" color:GrayBallColor haveBoarder:NO]];
            }else{
                [line2 addObject:[LotteryNumberModel modelWithText:@"和" color:GrayBallColor haveBoarder:NO]];
            }
            if(self.originCodeArray.count)
                [line2 addObject:[self getDragonOrTigerOfArray:self.originCodeArray].firstObject];
            
            
            
            self.line2Models = line2;
        }break;
        case LotteryTypeKl10F:{//广东快乐10分
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];\
            }
            self.line1Models = line1;
            
            
            NSMutableArray *line2 = [@[] mutableCopy];
            
            NSInteger sum = [self getSum:self.originCodeArray];
            
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 2 ? @"单" : @"双" color:sum % 2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            if(sum > 84){
                [line2 addObject:[LotteryNumberModel modelWithText:@"大" color:GrayBallColor haveBoarder:NO]];
            }else if(sum < 84){
                [line2 addObject:[LotteryNumberModel modelWithText:@"小" color:GrayBallColor haveBoarder:NO]];
            }else{
                [line2 addObject:[LotteryNumberModel modelWithText:@"和" color:GrayBallColor haveBoarder:NO]];
            }
            [line2 addObject:[LotteryNumberModel modelWithText:sum % 10 >= 5 ? @"尾大" : @"尾小" color:sum % 10 >= 5 ? RedBallColor : GrayBallColor haveBoarder:NO]];
            
            if(self.originCodeArray.count)
                [line2 addObjectsFromArray:[self getDragonOrTigerOfArray:self.originCodeArray]];
            self.line2Models = line2;
        }break;
        case LotteryTypeJSK3:{
            NSMutableArray *line1 = [@[] mutableCopy];
            for (NSString *code in self.originCodeArray) {
                [line1 addObject:[LotteryNumberModel modelWithText:code color:[self getBlueOrRedColor:code] haveBoarder:YES]];
            }
            self.line1Models = line1;
            
            
            
            NSMutableArray *line2 = [@[] mutableCopy];
            NSInteger sum = [self getSum:self.originCodeArray];
            [line2 addObject:[LotteryNumberModel modelWithText:[NSString stringWithFormat:@"%ld",sum] color:GrayBallColor haveBoarder:NO]];
            
            if(sum > 10){
                [line2 addObject:[LotteryNumberModel modelWithText:@"大" color:GrayBallColor haveBoarder:NO]];
            }else{
                [line2 addObject:[LotteryNumberModel modelWithText:@"小" color:GrayBallColor haveBoarder:NO]];
            }
            
            
            self.line2Models = line2;
        }break;
            
        default:
            break;
    }
    
}



- (NSArray <LotteryNumberModel *>*)getDragonOrTigerOfArray:(NSArray <NSString *>*)array{
    NSMutableArray *dt = [@[] mutableCopy];
    for (int i = 0; i < self.originCodeArray.count / 2; i ++) {
        NSInteger code1 = [self.originCodeArray[i] integerValue];
        NSInteger code2 = [self.originCodeArray[self.originCodeArray.count - i - 1] integerValue];
        [dt addObject:[LotteryNumberModel modelWithText:code1 > code2 ? @"龙" : @"虎" color:code1 > code2 ? RedBallColor : GrayBallColor haveBoarder:NO]];
    }
    return dt;
}
- (NSInteger)getSum:(NSArray <NSString *>*)array{
    NSInteger sum = 0;
    for (NSString *code in array) {
        sum += [code integerValue];
    }
    return sum;
}
- (UIColor *)getBlueOrRedColor:(NSString *)code{
    return [code integerValue] % 2 ? BlueBallColor : RedBallColor;
}
- (UIColor *)getPK10Color:(NSString *)pkCode{
    NSArray *colors = @[CPRGB(248, 231, 28),
                        CPRGB(54, 137, 247),
                        CPRGB(77, 77, 77),
                        CPRGB(239, 123, 48),
                        CPRGB(54, 252, 254),
                        CPRGB(71, 30, 245),
                        CPRGB(227, 227, 227),
                        CPRGB(235, 51, 35),
                        CPRGB(108, 18, 10),
                        CPRGB(95, 190, 56)];
    return colors[[pkCode integerValue]-1];
}

- (NSString *)getStraightStringFromNumbers:(NSArray <NSString *>*)numbers{
    if (numbers.count != 3) {
        return @"--";
    }
    NSArray <NSString *>*number = [numbers sortedArrayUsingComparator:^NSComparisonResult(NSString    * _Nonnull obj1, NSString   * _Nonnull obj2) {
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return NSOrderedDescending;
        }
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    NSString *temp = 0;
    
    int scount = 0;
    int bcount = 0;
    
    
    int i = 0;
    for (NSString *code in number) {
        if(i > 0){
            if([temp integerValue] + 1 == [code integerValue] || [temp integerValue] + 1 == [code integerValue] + 10){
                scount ++;
            }
            if([temp integerValue] == [code integerValue]){
                bcount ++;
            }
            
        }
        temp = code;
        i++;
    }
    if(bcount == numbers.count - 1){
        return @"豹";
    }else if(bcount == 0){
        if(scount == numbers.count - 1){
            return @"顺";
        }else if(scount == 0){
            return @"杂";
        }else{
            return @"半";
        }
    }else{
        return @"对";
    }
}

- (NSArray <LotteryNumberModel *>*)getStraightArrayFrom5Numbers:(NSArray <NSString *>*)numbers{
    if(numbers.count != 5)return nil;
    
    return @[
             [LotteryNumberModel modelWithText:[self getStraightStringFromNumbers:[numbers subarrayWithRange:NSMakeRange(0, 3)]] color:GrayBallColor haveBoarder:NO],
             [LotteryNumberModel modelWithText:[self getStraightStringFromNumbers:[numbers subarrayWithRange:NSMakeRange(1, 3)]] color:GrayBallColor haveBoarder:NO],
             [LotteryNumberModel modelWithText:[self getStraightStringFromNumbers:[numbers subarrayWithRange:NSMakeRange(2, 3)]] color:GrayBallColor haveBoarder:NO]
             ];
    
}



@end
