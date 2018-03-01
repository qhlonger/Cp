//
//  MineHeaderCell.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MineHeaderCell.h"

@implementation MineHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(PtOn47(15));
            make.right.equalTo(self.contentView).offset(-PtOn47(15));
            make.top.equalTo(self.contentView);
            make.height.equalTo(self.contentView).multipliedBy(0.4);
        }];
        [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(PtOn47(15));
            make.right.equalTo(self.contentView).offset(-PtOn47(15));
            make.bottom.equalTo(self.contentView);
            make.height.equalTo(self.contentView).multipliedBy(0.7);
        }];
    }
    return self;
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font =  CPFont(14);
        title.textColor = TextBlackColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}
- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font =  CPFont(40);
        title.textColor = MainColor;
        [self.contentView addSubview:title];
        _moneyLabel = title;
    }
    return _moneyLabel;
}



@end
