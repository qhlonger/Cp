//
//  BettingFooter.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingFooter.h"

@implementation BettingFooter


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview];
        [self layout];
        self.count = @"0";
        self.total = @"0";
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)addSubview{
    [self line];
    [self stateLabel];
    [self moneyTf];
    [self resetBtn];
    [self buyBtn];
    
}
- (void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    CGFloat margin = NormalMargin;
    [self.buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-margin);
        make.top.equalTo(self).offset(margin);
        make.bottom.equalTo(self).offset(-margin);
        make.width.mas_equalTo(PtOn47(60));
    }];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.buyBtn.mas_left).offset(-margin);
        make.top.equalTo(self).offset(margin);
        make.bottom.equalTo(self).offset(-margin);
        make.width.mas_equalTo(PtOn47(60));
    }];
    [self.moneyTf mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.resetBtn.mas_left).offset(-margin);
        make.top.equalTo(self).offset(margin);
        make.bottom.equalTo(self).offset(-margin);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(PtOn47(80));
//        make.height.mas_equalTo(24);
    }];
    [self. stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(margin);
        make.right.equalTo(self.moneyTf.mas_left).offset(-margin);
        make.top.bottom.equalTo(self);
    }];
}
- (UIView *)line{
    if (!_line) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = SepColor;
        [self addSubview:line];
        _line = line;
    }
    return _line;
}
- (YYLabel *)stateLabel{
    if (!_stateLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        label.preferredMaxLayoutWidth =  CGRectGetWidth([UIScreen mainScreen].bounds) - PtOn47(10)*5 - PtOn47(60) * 2 - PtOn47(80);
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:label];
        _stateLabel = label;
    }
    return _stateLabel;
}
- (UITextField *)moneyTf{
    if (!_moneyTf) {
        UITextField *tf = [[UITextField alloc]init];
        tf.font = CPFont(12);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = SepColor.CGColor;
        tf.layer.borderWidth = 0.5;
        tf.layer.cornerRadius = 2;
        tf.clipsToBounds = YES;
        tf.placeholder = @"每注金额";
        tf.tintColor = MainColor;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 0)];
        tf.rightViewMode = UITextFieldViewModeAlways;
        [self addSubview:tf];
        _moneyTf = tf;
    }
    return _moneyTf;
}
- (UIButton *)resetBtn{
    if (!_resetBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 2;
        btn.clipsToBounds = YES;
        
        
        [btn setBackgroundImage:[UIImage imageWithColor:CP16Color(0xF3AB3C)] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:CP16Color(0xE39B2C)] forState:UIControlStateHighlighted];
        [btn setTitle:@"重置" forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn.titleLabel.font = CPFont(15);
        [self addSubview:btn];
        _resetBtn = btn;
    }
    return _resetBtn;
}
- (UIButton *)buyBtn{
    if (!_buyBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 2;
        btn.clipsToBounds = YES;
        
        [btn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:DarkMainColor] forState:UIControlStateHighlighted];
        [btn setTitle:@"投注" forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        btn.titleLabel.font = CPFont(15);
        [self addSubview:btn];
        _buyBtn = btn;
    }
    return _buyBtn;
}
- (void)setCount:(NSString *)count{
    _count = count;
    self.stateLabel.attributedText = [self attrStateStr];
}
- (void)setTotal:(NSString *)total{
    _total = total;
    self.stateLabel.attributedText = [self attrStateStr];
}
- (NSMutableAttributedString *)attrStateStr{
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"已选"];
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:self.count ? : @""];
    NSMutableAttributedString *part3 = [[NSMutableAttributedString alloc]initWithString:@"注,共"];
    NSMutableAttributedString *part4 = [[NSMutableAttributedString alloc]initWithString:self.total ? : @""];
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
    
    [part1 setYy_font:CPFont(12)];
    [part1 setYy_alignment:NSTextAlignmentLeft];
    return part1;
}








@end
