//
//  BuyLotteryListCell.m
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BuyLotteryListCell.h"

@implementation BuyLotteryListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self layout];
//        self.allowbuy = YES;
    }
    return self;
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//    
//    self.backgroundColor = highlighted ? MainBgGray : [UIColor whiteColor];
//}
- (void)layout{
    CGFloat margin = NormalMargin;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(margin);
        make.bottom.equalTo(self.contentView).offset(-margin);
        make.width.equalTo(self.iconView.mas_height).multipliedBy(1.2);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.equalTo(self.contentView).offset(-margin);
        make.top.equalTo(self.contentView).offset(margin);
        make.height.equalTo(self.iconView).multipliedBy(0.6);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(margin);
        make.right.equalTo(self.contentView).offset(-margin);
//        make.bottom.equalTo(self.contentView).offset(-margin);
//        make.height.equalTo(self.iconView).multipliedBy(0.4);
//        make.height.mas_equalTo(30);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
    }];
    [self.stateBadgeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.right.equalTo(self.contentView);
//        make.height.equalTo(self.contentView);
//        make.width.equalTo(self.contentView.mas_height);
        make.edges.equalTo(self.contentView);
    }];
    
}

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}

- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        YYLabel *title = [[YYLabel alloc]init];
        title.font = CPFont(16);
        //        title.adjustsFontSizeToFitWidth = YES;
        //        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

- (YYLabel *)detailLabel{
    if (!_detailLabel) {
        YYLabel *title = [[YYLabel alloc]init];
        title.font = CPFont(12);
        title.numberOfLines = 2;
        title.textLayout.container.maximumNumberOfRows = 2;
        title.lineBreakMode = NSLineBreakByWordWrapping;
        title.textLayout.container.truncationType = YYTextTruncationTypeNone;
        if(IsIp40){
            title.preferredMaxLayoutWidth = 200;
        }
        
//        title.
        //        title.adjustsFontSizeToFitWidth = YES;
        //        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextDarkGrayColor;
        [self.contentView addSubview:title];
        _detailLabel = title;
    }
    return _detailLabel;
}
- (UIImageView *)stateBadgeView{
    if (!_stateBadgeView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.hidden = YES;
        icon.backgroundColor = CPRGBA(255, 255, 255, 0.5);
        icon.image = [UIImage imageNamed:@"badge_discontinued"];
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeTopRight;
        [self.contentView addSubview:icon];
        _stateBadgeView = icon;
    }
    return _stateBadgeView;
}




- (void)setAllowbuy:(BOOL)allowbuy{
    _allowbuy = allowbuy;

    self.stateBadgeView.hidden = allowbuy;
}
@end
