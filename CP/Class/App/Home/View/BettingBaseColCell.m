//
//  BettingBaseColCell.m
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingBaseColCell.h"

@implementation BettingBaseColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
    }
    return self;
}
- (void)addSubview{
    [self bgView];
    [self titleLabel];
    [self oddsLabel];
}

- (void)setIsSel:(BOOL)isSel{
    _isSel = isSel;
    
}
//- (void)layoutSubviews{
//    [super layoutSubviews];
//    self.bgView.backgroundColor = self.isSel ?
//    [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
//                          withFrame:self.bgView.bounds
//                          andColors:@[CP16Color(0xC2282F), CP16Color(0xFF5B72)]] :
//    [UIColor clearColor];
//}
- (UIView *)bgView{
    if(!_bgView){
        UIView *bg = [[UIView alloc]init];
        bg.layer.cornerRadius = SRadius;
        bg.layer.borderWidth = 0.5;
        bg.layer.borderColor = MainBorderColor.CGColor;
        bg.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:bg];
        _bgView = bg;
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(16);
        title.textColor = MainColor;
        title.textAlignment = NSTextAlignmentCenter;
        
        
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)oddsLabel{
    if (!_oddsLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(12);
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _oddsLabel = title;
    }
    return _oddsLabel;
}
@end
