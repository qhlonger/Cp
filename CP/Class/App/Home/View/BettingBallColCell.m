//
//  BettingBallColCell.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingBallColCell.h"

@implementation BettingBallColCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
        self.isSel = NO;
        
        self.titleLabel.layer.cornerRadius = PtOn47(20);
        self.titleLabel.layer.borderWidth = 0.5;
        self.titleLabel.layer.borderColor = MainBorderColor.CGColor;
        self.titleLabel.clipsToBounds = YES;
    }
    return self;
}

- (void)layout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
//        make.centerY.equalTo(self.contentView).multipliedBy(0.5);
        make.top.equalTo(self.contentView);
        make.width.height.mas_equalTo(PtOn47(40));
    }];
    [self.oddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.contentView);
    }];
}

- (void)setIsSel:(BOOL)isSel{
    [super setIsSel:isSel];
    
    self.titleLabel.layer.borderWidth = isSel ? 0 : 1;
    self.titleLabel.textColor = isSel ? [UIColor whiteColor] : MainColor;
    self.titleLabel.backgroundColor = isSel ?
    [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
                          withFrame:self.titleLabel.bounds
                          andColors:@[CP16Color(0xC2282F), CP16Color(0xFF5B72)]] :
    [UIColor clearColor];
    
}


@end
