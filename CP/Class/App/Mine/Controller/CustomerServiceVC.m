//
//  CustomerServiceVC.m
//  CP
//
//  Created by Apple on 2018/1/27.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CustomerServiceVC.h"
#import "CPPopView.h"
#import <Photos/Photos.h>
@interface CustomerServiceVC ()
@property(nonatomic, weak) UIButton *wechatBtn;
@property(nonatomic, weak) UILabel *wechatLabel;
@property(nonatomic, weak) UIImageView *qrCodeImgView;
@property(nonatomic, weak) UIImageView *qrCodeBgView;
@property(nonatomic, weak) UIButton *phoneIconBtn;
@property(nonatomic, weak) YYLabel  *phoneLabel;

@property(nonatomic, strong) UIImage *qrCodeImg;


@end

@implementation CustomerServiceVC
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.title = @"联系客服";
    [self getImageShowHUD:YES];
}
- (void)addSubview{
    [self wechatBtn];
    [self wechatLabel];
}
- (void)layout{
    [self.wechatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(PtOn47(20));
        make.height.width.mas_equalTo(PtOn47(40));
    }];
    [self.wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wechatBtn.mas_bottom).offset(0);
        make.bottom.equalTo(self.qrCodeBgView.mas_top);
        make.left.right.equalTo(self.view);
    }];
    [self.qrCodeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).multipliedBy(0.96);
        make.width.equalTo(self.view).multipliedBy(0.86);
        make.height.equalTo(self.qrCodeBgView.mas_width);
    }];
    [self.qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.qrCodeBgView);
        make.height.equalTo(self.qrCodeImgView.mas_width);
        make.width.equalTo(self.qrCodeBgView).multipliedBy(0.5);
        make.centerY.equalTo(self.qrCodeBgView).multipliedBy(1.05);
    }];
    [self.phoneIconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.qrCodeBgView.mas_bottom).offset(PtOn47(20));
        make.centerX.equalTo(self.view);
        make.height.width.mas_equalTo(PtOn47(40));
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.phoneIconBtn.mas_bottom).offset(0);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.right.equalTo(self.view);
        
    }];
}











- (void)getImageShowHUD:(BOOL)show{
    if(show)[self.view startLoadingWithBg];
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=qrcode&app_id=%@",Path_User,AppID] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        NSDictionary *dt = data[@"data"];
        [self.qrCodeImgView sd_setImageWithURL:[Utility getImgUrl:dt[@"kf_qrcode"]] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            self.qrCodeImg = image;
            if(show)[self.view stopLoading];
        }];
        
    } failure:^{
        if(show)[self.view stopLoading];
    }];
}


















- (UIButton *)wechatBtn{
    if (!_wechatBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"lianxikefu_weixin"] forState:UIControlStateNormal];
        [btn bk_addEventHandler:^(id sender) {
            [Utility toWechat];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _wechatBtn = btn;
    }
    return _wechatBtn;
}
- (UILabel *)wechatLabel{
    if (!_wechatLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment  = NSTextAlignmentCenter;
        label.text = @"请添加最新客服微信号，\n我们将为您提供7*24小时咨询服务";
        label.numberOfLines = 2;
        label.font = CPFont(16);
        label.textColor = TextDarkGrayColor;
        [self.view addSubview:label];
        _wechatLabel = label;
    }
    return _wechatLabel;
}
- (UIButton *)phoneIconBtn{
    if (!_phoneIconBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"lianxikefu_dianhua"] forState:UIControlStateNormal];
        __weak __typeof(self)weakSelf = self;
        [btn bk_addEventHandler:^(id sender) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf showCallItemOnRect:strongSelf.phoneIconBtn.frame];
        } forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        _phoneIconBtn = btn;
    }
    return _phoneIconBtn;
}
//- (YYLabel *)phoneLabel{
//    
//}
- (void)showCallItemOnRect:(CGRect)rect{
    
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:rect inView:self.view];
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制号码"
                                                  action:@selector(copyAction)];
    UIMenuItem *call = [[UIMenuItem alloc] initWithTitle:@"拨号"
                                                  action:@selector(callAction)];
    menu.menuItems = @[copy,call];
    [menu setMenuVisible:YES animated:NO];
}



- (UIImageView *)qrCodeBgView{
    if(!_qrCodeBgView){
        UIImageView *bg = [[UIImageView alloc]init];
//        bg.backgroundColor = LightMainColor;
//        bg.layer.cornerRadius = PtOn47(10);
        
        bg.userInteractionEnabled = YES;
        bg.image = [UIImage imageNamed:@"lianxikefu_erweimabg"];
        bg.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:bg];
        _qrCodeBgView = bg;
    }
    return _qrCodeBgView;
}

- (UIImageView *)qrCodeImgView{
    if (!_qrCodeImgView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.backgroundColor = [UIColor whiteColor];
        icon.userInteractionEnabled = YES;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [icon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)]];
        [self.qrCodeBgView addSubview:icon];
        _qrCodeImgView = icon;
    }
    return _qrCodeImgView;
}
- (void)iconTap{
    if(!self.qrCodeImg)
        return;
    
    
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.qrCodeImgView.frame inView:self.qrCodeBgView];
    UIMenuItem *save = [[UIMenuItem alloc] initWithTitle:@"保存二维码"
                                                  action:@selector(saveAction)];
    menu.menuItems = @[save];
    [menu setMenuVisible:YES animated:NO];
    
}
- (YYLabel *)phoneLabel{
    if (!_phoneLabel) {
        YYLabel *phone = [[YYLabel alloc]init];
        phone.numberOfLines = 0;
        __weak __typeof(self)weakSelf = self;
        phone.attributedText = [self phoneAttrStr:^{
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            [strongSelf showCallItemOnRect:CGRectMake(0, strongSelf.phoneLabel.midY, strongSelf.view.width, strongSelf.phoneLabel.height/2)];
            
        }];
        [self.view addSubview:phone];
        _phoneLabel = phone;
    }
    return _phoneLabel;
}
#warning 改
- (void)copyAction{
    [UIPasteboard generalPasteboard].string = @"abc";
}
- (void)callAction{
    [Utility callWithPhoneNumber:@"abc"];
}
- (void)saveAction{
    [self.view startLoadingWithCover];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:self.qrCodeImg];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.view stopLoading];
            [CPAlertView showWithTitle:@"保存成功" info:@"立刻打开微信扫一扫？" leftTitle:@"取消" rightTitle:@"打开微信" config:^(CPAlertView *alertView) {
                
            } leftAction:^BOOL(CPAlertView *alertView) {
                return  YES;
            } rightAction:^BOOL(CPAlertView *alertView) {
                [Utility toWechatScan];
                return  YES;
            }];
        });
        
        
        
    }];
}
- (NSMutableAttributedString *)phoneAttrStr:(void(^)(void))action{
    NSMutableAttributedString *part1 = [[NSMutableAttributedString alloc]initWithString:@"或拨打24小时咨询热线：\n"];
    [part1 setYy_font:CPFont(16)];
    [part1 setYy_color:TextDarkGrayColor];
    
    
    
    NSMutableAttributedString *part2 = [[NSMutableAttributedString alloc]initWithString:@"138-1234-5678"];
    [part2 setYy_font:CPFont(30)];
    [part2 setYy_color:MainColor];
    [part2 yy_setTextHighlightRange:part2.yy_rangeOfAll color:MainColor backgroundColor:BgDarkGray tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if(action)action();
    }];
    
    [part1 appendAttributedString:part2];
    part1.yy_alignment = NSTextAlignmentCenter;
    
    return part1;
}


- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    // 显示一个系统的paste以及自定义的a，b菜单
    if (action == @selector(copyAction) ||
        action == @selector(callAction) ||
        action == @selector(saveAction)){
        return YES;
    }else{
        return NO;
    }
}
@end
