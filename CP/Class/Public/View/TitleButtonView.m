//
//  TitleButtonView.m
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "TitleButtonView.h"

@implementation TitleButtonView


- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    self.bgView.hidden = !selected;

    CGAffineTransform firstRotation = CGAffineTransformMakeRotation(0);
    CGAffineTransform secondRotation = CGAffineTransformMakeRotation(M_PI);
    

    [UIView animateWithDuration:0.25 animations:^{
        self.arrowImgView.transform = selected ? secondRotation : firstRotation;
    }];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview];
        
        self.alignment = TitleButtonViewAlignmentAllCenter;
    }
    return self;
}
- (void)addSubview{
    [self bgView];
    [self titleLabel];
    [self arrowImgView];
}

- (void)setAlignment:(TitleButtonViewAlignment)alignment{
    _alignment = alignment;
    switch (alignment) {
        case TitleButtonViewAlignmentAllCenter:{
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).offset(-NormalMargin);
                make.centerY.equalTo(self);
            }];
            [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right);
                make.height.width.with.mas_equalTo(PtOn47(20));
                make.centerY.equalTo(self);
            }];
            [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.height.mas_equalTo(PtOn47(36));
                make.centerY.equalTo(self);
                make.right.equalTo(self.arrowImgView).offset(NormalMargin);
            }];
        }break;
        case TitleButtonViewAlignmentTitleCenter:{
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
            }];
            [self.arrowImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel.mas_right);
                make.height.width.with.mas_equalTo(PtOn47(20));
                make.centerY.equalTo(self);
            }];
            [self.bgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.height.mas_equalTo(PtOn47(36));
                make.centerY.equalTo(self);
                make.right.equalTo(self.arrowImgView).offset(NormalMargin);
            }];
        }break;
    }
}
- (UIView *)bgView{
    if(!_bgView){
        UIView *bg = [[UIView alloc]init];
        bg.userInteractionEnabled = NO;
        bg.hidden = YES;
        bg.layer.cornerRadius = 5;
        bg.backgroundColor = [MainColor colorWithAlphaComponent:0.8];
        [self addSubview:bg];
        _bgView = bg;
    }
    return _bgView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(18);
        
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = [UIColor whiteColor];
        [self addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UIImageView *)arrowImgView{
    if(!_arrowImgView){
        UIImageView *img = [[UIImageView alloc]init];
        img.contentMode = UIViewContentModeCenter;
        img.image = [UIImage imageNamed:@"touzhuchaxun_xialashuaixuan"];
        [self addSubview:img];
        _arrowImgView = img;
    }
    return _arrowImgView;
}



@end
