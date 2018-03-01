//
//  BettingUserInfoHeader.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingUserInfoHeader.h"

@implementation BettingUserInfoHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview];
        [self layout];
        self.balance = @"0";
        self.phase = @"0";
        self.winMoney = @"0";
        self.backgroundColor = OrangeBgColor;
    }
    return self;
}
- (void)addSubview{
    [self leftLabel];
    [self rightLabel];
}
- (void)layout{
    CGFloat margin = NormalMargin;
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.width.equalTo(self).multipliedBy(0.5);
        make.top.bottom.equalTo(self);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-margin);
        make.width.equalTo(self).multipliedBy(0.8);
        make.top.bottom.equalTo(self);
    }];
}




- (void)setBalance:(NSString *)balance{
    _balance = balance;
    
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"余额:"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:balance ? : @""];
    NSMutableAttributedString *part3 = [[NSMutableAttributedString alloc]initWithString:@"元"];
    
    [part1 setYy_color:TextGrayColor];
    [part2 setYy_color:MainColor];
    [part3 setYy_color:TextGrayColor];
    
    [part1 appendAttributedString:part2];
    [part1 appendAttributedString:part3];
    
    [part1 setYy_font:CPFont(13)];
    [part1 setYy_alignment:NSTextAlignmentLeft];
    
    self.leftLabel.attributedText = part1;
}
- (void)setPhase:(NSString *)phase{
    _phase = phase;
    self.rightLabel.attributedText = [self rightAttrStr];
}
- (void)setWinMoney:(NSString *)winMoney{
    _winMoney = winMoney;
    self.rightLabel.attributedText = [self rightAttrStr];
}
- (NSMutableAttributedString *)rightAttrStr{
    
    
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"参与:"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:self.phase ? : @""];
    NSMutableAttributedString *part3 = [[NSMutableAttributedString alloc]initWithString:@"期,赢利:"];
    NSMutableAttributedString *part4 = [[NSMutableAttributedString alloc]initWithString:self.winMoney ? : @""];
    NSMutableAttributedString *part5 = [[NSMutableAttributedString alloc]initWithString:@"元"];
    
    [part1 setYy_color:TextGrayColor];
    [part2 setYy_color:MainColor];
    [part3 setYy_color:TextGrayColor];
    [part4 setYy_color:MainColor];
    [part5 setYy_color:TextGrayColor];
    
    
    [part1 appendAttributedString:part2];
    [part1 appendAttributedString:part3];
    [part1 appendAttributedString:part4];
    [part1 appendAttributedString:part5];
    
    
    
    [part1 setYy_font:CPFont(13)];
    [part1 setYy_alignment:NSTextAlignmentRight];
    return part1;
}















- (YYLabel *)leftLabel{
    if (!_leftLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        
        [self addSubview:label];
        _leftLabel = label;
    }
    return _leftLabel;
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
