//
//  ScrollNoticeView.h
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ScrollNoticeView : UIView
@property(nonatomic, weak) TXScrollLabelView *scrollLabel;
@property(nonatomic, weak) UIImageView *noticeIconView;

@property(nonatomic, copy) void(^didClick) (TXScrollLabelView *scrollLabel, NSString *text, NSInteger index);

@end
