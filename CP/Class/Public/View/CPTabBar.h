//
//  CPTabBar.h
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CPTabBarItem : UIButton

@end


@interface CPTabBar : UIImageView

@property(nonatomic, copy) void(^ItemClick) (CPTabBarItem *item, NSInteger index);

- (void)setSelectIndex:(NSInteger)index;

@end



