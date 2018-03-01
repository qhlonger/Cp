//
//  NumKeyboardView.h
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumKeyboardView : UIView
@property(nonatomic, assign) BOOL allowDot;


@property(nonatomic, copy) void(^needDismiss) (NumKeyboardView *kb);
@property(nonatomic, copy) void(^needBackSpace) (void);
@property(nonatomic, copy) void(^didInputText) (NSString *text);
//@property(nonatomic, copy) void(^didInputText) (
@end
