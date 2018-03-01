//
//  NoticeCell.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardCell.h"
@interface NoticeCell : BaseCardCell
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *categoryLabel;
@property(nonatomic, weak) UILabel *dateLabel;
@property(nonatomic, weak) UIView *line;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *detailLabel;


@end
