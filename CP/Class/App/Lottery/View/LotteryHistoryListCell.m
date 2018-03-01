//
//  LotteryHistoryListCell.m
//  CP
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LotteryHistoryListCell.h"

@implementation LotteryHistoryListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layout];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    self.bgView.backgroundColor = highlighted ? BgDarkGray : [UIColor whiteColor];
}
- (void)layout{
    CGFloat margin = NormalMargin;
    [self.phaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(margin);
        make.left.equalTo(self.bgView).offset(margin);
        make.width.equalTo(self.bgView).multipliedBy(0.4);
        make.height.mas_equalTo(PtOn47(18));
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-margin);
        make.width.equalTo(self.bgView).multipliedBy(0.6);
        make.height.mas_equalTo(PtOn47(18));
        make.top.equalTo(self.phaseLabel);
    }];
    [self.numbersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(margin);
        make.right.equalTo(self.bgView).offset(-margin);
        make.bottom.equalTo(self.bgView).offset(-margin/2);
        make.top.equalTo(self.phaseLabel.mas_bottom).offset(margin/2);
    }];
}

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(12);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:title];
        _dateLabel = title;
    }
    return _dateLabel;
}

- (UILabel *)phaseLabel{
    if (!_phaseLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextDarkGrayColor;
        [self.contentView addSubview:title];
        _phaseLabel = title;
    }
    return _phaseLabel;
}
- (LotteryNumberView *)numbersView{
    if (!_numbersView) {
        LotteryNumberView *numbersView = [[LotteryNumberView alloc]init];
        numbersView.hor_padding = 0;
        numbersView.ver_padding = 2;
        [self.contentView addSubview: numbersView];
        _numbersView = numbersView;
    }
    return _numbersView;
}




@end
