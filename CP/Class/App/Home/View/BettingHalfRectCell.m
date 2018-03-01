//
//  BettingHalfRectCell.m
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingHalfRectCell.h"

@implementation BettingHalfRectCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self layout];
        self.isSel = NO;
    }
    return self;
}

- (void)layout{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(NormalMargin/2, NormalMargin/2, NormalMargin/2, NormalMargin/2));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(0.7);
        make.height.equalTo(self.contentView).multipliedBy(0.4);
        make.left.right.equalTo(self.contentView);
    }];
    [self.oddsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).multipliedBy(1.4);
        make.height.equalTo(self.contentView).multipliedBy(0.4);
        make.left.right.equalTo(self.contentView);
        
    }];
}
- (void)setIsSel:(BOOL)isSel{
    [super setIsSel:isSel];
    
    
    
    self.bgView.layer.borderWidth = isSel ? 0 : 1;
    self.titleLabel.textColor = isSel ? [UIColor whiteColor] : TextBlackColor;
    self.oddsLabel.textColor = isSel ? [UIColor whiteColor] : MainColor;
    
    self.bgView.backgroundColor = isSel ?
    [UIColor colorWithGradientStyle:UIGradientStyleLeftToRight
                          withFrame:self.bgView.bounds
                          andColors:@[CP16Color(0xC2282F), CP16Color(0xFF5B72)]] :
    [UIColor clearColor];
    
}



@end
