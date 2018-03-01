//
//  BillsListCell.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BillsListCell.h"

@implementation BillsListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layout];
    }
    return self;
}
- (void)addSubview{
    [self line];
    [self dot];
    [self titleLabel];
    [self dateLabel];
    [self moneyLabel];
    [self balanceLabel];
}
- (void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(2);
        make.left.equalTo(self.contentView).offset(PtOn47(30));
    }];
    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.line);
        make.width.height.mas_equalTo(PtOn47(7));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dot.mas_right).offset(PtOn47(20));
        make.top.equalTo(self.contentView).offset(NormalMargin);
        make.right.equalTo(self.moneyLabel.mas_left).offset(-NormalMargin);
        make.bottom.equalTo(self.dateLabel.mas_top);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dot.mas_right).offset(PtOn47(20));
        make.bottom.equalTo(self.contentView).offset(-NormalMargin);
        make.width.equalTo(self.contentView).multipliedBy(0.6);
        make.height.mas_equalTo(PtOn47(20));
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NormalMargin);
//        make.top.equalTo(self.contentView).offset(20);
//        make.bottom.equalTo(self.balanceLabel.mas_top);
        make.centerY.equalTo(self.titleLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.4);
        make.height.mas_equalTo(PtOn47(30));
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NormalMargin);
//        make.bottom.equalTo(self.contentView).offset(-NormalMargin);
        make.centerY.equalTo(self.dateLabel);
        make.width.equalTo(self.contentView).multipliedBy(0.6);
        make.height.mas_equalTo(PtOn47(20));
    }];
}

- (UIView *)line{
    if (!_line) {
        
        UIView *line = [[UIView alloc]init];

        line.backgroundColor = [MainColor colorWithAlphaComponent:0.1];
        [self.contentView addSubview:line];
        _line = line;
    }
    return _line;
}
- (UIView *)dot{
    if (!_dot) {
        UIView *dot = [[UIView alloc]init];
        dot.backgroundColor = MainColor;
        dot.layer.cornerRadius = PtOn47(3.5);
        [self.contentView addSubview:dot];
        _dot = dot;
    }
    return _dot;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *dateLabel = [[UILabel alloc]init];
        dateLabel.font = CPFont(12);
        dateLabel.textColor = TextGrayColor;
        [self.contentView addSubview:dateLabel];
        _dateLabel = dateLabel;
    }
    return _dateLabel;
}
- (UILabel *)balanceLabel{
    if (!_balanceLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.textAlignment = NSTextAlignmentRight;
        title.textColor = TextGrayColor;
        [self.contentView addSubview:title];
        _balanceLabel = title;
    }
    return _balanceLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(20);
        title.adjustsFontSizeToFitWidth = YES;
        title.textAlignment = NSTextAlignmentRight;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = [UIColor redColor];
        [self.contentView addSubview:title];
        _moneyLabel = title;
    }
    return _moneyLabel;
}



@end
