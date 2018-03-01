//
//  BettingDragonTigerBallColCell.m
//  CP
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingDragonTigerBallColCell.h"

@implementation BettingDragonTigerBallColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
        [self layout];
        self.isDragonSel = self.isTigerSel = NO;
    }
    return self;
}



- (void)addSubview{
    [self bgView];
    [self titleLabel];
    [self dragonLabel];
    [self tigerLabel];
    [self tigerOddsLabel];
    [self dragonOddsLabel];
    
}
- (void)layout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.dragonLabel.mas_top);
//        make.height.mas_equalTo(PtOn47(30));
    }];
    
    [self.dragonOddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
//        make.height.mas_equalTo(PtOn47(30));
        make.top.equalTo(self.dragonLabel.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    [self.tigerOddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.equalTo(self.contentView).multipliedBy(0.5);
//        make.height.mas_equalTo(PtOn47(30));
        make.top.equalTo(self.dragonLabel.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.dragonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(PtOn47(40));
        make.right.equalTo(self.dragonOddsLabel).offset(-PtOn47(7.5));
    }];
    [self.tigerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.width.height.mas_equalTo(PtOn47(40));
        make.left.equalTo(self.tigerOddsLabel).offset(PtOn47(7.5));
    }];
    [self.verLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(0.5);
    }];
    [self.horLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.verLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.width.mas_equalTo(0.5);
        make.top.bottom.equalTo(self.contentView);
    }];
    [self.horLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
}




- (void)setIsTigerSel:(BOOL)isTigerSel{
    _isTigerSel = isTigerSel;
    
    self.tigerLabel.layer.borderWidth = isTigerSel ? 0 : 1;
    self.tigerLabel.textColor = isTigerSel ? [UIColor whiteColor] : MainColor;
    self.tigerLabel.backgroundColor = isTigerSel ?
    [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
                          withFrame:self.tigerLabel.bounds
                          andColors:@[CP16Color(0xC2282F), CP16Color(0xFF5B72)]] :
    [UIColor clearColor];
    
}
- (void)setIsDragonSel:(BOOL)isDragonSel{
    _isDragonSel = isDragonSel;
    
    
    self.dragonLabel.layer.borderWidth = isDragonSel ? 0 : 1;
    self.dragonLabel.textColor = isDragonSel ? [UIColor whiteColor] : MainColor;
    self.dragonLabel.backgroundColor = isDragonSel ?
    [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
                          withFrame:self.dragonLabel.bounds
                          andColors:@[CP16Color(0xC2282F), CP16Color(0xFF5B72)]] :
    [UIColor clearColor];
}












- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = CPFont(15);
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

- (UILabel *)dragonOddsLabel{
    if (!_dragonOddsLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = CPFont(13);
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _dragonOddsLabel = title;
    }
    return _dragonOddsLabel;
}
- (UILabel *)tigerOddsLabel{
    if (!_tigerOddsLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = CPFont(13);
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _tigerOddsLabel = title;
    }
    return _tigerOddsLabel;
}
- (UILabel *)dragonLabel{
    if(!_dragonLabel){
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(16);
        title.textColor = MainColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.userInteractionEnabled = YES;
        title.layer.cornerRadius = PtOn47(20);
        title.layer.borderWidth = 0.5;
        title.layer.borderColor = MainBorderColor.CGColor;
        title.clipsToBounds = YES;
        [title addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dragon)]];
        
        [self.contentView addSubview:title];
        _dragonLabel = title;
    }
    return _dragonLabel;
}
- (UILabel *)tigerLabel{
    if(!_tigerLabel){
        
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(16);
        title.textColor = MainColor;
        title.textAlignment = NSTextAlignmentCenter;
        title.userInteractionEnabled = YES;
        [title addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tiger)]];
        title.layer.cornerRadius = PtOn47(20);
        title.layer.borderWidth = 0.5;
        title.layer.borderColor = MainBorderColor.CGColor;
        title.clipsToBounds = YES;
        
        [self.contentView addSubview:title];
        _tigerLabel = title;
    }
    return _tigerLabel;
}

- (UIView *)verLine1{
    if(!_verLine1){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.contentView addSubview:v];
        _verLine1 = v;
    }
    return _verLine1;
}
- (UIView *)horLine1{
    if(!_horLine1){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.contentView addSubview:v];
        _horLine1 = v;
    }
    return _horLine1;
}
- (UIView *)verLine2{
    if(!_verLine2){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.contentView addSubview:v];
        _verLine2 = v;
    }
    return _verLine2;
}
- (UIView *)horLine2{
    if(!_horLine2){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.contentView addSubview:v];
        _horLine2 = v;
    }
    return _horLine2;
}


- (void)tiger{
    if(self.tigerTap)self.tigerTap(self);
}
- (void)dragon{
    if(self.dragonTap)self.dragonTap(self);
}
@end
