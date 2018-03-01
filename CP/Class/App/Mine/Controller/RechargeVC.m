//
//  RechargeVC.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "RechargeVC.h"
#import "CustomerServiceVC.h"
#import "CPPopView.h"
#import <Photos/Photos.h>
@interface RechargeVC ()
@property(nonatomic, weak) UIImageView *bgRedImgView;
@property(nonatomic, weak) UIImageView *titleImgView;
@property(nonatomic, weak) UIImageView *qrCodeImgView;
@property(nonatomic, weak) UIView *qrCodeBorderView;

@property(nonatomic, weak) YYLabel *helpLabel;

@property(nonatomic, strong) UIImage *qrCodeImg;
@end

@implementation RechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    
    [self getImageShowHUD:YES];
}
- (void)addSubview{
    [self bgRedImgView];
    [self titleImgView];
    [self qrCodeBorderView];
    [self qrCodeImgView];
    [self helpLabel];
}
- (void)layout{
    [self.bgRedImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(PtOn47(35));
        make.height.equalTo(self.bgRedImgView.mas_width);
        make.left.equalTo(self.view).offset(PtOn47(20));
    }];
    [self.qrCodeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.bgRedImgView).offset(-PtOn47(35));
        make.centerX.equalTo(self.bgRedImgView);
        make.width.equalTo(self.qrCodeImgView.mas_height);
        make.left.equalTo(self.bgRedImgView).offset(PtOn47(60));
    }];
    [self.qrCodeBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.qrCodeImgView);
        make.width.equalTo(self.qrCodeBorderView.mas_height);
        make.left.equalTo(self.qrCodeImgView).offset(-PtOn47(15));
    }];
    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgRedImgView);
        make.bottom.equalTo(self.qrCodeImgView.mas_top);
        make.left.equalTo(self.bgRedImgView);
        make.right.equalTo(self.bgRedImgView);
    }];
    [self.helpLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgRedImgView.mas_bottom).offset(PtOn47(10));
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(PtOn47(30));
        make.bottom.equalTo(self.view);
    }];
}





- (void)getImageShowHUD:(BOOL)show{
    if(show)[self.view startLoadingWithBg];
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=qrcode&app_id=%@",Path_User,AppID] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        NSDictionary *dt = data[@"data"];
        [self.qrCodeImgView sd_setImageWithURL:[Utility getImgUrl:dt[@"cw_qrcode"]] placeholderImage:nil options:SDWebImageProgressiveDownload completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if(show)[self.view stopLoading];
            self.qrCodeImg = image;
        }];
        
    } failure:^{
        if(show)[self.view stopLoading];
    }];
}



















- (UIView *)qrCodeBorderView{
    if(!_qrCodeBorderView){
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = LightMainColor;
        bg.layer.cornerRadius = PtOn47(10);
        bg.userInteractionEnabled = YES;
        [self.bgRedImgView addSubview:bg];
        _qrCodeBorderView = bg;
    }
    return _qrCodeBorderView;
}

- (UIImageView *)bgRedImgView{
    if (!_bgRedImgView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.userInteractionEnabled = YES;
//        icon.backgroundColor = MainColor;
        //        icon.layer.cornerRadius = 0.f;
        icon.image = [UIImage imageNamed:@"chongzhi_huawen"];
        icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.view addSubview:icon];
        _bgRedImgView = icon;
    }
    return _bgRedImgView;
}
- (UIImageView *)qrCodeImgView{
    if (!_qrCodeImgView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.backgroundColor = [UIColor whiteColor];
        [icon addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap)]];
        icon.userInteractionEnabled = YES;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeScaleAspectFill;
        [self.bgRedImgView addSubview:icon];
        _qrCodeImgView = icon;
    }
    return _qrCodeImgView;
}
- (void)iconTap{
    if(!self.qrCodeImg)
        return;
    
    
    [self becomeFirstResponder];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.qrCodeImgView.frame inView:self.bgRedImgView];
    UIMenuItem *save = [[UIMenuItem alloc] initWithTitle:@"保存二维码"
                                                  action:@selector(saveAction)];
    menu.menuItems = @[save];
    [menu setMenuVisible:YES animated:NO];
    
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

- (UIImageView *)titleImgView{
    if (!_titleImgView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        icon.image = [UIImage imageNamed:@"recharge_title_img"];
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeCenter;
        [self.bgRedImgView addSubview:icon];
        _titleImgView = icon;
    }
    return _titleImgView;
}


- (YYLabel *)helpLabel{
    if(!_helpLabel){
        YYLabel *label = [[YYLabel alloc]init];
        label.preferredMaxLayoutWidth = self.view.width - (PtOn47(20)) * 2;
        label.numberOfLines = 0;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        __weak __typeof(self)weakSelf = self;
        label.attributedText = [self attrStringWithAction:^{
            [weakSelf.navigationController pushViewController:[[CustomerServiceVC alloc]init] animated:weakSelf];
        }];
        label.textContainerInset = UIEdgeInsetsMake(PtOn47(20), PtOn47(20), PtOn47(20), PtOn47(20));
        label.clipsToBounds = NO;
        [self.view addSubview:label];
        _helpLabel = label;
    }
    return _helpLabel;
}
- (NSMutableAttributedString *)attrStringWithAction:(void(^)(void))action{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@"扫码步骤\n"];
    [title setYy_color:MainColor];
    [title setYy_font:CPFont(16)];
    
    
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:@"1. 手动截屏二维码保存至相册； \n2.请在相应钱包中打开扫一扫； \n3.在扫一扫中点击右上角，选择“从相册选取二维码”选取截屏的图片； \n4.输入您欲充值的金额并进行转账。如充值未能及时到账，请及时联系"];
    
    [content setYy_color:TextDarkGrayColor];
    [content setYy_font:CPFont(14)];
    
    
    NSMutableAttributedString *online = [[NSMutableAttributedString alloc]initWithString:@"【在线客服】"];
    [online setYy_color:MainColor];
    [online setYy_font:CPFont(16)];
    
    [online yy_setTextHighlightRange:online.yy_rangeOfAll color:MainColor backgroundColor:BgDarkGray tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        if(action)action();
    }];
    
    
    NSMutableAttributedString *o = [[NSMutableAttributedString alloc]initWithString:@"。"];
    [o setYy_color:TextDarkGrayColor];
    [o setYy_font:CPFont(14)];
    
    [title appendAttributedString:content];
    [title appendAttributedString:online];
    [title appendAttributedString:o];
    [title setYy_firstLineHeadIndent:-PtOn47(12)];
    [title setYy_lineHeightMultiple:PtOn47(1.2)];
    return title;
    
}




- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    // 显示一个系统的paste以及自定义的a，b菜单
    if (action == @selector(saveAction)){
        return YES;
    }else{
        return NO;
    }
}


@end
