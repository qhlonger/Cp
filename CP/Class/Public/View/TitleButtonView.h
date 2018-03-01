//
//  TitleButtonView.h
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TitleButtonViewAlignment){
    TitleButtonViewAlignmentTitleCenter,
    TitleButtonViewAlignmentAllCenter,
} ;
@interface TitleButtonView : UIControl
@property(nonatomic, assign) CGSize intrinsicContentSize;
@property(nonatomic, assign) TitleButtonViewAlignment alignment;
@property(nonatomic, weak) UIImageView *arrowImgView;
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIView *bgView;
@end
