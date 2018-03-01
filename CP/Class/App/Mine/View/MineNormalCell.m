//
//  MineNormalCell.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MineNormalCell.h"

@implementation MineNormalCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = TextBlackColor;
        self.textLabel.font = CPFont(14);
    }
    return self;
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
//    [super setHighlighted:highlighted animated:animated];
//
//    self.backgroundColor = highlighted ? MainBgGray : [UIColor whiteColor];
//}
@end
