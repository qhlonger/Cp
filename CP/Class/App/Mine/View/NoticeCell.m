//
//  NoticeCell.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview];
        [self layout];
    }
    return self;
}
- (void)addSubview{
    CGFloat margin = NormalMargin;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(margin);
        make.width.height.mas_equalTo(PtOn47(24));
    }];
    [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.width.equalTo(self.bgView).multipliedBy(0.8);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.iconView);
        make.right.equalTo(self.bgView).offset(-margin);
        make.width.equalTo(self.bgView).multipliedBy(0.4);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.bgView).offset(margin);
        make.right.equalTo(self.bgView).offset(-margin);
        make.top.equalTo(self.iconView.mas_bottom).offset(margin);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(margin);
        make.top.equalTo(self.line.mas_bottom).offset(margin);
        make.right.lessThanOrEqualTo(self.bgView.mas_right).offset(-margin);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.bgView).offset(margin);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
        make.right.lessThanOrEqualTo(self.bgView.mas_right).offset(-margin);
        make.bottom.equalTo(self.bgView).offset(-margin);
    }];
}
- (void)layout{
    
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
- (UILabel *)categoryLabel{
    if (!_categoryLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.textColor = TextBlackColor;
        [self.bgView addSubview:title];
        _categoryLabel = title;
    }
    return _categoryLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(11);
        title.textColor = TextGrayColor;
        title.textAlignment = NSTextAlignmentRight;
        [self.bgView addSubview:title];
        _dateLabel = title;
    }
    return _dateLabel;
}
- (UIView *)line{
    if (!_line) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = SepColor;
        [self.bgView addSubview:line];
        _line = line;
    }
    return _line;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.textColor = TextBlackColor;
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.bgView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(11);
        title.textColor = TextGrayColor;
        title.numberOfLines = 0;
        title.lineBreakMode = NSLineBreakByCharWrapping;
        [self.bgView addSubview:title];
        _detailLabel = title;
    }
    return _detailLabel;
}




@end
