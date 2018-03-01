//
//  NumKeyboardView.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NumKeyboardView.h"


@interface NumKeyboardView(){
    
}
@property(nonatomic, strong) NSArray <UIButton *>*btns;
@end

@implementation NumKeyboardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = BgDarkGray;
        [self addKeys];
        self.allowDot = NO;
    }
    return self;
}

- (void)layoutSubviews{
    CGFloat padding = 1;
    CGFloat col = 3;
    CGFloat row = 4;
    
    CGFloat w = (self.width  - padding * (col + 1)) / col;
    CGFloat h = (self.height - padding * (row + 1)) / row;
    
    int i = 0 ;
    for (UIButton *btn in self.btns) {
        btn.frame = CGRectMake((i % 3) * (w + padding) + padding, (i / 3 * (h + padding)) + padding, w, h);
        i++;
    }
}


- (void)setAllowDot:(BOOL)allowDot{
    _allowDot = allowDot;
    
    [self.btns[9] setImage:allowDot ? nil : [[UIImage imageNamed:@"kb_dismiss"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    [self.btns[9] setTitle:allowDot ? @"." : @"" forState:UIControlStateNormal];
}
- (void)addKeys{
    NSArray *keys = @[@"1", @"2", @"3",
                      @"4", @"5", @"6",
                      @"7", @"8", @"9",
                      @".", @"0", @"backspace"];
    NSMutableArray <UIButton *>*btns = [@[] mutableCopy];
    for (int i = 0; i < 12; i++) {
        UIButton *btn = [self btnFactory];
        
        NSString *title = keys[i];
        if([title isEqualToString:@"backspace"]){
            [btn setImage:[[UIImage imageNamed:@"kb_backspace"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
            btn.tag = -1;
        }else if([title isEqualToString:@"."]){
            btn.tag = -2;
        }else{
            btn.tag = [title integerValue];
            [btn setTitle:title forState:UIControlStateNormal];
        }
        [self addSubview:btn];
        [btns addObject:btn];
    }
    self.btns = btns;
}



- (void)btnClick:(UIButton *)btn{
    if(btn.titleLabel.text.length > 0){
        if(self.didInputText)self.didInputText(btn.titleLabel.text);
    }else{
        if(btn.tag == -1){
            if(self.needBackSpace)self.needBackSpace();
        }else if(btn.tag == -2){
            if(self.needDismiss)self.needDismiss(self);
        }
    }
}
- (UIButton *)btnFactory{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:BgDarkGray] forState:UIControlStateHighlighted];
    [btn setTitleColor:TextBlackColor forState:UIControlStateNormal];
    btn.tintColor = TextBlackColor;
    btn.titleLabel.font = CPFont(24);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


@end
