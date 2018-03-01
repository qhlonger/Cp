//
//  SafetyTextFieldView.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SafetyTextFieldView.h"


@interface SafetyTextFieldView()<UITextFieldDelegate>

@end

@implementation SafetyTextFieldView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.values = @"";
        self.numberCount = 6;
        self.borderWidth = 0.8;
        self.backgroundColor = BgDarkGray;
        self.layer.borderWidth = self.borderWidth;
        self.layer.borderColor = BgDarkGray.CGColor;
        self.layer.cornerRadius = SRadius;
        
        [self addSubview];
        
        
    }
    return self;
}
- (void)setValues:(NSString *)values{
    if(values.length == self.numberCount){
        self.isFull = YES;
        if(self.didFull)self.didFull(values);
    }else if(values.length > self.numberCount){
        self.isFull = YES;
        return;
    }else{
        self.isFull = NO;
    }
    
        _values = values;
        if(_values.length > self.numberCount){
            _values = [_values substringWithRange:NSMakeRange(0, self.numberCount)];
        }
        
        int i = 0;
        for (UILabel *label in self.labels) {
            label.textColor = _values.length > i ?  TextBlackColor : [UIColor clearColor];
            i++;
        }

    
}

- (void)addSubview{
//    [self textField];
    [self initLabels];
    
}
- (void)initLabels{
    NSMutableArray *labels = [@[] mutableCopy];
    for (int i = 0; i < self.numberCount; i++) {
        UILabel *label = [self labelFactory];
        [self addSubview:label];
        [labels addObject:label];
    }
    self.labels = labels;
}
- (UILabel *)labelFactory{
    UILabel *label = [[UILabel alloc]init];
    label.text = @"●";
    label.font = CPFont(20);
    label.textColor = [UIColor clearColor];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    label.adjustsFontSizeToFitWidth = YES;
    
    return label;
}

- (void)layoutSubviews{
    
    //正方形
    /*
    CGFloat wh = self.width / self.numberCount;
    if(self.height * self.numberCount > self.width){
        wh = self.width / self.numberCount;
    }else{
        wh = self.height;
    }
    CGFloat tfW = wh*_numberCount + _borderWidth;
    CGFloat tfH = wh;
    CGRect tfRect = CGRectMake(self.width/2 - tfW /2,  self.height/2 - tfH / 2, tfW, tfH);
    
    int i = 0;
    CGFloat w = (CGRectGetWidth(tfRect) - (self.borderWidth * (self.numberCount + 1))) / self.numberCount;
    CGFloat h = CGRectGetHeight(tfRect) - self.borderWidth * 2;
    for (UILabel *label in self.labels) {
        label.frame = CGRectMake(tfRect.origin.x + (self.borderWidth + w) * i + self.borderWidth, tfRect.origin.y + self.borderWidth, w, h);
        i++;
    }
    */
    
    CGFloat w = (self.width - self.borderWidth * (self.numberCount + 1)) / self.numberCount;
    CGFloat h = self.height - self.borderWidth * 2;
    int i = 0;
    
    for (UILabel *label in self.labels) {
        label.frame = CGRectMake((self.borderWidth + w) * i + self.borderWidth, self.borderWidth, w, h);
        i++;
    }
    
    
}






@end
