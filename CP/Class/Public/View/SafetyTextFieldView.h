//
//  SafetyTextFieldView.h
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SafetyTextFieldView : UIView
@property(nonatomic, assign) NSInteger numberCount;
@property(nonatomic, assign) CGFloat borderWidth;
@property(nonatomic, weak) UITextField *textField;
@property(nonatomic, strong) NSArray *labels;



@property(nonatomic, copy) NSString *values;
@property(nonatomic, assign) BOOL isFull;
@property(nonatomic, copy) void(^didFull) (NSString *value);
@end
