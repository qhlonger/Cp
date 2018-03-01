//
//  BaseCardCell.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseCardCell.h"

@implementation BaseCardCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(NormalMargin);
            make.top.equalTo(self.contentView).offset(NormalMargin/2);
            make.right.equalTo(self.contentView).offset(-NormalMargin);
            make.bottom.equalTo(self.contentView).offset(-NormalMargin/2);
        }];
    }
    return self;
}
- (UIView *)bgView{
    if (!_bgView) {
        UIView *v = [[UIView alloc]init];
        v.layer.cornerRadius = 5;
        v.layer.shadowOpacity = 1;
        v.layer.shadowRadius = 2;
        v.layer.shadowOffset = CGSizeMake(1, 1);
        v.layer.shadowColor = CPRGBA(50, 50, 50, 0.1).CGColor;
        v.backgroundColor = [UIColor whiteColor];
//        v.layer
        [self.contentView addSubview:v];
        _bgView = v;
    }
    return _bgView;
}
@end
