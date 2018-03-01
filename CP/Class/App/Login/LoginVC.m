//
//  LoginVC.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LoginVC.h"
#import "CustomerServiceVC.h"
@interface LoginVC ()

@property(nonatomic, weak) UIButton *closeBtn;
@property(nonatomic, weak) UITextField *usernameTextField;
@property(nonatomic, weak) UITextField *passwordTextField;
@property(nonatomic, weak) UIButton *submitBtn;
@property(nonatomic, weak) YYLabel *contactLabel;
@property(nonatomic, weak) YYLabel *forgotLabel;
@property(nonatomic, weak) UIView *pwdBgView;
@property(nonatomic, weak) UIImageView *headerImgView;
@end

@implementation LoginVC


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.title = @"修改登录密码";
}
- (void)addSubview{
    [self headerImgView];
    [self closeBtn];
    [self pwdBgView];
    [self usernameTextField];
    [self passwordTextField];
    [self forgotLabel];
    [self submitBtn];
    [self contactLabel];
}
- (void)layout{
    CGFloat padding = 15;
    
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(self.headerImgView.mas_width).multipliedBy(0.685);
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-padding);
        make.width.height.mas_equalTo(PtOn47(44));
        make.top.equalTo(self.view).offset(padding + TopPadding);
    }];
    [self.pwdBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
//        make.top.equalTo(self.oldPasswordTextField.mas_bottom).offset(padding+5);
        make.centerY.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(RowH*2-1);
    }];
    [self.usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.pwdBgView);
        make.height.equalTo(self.pwdBgView).multipliedBy(0.5);
        
    }];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.pwdBgView);
        make.height.equalTo(self.usernameTextField).offset(-1);
    }];
    
    [self.forgotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.pwdBgView);
        make.height.mas_equalTo(PtOn47(20));
        make.width.mas_equalTo(PtOn47(100));
        make.top.equalTo(self.pwdBgView.mas_bottom).offset(NormalMargin);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(padding);
        make.top.equalTo(self.forgotLabel.mas_bottom).offset(NormalMargin);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(RowH);
    }];
    [self.contactLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-NormalMargin);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(PtOn47(40));
        make.width.mas_equalTo(PtOn47(200));
    }];
}



- (UIButton *)closeBtn{
    if(!_closeBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"dengluye_close"] forState:UIControlStateNormal];
        __weak __typeof(self)weakSelf = self;
        [btn bk_addEventHandler:^(id sender) {
            [weakSelf.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _closeBtn = btn;
    }
    return _closeBtn;
}
- (UIImageView *)headerImgView{
    if (!_headerImgView){
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"denglu_background"];
        img.contentMode = UIViewContentModeScaleAspectFill;
        [self.view addSubview:img];
        _headerImgView = img;
    }
    return _headerImgView;
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
- (UITextField *)usernameTextField{
    if (!_usernameTextField) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = NO;
        tf.backgroundColor = [UIColor whiteColor];
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(16);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请输入您的账号";
        [self.pwdBgView addSubview:tf];
        _usernameTextField = tf;
    }
    return _usernameTextField;
}
- (UITextField *)passwordTextField{
    if (!_passwordTextField) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = YES;
        tf.backgroundColor = [UIColor whiteColor];
        
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(16);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请输入您的密码";
        [self.pwdBgView addSubview:tf];
        _passwordTextField = tf;
    }
    return _passwordTextField;
}



- (UIButton *)submitBtn{
    if (!_submitBtn) {
        UIButton *btn = [Utility submitBtn];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
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
- (YYLabel *)forgotLabel{
    if (!_forgotLabel) {
        YYLabel *label = [[YYLabel alloc]init];
        label.attributedText = [self forgotStringWithClickAction:^{
            [Utility showStatus:@"忘记密码"];
        }];
        [self.view addSubview:label];
        _forgotLabel = label;
    }
    return _forgotLabel;
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
    [attrPart1 setYy_alignment:NSTextAlignmentCenter];
    return attrPart1;
}
- (NSMutableAttributedString *)forgotStringWithClickAction:(void(^)(void))action{
    NSMutableAttributedString *attrPart1 = [[NSMutableAttributedString alloc]initWithString:@"忘记密码?"];
    
    [attrPart1 setYy_font:CPFont(14)];
    [attrPart1 setYy_color:TextGrayColor];
    [attrPart1 yy_setTextHighlightRange:NSMakeRange(0, attrPart1.length) color:BlueBallColor backgroundColor:BgDarkGray tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if(action)action();
    }];

    [attrPart1 setYy_alignment:NSTextAlignmentRight];
    return attrPart1;
}









@end
