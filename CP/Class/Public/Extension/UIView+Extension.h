//
//  UIView+Extension.h
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign, readonly) CGFloat top;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat left;
@property (nonatomic, assign, readonly) CGFloat right;



@property(nonatomic, assign, readonly) CGFloat midX;
@property(nonatomic, assign, readonly) CGFloat midY;
@property(nonatomic, assign, readonly) CGFloat minX;
@property(nonatomic, assign, readonly) CGFloat minY;
@property(nonatomic, assign, readonly) CGFloat maxX;
@property(nonatomic, assign, readonly) CGFloat maxY;




@property(nonatomic, strong, readonly) UIActivityIndicatorView *actIndicator;
@property(nonatomic, strong, readonly) UIView *indicatorBgView;
@property(nonatomic, strong, readonly) UIView *indicatorCoverView;
/**
 防止HUD一闪而过
 */
@property(nonatomic, assign) BOOL isHudShow;


- (void)startLoadingWithCover;
- (void)startLoadingWithBg;
- (void)startLoading;
- (void)stopLoading;







@end
