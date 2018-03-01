//
//  BindPhoneVC.m
//  CP
//
//  Created by Apple on 2018/1/23.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BindPhoneVC.h"

@interface BindPhoneVC ()
@property(nonatomic, weak) UIImageView *headerImgView;
@property(nonatomic, weak) UILabel *currentLabel;
@property(nonatomic, weak) UITextField *phoneTf;
@property(nonatomic, weak) UITextField *authTf;
@property(nonatomic, weak) UIButton *sendBtn;
@property(nonatomic, weak) UIView *tfBgView;
@property(nonatomic, weak) UIButton *okBtn;
@property(nonatomic, weak) UIView *tfSep;



@end

@implementation BindPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机";
    self.view.clipsToBounds = YES;
}

- (void)addSubview{
    [self headerImgView];
    [self currentLabel];
    [self tfBgView];
    [self phoneTf];
    [self authTf];
    [self tfSep];
    [self sendBtn];
    [self okBtn];
    
}

- (void)layout{
    [self.headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(PtOn47(40));
        make.height.mas_equalTo(PtOn47(80));
    }];
    [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NormalMargin);
        make.right.equalTo(self.view).offset(-NormalMargin);
        make.height.mas_equalTo(PtOn47(20));
        make.bottom.equalTo(self.tfBgView.mas_top).offset(-NormalMargin);
        
    }];
    [self.tfBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.top.equalTo(self.headerImgView.mas_bottom).offset(PtOn47(40));
        make.height.mas_equalTo(RowH*2);
    }];
    [self.phoneTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.tfBgView);
        make.height.equalTo(self.tfBgView).multipliedBy(0.5);
    }];
    [self.authTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.tfBgView);
        make.height.equalTo(self.tfBgView).multipliedBy(0.5);
        make.right.equalTo(self.sendBtn.mas_left).offset(-NormalMargin);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tfBgView).offset(-NormalMargin/2);
        make.bottom.equalTo(self.tfBgView).offset(-NormalMargin/2);
        make.top.equalTo(self.phoneTf.mas_bottom).offset(NormalMargin/2);
        make.width.mas_equalTo(PtOn47(72));
    }];
    [self.tfSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.tfBgView);
        make.height.mas_equalTo(0.5);
        make.centerY.equalTo(self.tfBgView);
    }];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(-1);
        make.right.equalTo(self.view).offset(1);
        make.height.mas_equalTo(RowH);
        make.top.equalTo(self.tfBgView.mas_bottom).offset(PtOn47(15));
    }];
    
    
}
- (UIImageView *)headerImgView{
    if(!_headerImgView){
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"bangdingshoujui_shouji"];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:img];
        _headerImgView = img;
    }
    return _headerImgView;
}
- (UIView *)tfBgView{
    if(!_tfBgView){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = [UIColor whiteColor];
        v.layer.borderColor = SepColor.CGColor;
        v.layer.borderWidth = 0.5;
        [self.view addSubview:v];
        _tfBgView = v;
    }
    return _tfBgView;
}
- (UIView *)tfSep{
    if(!_tfSep){
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.tfBgView addSubview:v];
        _tfSep = v;
    }
    return _tfSep;
}

- (UITextField *)phoneTf{
    if (!_phoneTf) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = NO;
        tf.backgroundColor = [UIColor whiteColor];
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(15);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请输入您的手机号码";
        [self.tfBgView addSubview:tf];
        _phoneTf = tf;
    }
    return _phoneTf;
}
- (UITextField *)authTf{
    if (!_authTf) {
        UITextField *tf = [Utility normalTextField];
        tf.secureTextEntry = NO;
        tf.backgroundColor = [UIColor whiteColor];
        
        tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.font = CPFont(15);
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
        tf.placeholder = @"请输入收到的验证码";
        [self.tfBgView addSubview:tf];
        _authTf = tf;
    }
    return _authTf;
}
- (UIButton *)okBtn{
    if(!_okBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:BgDarkGray] forState:UIControlStateHighlighted];
        
        btn.layer.borderColor = SepColor.CGColor;
        btn.layer.borderWidth = 0.5;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:TextBlackColor forState:UIControlStateNormal];
        [self.view addSubview:btn];
        _okBtn = btn;
    }
    return _okBtn;
}
- (UIButton *)sendBtn{
    if(!_sendBtn){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"发送验证码" forState:UIControlStateNormal];
        btn.titleLabel.font = CPFont(11);
        btn.layer.cornerRadius = SRadius;
        btn.clipsToBounds = YES;
        [btn setBackgroundImage:[UIImage imageWithColor:MainColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:BgDarkGray] forState:UIControlStateDisabled];
        [self.view addSubview:btn];
        _sendBtn = btn;
    }
    return _sendBtn;
}

@end
