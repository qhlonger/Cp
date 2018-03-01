//
//  BettingHistoryCell.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingHistoryCell.h"
@implementation BettingHistoryCellBgView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.bgColor = [UIColor whiteColor];
    }
    return self;
}
- (void)setBgColor:(UIColor *)bgColor{
    _bgColor = bgColor;
//    self.shapeLayer.fillColor = bgColor.CGColor;
    [self setNeedsDisplay];
    //    [self drawRect:self.bounds];
}
- (CAShapeLayer *)shapeLayer{
    if (!_shapeLayer) {
        CAShapeLayer *layer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:layer];
        _shapeLayer = layer;
    }
    return _shapeLayer;
}
- (void)drawRect:(CGRect)rect{
    
        [_bgColor set];
    
    CGFloat height = CGRectGetHeight(rect);
    CGFloat width = CGRectGetWidth(rect);
    
    CGFloat lrArcRadius = 30;
    
    
    UIBezierPath *borderPath = [UIBezierPath bezierPath];
    borderPath.lineWidth = 2;
    borderPath.lineCapStyle = kCGLineCapButt;



    [borderPath moveToPoint:CGPointMake(0, 0)];

    [borderPath addLineToPoint:CGPointMake(width, 0)];
    [borderPath addLineToPoint:CGPointMake(width, height / 2 - lrArcRadius)];
    [borderPath addArcWithCenter:CGPointMake(width + 15, height/2) radius:lrArcRadius startAngle:M_PI*1.5 endAngle:M_PI*0.5 clockwise:NO];
    [borderPath addLineToPoint:CGPointMake(width, height)];

    [borderPath addLineToPoint:CGPointMake(0, height)];
    [borderPath addLineToPoint:CGPointMake(0, height / 2 + lrArcRadius)];
    [borderPath addArcWithCenter:CGPointMake(0 - 15, height/2) radius:lrArcRadius startAngle:M_PI*0.5 endAngle:M_PI*1.5 clockwise:NO];
    [borderPath closePath];
    [borderPath fill];

    [borderPath closePath];

    
//    self.shapeLayer.frame = self.bounds;
//    self.shapeLayer.path = borderPath.CGPath;
    
    
    
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(currentContext, SepColor.CGColor);
    CGContextSetLineWidth(currentContext, 1);
    CGContextMoveToPoint(currentContext, 15, height/2);
    CGContextAddLineToPoint(currentContext, width-15, height/2);
    CGFloat arr[] = {5,2};
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}
- (void)layoutSubviews{
//    self.shapeLayer.frame = self.bounds;
    //    [self drawRect:self.bounds];
}
@end
@implementation BettingHistoryCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview];
        [self layout];
        self.backgroundColor = [UIColor clearColor];
        
        self.betMoneyLabel.text = @"投注金额 :";
        self.betOddsLabel.text = @"投注赔率 :";
        self.betTimeLabel.text = @"投注时间 :";
    }
    return self;
}
- (void)addSubview{
    
}
- (void)layout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NormalMargin);
        make.top.equalTo(self.contentView).offset(NormalMargin/2);
        make.right.equalTo(self.contentView).offset(-NormalMargin);
        make.bottom.equalTo(self.contentView).offset(-NormalMargin/2);
    }];
    
    CGFloat margin = NormalMargin;
    CGFloat rightMargin = PtOn47(35);
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(margin);
        make.width.height.mas_equalTo(PtOn47(24));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.width.equalTo(self.bgView).multipliedBy(0.6);
    }];
    [self.phaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-rightMargin);
        make.top.bottom.equalTo(self.iconView);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
    }];
    [self.betNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgView).multipliedBy(0.25);
        make.centerY.equalTo(self.bgView).multipliedBy(0.75);
//        make.left.equalTo(self.bgView).offset(margin);
        make.width.equalTo(self.bgView).multipliedBy(0.6);
        make.left.equalTo(self.titleLabel);
//        make.right.equalTo(self.bgView).offset(-margin);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgView).multipliedBy(0.25);
        make.centerY.equalTo(self.bgView).multipliedBy(0.75);
//        make.left.equalTo(self.bgView).offset(margin);
        make.width.equalTo(self.bgView).multipliedBy(0.6);
//        make.right.equalTo(self.bgView).offset(-margin);
        make.right.equalTo(self.bgView).offset(-rightMargin);
    }];
    
    [self.betMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgView).multipliedBy(0.125);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
        make.centerY.equalTo(self.bgView).multipliedBy(1.25);
        
    }];
    [self.betOddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgView).multipliedBy(0.125);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
        make.centerY.equalTo(self.bgView).multipliedBy(1.5);
    }];
    [self.betTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.bgView).multipliedBy(0.125);
        make.left.equalTo(self.titleLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
        make.centerY.equalTo(self.bgView).multipliedBy(1.75);
        
    }];
    [self.betMoneyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-rightMargin);
        make.top.bottom.equalTo(self.betMoneyLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
        
    }];
    [self.betOddsContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-rightMargin);
        make.top.bottom.equalTo(self.betOddsLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
    }];
    [self.betTimeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-rightMargin);
        make.top.bottom.equalTo(self.betTimeLabel);
        make.width.equalTo(self.bgView).multipliedBy(0.5);
    }];
    
    
    
    
    
}
- (BettingHistoryCellBgView *)bgView{
    if (!_bgView) {
        
        BettingHistoryCellBgView *v = [[BettingHistoryCellBgView alloc]init];
        v.layer.cornerRadius = 5;
        v.layer.shadowOpacity = 1;
        v.layer.shadowRadius = 2;
        v.layer.shadowOffset = CGSizeMake(1, 1);
        v.layer.shadowColor = CPRGBA(50, 50, 50, 0.2).CGColor;
        [self.contentView addSubview:v];
        _bgView = v;
        
    }
    return _bgView;
}
- (UILabel *)betNumberLabel{
    if (!_betNumberLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.font = CPFont(13);
        label.adjustsFontSizeToFitWidth = YES;
        label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        label.textColor = TextDarkGrayColor;
        [self.contentView addSubview:label];
        _betNumberLabel = label;
    }
    return _betNumberLabel;
}
- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.bgView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(15);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextBlackColor;
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.bgView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)phaseLabel{
    if (!_phaseLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(12);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:title];
        _phaseLabel = title;
    }
    return _phaseLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(27);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:title];
        _moneyLabel = title;
    }
    return _moneyLabel;
}
- (UILabel *)betMoneyLabel{
    if (!_betMoneyLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:title];
        _betMoneyLabel = title;
    }
    return _betMoneyLabel;
}
- (UILabel *)betOddsLabel{
    if (!_betOddsLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:title];
        _betOddsLabel = title;
    }
    return _betOddsLabel;
}
- (UILabel *)betTimeLabel{
    if (!_betTimeLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:title];
        _betTimeLabel = title;
    }
    return _betTimeLabel;
}

- (UILabel *)betMoneyContentLabel{
    if (!_betMoneyContentLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:title];
        _betMoneyContentLabel = title;
    }
    return _betMoneyContentLabel;
}
- (UILabel *)betOddsContentLabel{
    if (!_betOddsContentLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:title];
        _betOddsContentLabel = title;
    }
    return _betOddsContentLabel;
}
- (UILabel *)betTimeContentLabel{
    if (!_betTimeContentLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:title];
        _betTimeContentLabel = title;
    }
    return _betTimeContentLabel;
}





@end
