//
//  BettingDragonTigerBallColCell.h
//  CP
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingDragonTigerBallColCell : UICollectionViewCell

@property(nonatomic, weak) UILabel *tigerLabel;
@property(nonatomic, weak) UILabel *dragonLabel;
@property(nonatomic, weak) UILabel *tigerOddsLabel;
@property(nonatomic, weak) UILabel *dragonOddsLabel;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIView *bgView;

@property(nonatomic, assign) BOOL isTigerSel;
@property(nonatomic, assign) BOOL isDragonSel;

@property(nonatomic, copy) void(^tigerTap) (BettingDragonTigerBallColCell *aCell);
@property(nonatomic, copy) void(^dragonTap) (BettingDragonTigerBallColCell *aCell);

@property(nonatomic, weak) UIView *verLine1;
@property(nonatomic, weak) UIView *horLine1;
@property(nonatomic, weak) UIView *verLine2;
@property(nonatomic, weak) UIView *horLine2;
@end
