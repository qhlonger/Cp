//
//  CPAlertView.h
//  CP
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPAlertView : UIView



@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UILabel *infoLabel;
@property(nonatomic, weak) UIButton *leftBtn;
@property(nonatomic, weak) UIButton *rightBtn;
@property(nonatomic, weak) UIView *mainView;
@property(nonatomic, weak) UITextField *textField;

@property(nonatomic, weak) UIView *bgView;
@property(nonatomic, weak) UIView *topLine;



@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *info;
@property(nonatomic, copy) NSString *leftTitle;
@property(nonatomic, copy) NSString *rightTitle;
@property(nonatomic, assign) BOOL tapBack;
@property(nonatomic, assign) BOOL showTextField;
@property(nonatomic, assign) BOOL showTopLine;
@property(nonatomic, copy) BOOL(^leftAction)(CPAlertView *alertView);
@property(nonatomic, copy) BOOL(^rightAction)(CPAlertView *alertView);
@property(nonatomic, copy) void(^config)(CPAlertView *alertView);




+ (void)showWithTitle:(NSString *)title
                 info:(NSString *)info
            leftTitle:(NSString *)leftTitle
           rightTitle:(NSString *)rightTitle
               config:(void(^)(CPAlertView *alertView))config
           leftAction:(BOOL(^)(CPAlertView *alertView))leftAction
          rightAction:(BOOL(^)(CPAlertView *alertView))rightAction;

+ (void)showWithConfig:(void(^)(CPAlertView *alertView))config;
@end
