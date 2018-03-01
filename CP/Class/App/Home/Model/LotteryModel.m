//
//  LotteryModel.m
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LotteryModel.h"

@implementation LotteryModel





- (NSMutableAttributedString *)detailAttr{
    if (!_detailAttr) {
        if(self.detail){
            _detailAttr = [[NSMutableAttributedString alloc]initWithString:self.detail];
            [_detailAttr setYy_color:TextDarkGrayColor];
            [_detailAttr setYy_font:CPFont(12)];
            if(self.range_length && self.range_start)
                [_detailAttr yy_setColor:MainColor range:NSMakeRange([self.range_start integerValue], [self.range_length integerValue])];
        }
    }
    return _detailAttr;
}
@end
