//
//  SwitchLotteryView.h
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryModel.h"

@interface SwitchLotteryViewCell : UICollectionViewCell

@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, assign) BOOL isSel;


@end

@interface SwitchLotteryView : UIView
@property(nonatomic, assign) BOOL isShow;
- (void)show;
- (void)hide;

@property(nonatomic, strong) NSArray <LotteryModel *>*lotteryModels;

@property(nonatomic, weak) UIView *bgView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, assign) NSInteger selectedIndex;
@property(nonatomic, copy) void(^didSel) (SwitchLotteryView *switchView, NSInteger index);
@property(nonatomic, copy) void(^didHide) (void);
@end
