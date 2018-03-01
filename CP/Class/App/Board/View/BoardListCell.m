//
//  BoardListCell.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BoardListCell.h"

@implementation BoardListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.backgroundColor = MainBgGray;
        
        [self layout];
        self.usernameLabel.text = @"用户名";
        self.profitLabel.text = @"赢利";
    }
    return self;
}
- (void)layout{
    CGFloat margin = NormalMargin;
    [self.rankImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin/2);
        make.top.equalTo(self.contentView).offset(margin);
        make.bottom.equalTo(self.contentView).offset(-margin*2);
        make.height.equalTo(self.rankImgView.mas_width);
    }];
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.rankImgView);
    }];
    [self.usernameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankImgView.mas_right).offset(margin/2);
        make.width.equalTo(self.contentView).multipliedBy(0.35);
        
        make.height.mas_equalTo(PtOn47(20));
        make.bottom.equalTo(self.contentView.mas_centerY);
    }];
    [self.usernameContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rankImgView.mas_right).offset(margin/2);
        make.top.equalTo(self.usernameLabel.mas_bottom);
        make.height.mas_equalTo(PtOn47(20));
        make.width.equalTo(self.contentView).multipliedBy(0.35);
    }];
    [self.profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-margin);
        make.width.equalTo(self.contentView).multipliedBy(0.35);
        
        
        make.height.mas_equalTo(PtOn47(20));
        make.bottom.equalTo(self.contentView.mas_centerY);
        
    }];
    [self.profitContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-margin);
        make.top.equalTo(self.profitLabel.mas_bottom);
        make.height.mas_equalTo(PtOn47(20));
        make.width.equalTo(self.contentView).multipliedBy(0.35);
    }];
}


- (UILabel *)usernameLabel{
    if (!_usernameLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.textColor = TextDarkGrayColor;
        title.textAlignment = NSTextAlignmentLeft;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:title];
        _usernameLabel = title;
    }
    return _usernameLabel;
}

- (UILabel *)usernameContentLabel{
    if (!_usernameContentLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.textAlignment = NSTextAlignmentLeft;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _usernameContentLabel = title;
    }
    return _usernameContentLabel;
}
- (UIImageView *)rankImgView{
    if (!_rankImgView) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.contentMode = UIViewContentModeCenter;
        imgView.image = [UIImage imageNamed:@"board_4_"];
        [self.contentView addSubview:imgView];
        _rankImgView = imgView;
    }
    return _rankImgView;
}
- (UILabel *)rankLabel{
    if (!_rankLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(10);
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = [UIColor blackColor];
        [self.contentView addSubview:title];
        _rankLabel = title;
    }
    return _rankLabel;
}
- (UILabel *)profitLabel{
    if (!_profitLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.textColor = TextDarkGrayColor;
        title.font = CPFont(13);
        title.textAlignment = NSTextAlignmentRight;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:title];
        _profitLabel = title;
    }
    return _profitLabel;
}

- (UILabel *)profitContentLabel{
    if (!_profitContentLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(18);
        title.textColor = MainColor;
        title.textAlignment = NSTextAlignmentRight;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:title];
        _profitContentLabel = title;
    }
    return _profitContentLabel;
}




@end
