//
//  BoardListCell.h
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCardCell.h"

@interface BoardListCell : UITableViewCell

@property(nonatomic, weak) UILabel *usernameLabel;
@property(nonatomic, weak) UILabel *usernameContentLabel;
@property(nonatomic, weak) UIImageView *rankImgView;
@property(nonatomic, weak) UILabel *rankLabel;
@property(nonatomic, weak) UILabel *profitLabel;
@property(nonatomic, weak) UILabel *profitContentLabel;

@end
