//
//  BettingColSectionHeader.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingColSectionHeader.h"

@implementation BettingColSectionHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview];
        [self layout];
    }
    return self;
}
- (void)addSubview{
    [self titleLabel];
}
- (void)layout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(16);
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = MainColor;
        [self addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

@end
