//
//  BettingLotteryInfoHeader.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingLotteryInfoHeader.h"

@implementation BettingLotteryInfoHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview];
        [self layout];
        self.phase = @"0";
        self.state = @"00:00";
        self.countdown = @"00:00";
        self.backgroundColor = MainBgGray;
    }
    return self;
}
- (void)addSubview{
    [self leftLabel];
    [self rightLabel];
}
- (void)layout{
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.width.equalTo(self).multipliedBy(0.33);
        make.top.bottom.equalTo(self);
    }];
    [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(self).multipliedBy(0.33);
        make.top.bottom.equalTo(self);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(0);
        make.width.equalTo(self).multipliedBy(0.33);
        make.top.bottom.equalTo(self);
    }];
}



- (void)setPhase:(NSString *)phase{
    _phase = phase;
    
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"第"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@" ,phase ? : @""]];
    NSMutableAttributedString *part3 = [[NSMutableAttributedString alloc]initWithString:@"期"];
    
    [part1 setYy_color:TextGrayColor];
    [part2 setYy_color:MainColor];
    [part3 setYy_color:TextGrayColor];
    
    
    [part1 appendAttributedString:part2];
    [part1 appendAttributedString:part3];
    
    [part1 setYy_font:CPFont(11)];
    [part1 setYy_alignment:NSTextAlignmentCenter];
    
    self.leftLabel.attributedText = part1;
}
- (void)setState:(NSString *)state{
    _state = state;
    
    
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"距离封盘:"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",state ? : @""]];
    
//    if(state){
//        [part2 setYy_backgroundColor:MainColor];
//    }
    
    YYTextBorder *bd = [YYTextBorder borderWithFillColor:MainColor cornerRadius:2];
    bd.insets = UIEdgeInsetsMake(0, 0, -1, 0);
    [part2 setYy_textBackgroundBorder:bd];
    
    [part1 setYy_color:TextGrayColor];
    [part1 setYy_font:CPFont(11)];
    
    
    [part2 setYy_font:CPFont(11)];
    [part2 setYy_color:[UIColor whiteColor]];
    
    
    
    [part1 appendAttributedString:part2];
    
    [part1 setYy_alignment:NSTextAlignmentCenter];
    
    self.midLabel.attributedText = part1;
}
- (void)setCountdown:(NSString *)countdown{
    _countdown = countdown;
    
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"距离开奖:"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",countdown ? : @""]];
    
    YYTextBorder *bd = [YYTextBorder borderWithFillColor:MainColor cornerRadius:2];
    bd.insets = UIEdgeInsetsMake(0, 0, -1, 0);
    [part2 setYy_textBackgroundBorder:bd];
    
    [part1 setYy_color:TextGrayColor];
    [part1 setYy_font:CPFont(11)];
    
    [part2 setYy_font:CPFont(11)];
    [part2 setYy_color:[UIColor whiteColor]];
    
    [part1 appendAttributedString:part2];
    
    
    [part1 setYy_alignment:NSTextAlignmentCenter];
    
    self.rightLabel.attributedText = part1;
}





- (YYLabel *)leftLabel{
    if (!_leftLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        
        [self addSubview:label];
        _leftLabel = label;
    }
    return _leftLabel;
}
- (YYLabel *)midLabel{
    if (!_midLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        
        [self addSubview:label];
        _midLabel = label;
    }
    return _midLabel;
}
- (YYLabel *)rightLabel{
    if (!_rightLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        
        [self addSubview:label];
        _rightLabel = label;
    }
    return _rightLabel;
}



@end
