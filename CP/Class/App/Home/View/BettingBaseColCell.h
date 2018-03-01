//
//  BettingBaseColCell.h
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingBaseColCell : UICollectionViewCell

@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *oddsLabel;
@property(nonatomic, weak) UIView *bgView;
@property(nonatomic, assign) BOOL isSel;
@end
