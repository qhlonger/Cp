//
//  ModifyPayPasswordVC.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ModifyPayPasswordVC.h"
#import "SafetyTextFieldView.h"
#import "NumKeyboardView.h"


typedef NS_ENUM(NSInteger, ModifyPayPwdStep) {
    ModifyPayPwdStepEnterOldPwd,
    ModifyPayPwdStepEnterNewPwd
};
@interface ModifyPayPasswordVC ()
@property(nonatomic, weak) SafetyTextFieldView *safetyTextField;
@property(nonatomic, weak) UILabel *textLabel;
@property(nonatomic, weak) UIButton *nextStepButton;
@property(nonatomic, weak) NumKeyboardView *customKeyboard;
@property(nonatomic, assign) BOOL isKbShow;

@property(nonatomic, assign) ModifyPayPwdStep step;

@end

@implementation ModifyPayPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改支付密码";
    self.isKbShow = NO;
    self.step = ModifyPayPwdStepEnterOldPwd;

}
- (void)addSubview{
    [self textLabel];
    [self safetyTextField];
    [self customKeyboard];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (_isKbShow) {
        [self showKb];
    }
}

- (void)setStep:(ModifyPayPwdStep)step{
    _step = step;
    
    self.safetyTextField.values = @"";
    switch (step) {
        case ModifyPayPwdStepEnterOldPwd:{
            self.textLabel.text = @"请输入旧支付密码";
            [self.nextStepButton setTitle:@"下一步" forState:UIControlStateNormal];
            
        }break;
        case ModifyPayPwdStepEnterNewPwd:{
            self.textLabel.text = @"请输入新支付密码";
            [self.nextStepButton setTitle:@"确定" forState:UIControlStateNormal];
        
        }break;
        default:
        break;
    }
}

- (void)layout{
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(PtOn47(40));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(PtOn47(40));
    }];
    [self.safetyTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.textLabel.mas_bottom).offset(PtOn47(30));
        make.left.equalTo(self.view).offset(PtOn47(20));
        make.height.mas_equalTo(self.safetyTextField.mas_width).multipliedBy(1/6.8f);
    }];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.safetyTextField.mas_bottom).offset(PtOn47(25));
        make.height.mas_equalTo(RowH);
        make.centerX.equalTo(self.view);
//        make.width.mas_equalTo(50*6);
        make.width.equalTo(self.safetyTextField);
    }];
}

- (void)showKb{
    [UIView animateWithDuration:0.25 animations:^{
        self.customKeyboard.frame= CGRectMake(0, self.view.height -  self.view.width * 0.7, self.view.width, self.view.width * 0.7);
    } completion:^(BOOL finished) {
        self.isKbShow = YES;
    }];
}
- (void)hideKb{
    [UIView animateWithDuration:0.25 animations:^{
       self.customKeyboard.frame= CGRectMake(0, self.view.height, self.view.width, self.view.width * 0.7);
    } completion:^(BOOL finished) {
        self.isKbShow = NO;
    }];
}

- (NumKeyboardView *)customKeyboard{
    if (!_customKeyboard) {
        NumKeyboardView *kb = [[NumKeyboardView alloc]init];
        kb.frame= CGRectMake(0, self.view.height, self.view.width, self.view.width * 0.7);
        __weak __typeof(self)weakSelf = self;
        [kb setNeedDismiss:^(NumKeyboardView *kb) {
            [weakSelf hideKb];
        }];
        [kb setNeedBackSpace:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if(strongSelf.safetyTextField.values.length > 0)
            strongSelf.safetyTextField.values = [strongSelf.safetyTextField.values substringWithRange:NSMakeRange(0, strongSelf.safetyTextField.values.length - 1)];
        }];
        [kb setDidInputText:^(NSString *text) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.safetyTextField.values = [strongSelf.safetyTextField.values  stringByAppendingString:text];
        }];
        [self.view addSubview:kb];
        _customKeyboard = kb;
    }
    return _customKeyboard;
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.text = @"请输入您的新密码";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = TextGrayColor;
        [self.view addSubview:label];
        _textLabel =  label;
    }
    return _textLabel;
}
- (SafetyTextFieldView *)safetyTextField{
    if (!_safetyTextField) {
        SafetyTextFieldView *stf = [[SafetyTextFieldView alloc]init];
        [stf setDidFull:^(NSString *value) {
            
        }];
        [stf addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showKb)]];
        [self.view addSubview:stf];
        _safetyTextField = stf;
    }
    return _safetyTextField;
}
- (UIButton *)nextStepButton{
    if (!_nextStepButton) {
        UIButton *nsBtn = [Utility submitBtn];
        [nsBtn setTitle:@"下一步" forState:UIControlStateNormal];
        __weak __typeof(self)weakSelf = self;
        [nsBtn bk_addEventHandler:^(id sender) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            if(strongSelf.step == ModifyPayPwdStepEnterOldPwd){
                self.step = ModifyPayPwdStepEnterNewPwd;
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:nsBtn];
        _nextStepButton = nsBtn;
    }
    return _nextStepButton;
}

@end
