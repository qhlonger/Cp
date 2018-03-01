//
//  ModifyLoginPasswordVC.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ModifyLoginPasswordVC.h"
#import "CustomerServiceVC.h"
@interface ModifyLoginPasswordVC ()
@property(nonatomic, weak) UITextField *oldPasswordTextField;
@property(nonatomic, weak) UITextField *passwordTextField;
@property(nonatomic, weak) UITextField *rePasswordTextField;
@property(nonatomic, weak) UIButton *submitBtn;
@property(nonatomic, weak) YYLabel *contactLabel;
@property(nonatomic, weak) UIView *pwdBgView;

@end

@implementation ModifyLoginPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
}
- (void)addSubview{
    [self oldPasswordTextField];
    [self passwordTextField];
    [self rePasswordTextField];
    [self submitBtn];
    [self contactLabel];
}
- (void)layout{
    CGFloat padding = 15;
    [self.oldPasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(RowH);
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.view).offset(padding);
    }];
    [self.pwdBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.oldPasswordTextField.mas_bottom).offset(padding+5);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(RowH*2-1);
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.pwdBgView);
        make.height.equalTo(self.pwdBgView).multipliedBy(0.5);
        
    }];
    [self.rePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.pwdBgView);
        make.height.equalTo(self.passwordTextField).offset(-1);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.pwdBgView.mas_bottom).offset(padding);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(RowH);
    }];
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.submitBtn.mas_bottom).offset(padding);
        make.right.equalTo(self.submitBtn);
        make.height.mas_equalTo(PtOn47(30));
        make.width.mas_equalTo(PtOn47(200));
    }];
}

- (UITextField *)oldPasswordTextField{
    if (!_oldPasswordTextField) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = YES;
        tf.backgroundColor = [UIColor whiteColor];
        
        
        tf.layer.cornerRadius = SRadius;
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = SepColor.CGColor;
        
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(13);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请输入您的原密码";
        [self.view addSubview:tf];
        _oldPasswordTextField = tf;
    }
    return _oldPasswordTextField;
}
- (UIView *)pwdBgView{
    if(!_pwdBgView){
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = SepColor;
        bg.layer.cornerRadius = SRadius;
        bg.layer.borderWidth = 1;
        bg.layer.borderColor = SepColor.CGColor;
        bg.clipsToBounds = YES;
        [self.view addSubview:bg];
        _pwdBgView = bg;
    }
    return _pwdBgView;
}
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = YES;
        tf.backgroundColor = [UIColor whiteColor];
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(13);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请设置您的新密码（数字字母组合，长度6-15位）";
        [self.pwdBgView addSubview:tf];
        _passwordTextField = tf;
    }
    return _passwordTextField;
}
- (UITextField *)rePasswordTextField{
    if (!_rePasswordTextField) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = YES;
        tf.backgroundColor = [UIColor whiteColor];
        
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(13);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请再次输入您的新密码";
        [self.pwdBgView addSubview:tf];
        _rePasswordTextField = tf;
    }
    return _rePasswordTextField;
}

- (UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *btn = [Utility submitBtn];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [self.view addSubview:btn];
        _submitBtn = btn;
    }
    return _submitBtn;
}
- (YYLabel *)contactLabel{
    if (!_contactLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        __weak __typeof(self)weakSelf = self;
        label.attributedText = [self contactStringWithClickAction:^{
            
            [weakSelf.navigationController pushViewController:[[CustomerServiceVC alloc]init] animated:weakSelf];
        }];
        [self.view addSubview:label];
        _contactLabel = label;
    }
    return _contactLabel;
}


- (NSMutableAttributedString *)contactStringWithClickAction:(void(^)(void))action{
    NSMutableAttributedString *attrPart1 = [[NSMutableAttributedString alloc]initWithString:@"忘记原密码？"];
    
    [attrPart1 setYy_font:CPFont(14)];
    [attrPart1 setYy_color:TextGrayColor];
    
    NSMutableAttributedString *attrPart2 = [[NSMutableAttributedString alloc]initWithString:@"联系客服"];
    
    [attrPart2 setYy_font:CPFont(14)];
    [attrPart2 setYy_color:BlueBallColor];
    [attrPart2 yy_setTextHighlightRange:NSMakeRange(0, attrPart2.length) color:BlueBallColor backgroundColor:BgDarkGray tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if(action)action();
    }];
    [attrPart1 appendAttributedString:attrPart2];
    [attrPart1 setYy_alignment:NSTextAlignmentRight];
    return attrPart1;
}
@end
