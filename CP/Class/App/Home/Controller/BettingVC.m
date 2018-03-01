//
//  BettingVC.m
//  CP
//
//  Created by Apple on 2018/1/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingVC.h"
#import "LotteryHistoryVC.h"
#import "BettingHistoryVC.h"
#import "HowToPlayVC.h"


#import "BettingModel.h"

#import "BettingLeftView.h"
#import "BettingUserInfoHeader.h"
#import "BettingLotteryInfoHeader.h"
#import "BettingFooter.h"
#import "BettingBallColCell.h"

#import "BettingHalfRectCell.h"
#import "BettingOneThirdRectCell.h"
#import "BettingDragonTigerBallColCell.h"
#import "BettingColSectionFooter.h"

#import "BettingColSectionHeader.h"
#import "CPPopView.h"
#import "SwitchLotteryView.h"
#import "TitleButtonView.h"
#define PK10DefaultPrice 2

@interface BettingVC()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic, weak) BettingLeftView *leftView;
@property(nonatomic, weak) BettingUserInfoHeader *userHeader;
@property(nonatomic, weak) BettingLotteryInfoHeader *lotteryHeader;
@property(nonatomic, weak) BettingFooter *lotteryFooter;

/**
 切换彩种view
 */
@property(nonatomic, weak) SwitchLotteryView *switchView;

/**
 导航栏titleView
 */
@property(nonatomic, weak) TitleButtonView *titleView;

@property(nonatomic, weak) UICollectionView *collectionView;
@property(nonatomic, weak) UIView *bgView;

//本地数据
//@property(nonatomic, strong) NSArray *clientData;
//所有赔率信息
@property(nonatomic, strong) NSArray <BettingModel *>*bettingModels;
//顶部彩票信息
@property(nonatomic, strong) NSMutableDictionary *lotteryInfoDict;

@property(nonatomic, strong) NSTimer *s20Timer;
@property(nonatomic, strong) NSTimer *s1Timer;

@property(nonatomic, assign) BOOL allowBuy;


@property(nonatomic, assign) BOOL needAsyncSel;
@end

@implementation BettingVC
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"北京赛车PK拾";
    self.title = self.lotteryModel.title;
    self.needAsyncSel = YES;
    self.titleView.titleLabel.text = self.lotteryModel.title;
    
    [self parseArray:self.clientData];
    [self.collectionView reloadData];
    
    [self getLotteryInfo];
    [self getOdds];
    [self addObz];
    
    [self s1Timer];
    [self s20Timer];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_plus"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    UIEdgeInsets edgeInsets;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        edgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    }else{
        edgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    }
    self.navigationItem.rightBarButtonItem.imageInsets = edgeInsets;
    
    //    .imageInsets = UIEdgeInsetsMake(0, 100, 00, 0);
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_s1Timer invalidate];
    [_s20Timer invalidate];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.s1Timer fire];
    [self.s20Timer fire];
}

- (void)dealloc{
}


#pragma mark - 添加控件
- (void)addSubview{
    self.navigationItem.titleView = self.titleView;
    [self bgView];
    [self userHeader];
    [self lotteryHeader];
    [self leftView];
    [self collectionView];
    [self lotteryFooter];
}
#pragma mark - 约束
- (void)layout{
    
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.userHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.bgView);
        make.height.mas_equalTo(PtOn47(30));
    }];
    [self.lotteryHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userHeader.mas_bottom);
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(PtOn47(30));
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lotteryHeader.mas_bottom);
        make.left.equalTo(self.bgView);
        make.width.mas_equalTo(PtOn47(105));
        make.bottom.equalTo(self.bgView).offset(-PtOn47(50));
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lotteryHeader.mas_bottom);
        make.left.equalTo(self.leftView.mas_right);
        make.right.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView).offset(-PtOn47(50));
        
    }];
    
    [self.lotteryFooter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.bgView);
        make.height.mas_equalTo(PtOn47(50));
    }];
}
#pragma mark - 导航栏下拉菜单
- (void)rightItemClick{
    NSArray *titles = @[@"往期开奖",@"玩法介绍",@"我的投注"];
    __weak __typeof(self)weakSelf = self;
    [CPPopView showWithPosition:CGPointMake(self.view.width - 40, TopPadding+NavHeight+5) images:@[@"nav_drop_wqkj",@"nav_drop_wfjs",@"nav_drop_wdtz"] titles:titles clickAtIndex:^BOOL(NSInteger index) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if([titles[index] isEqualToString:@"往期开奖"]){
            LotteryHistoryVC *vc = [[LotteryHistoryVC alloc]init];
            vc.currentLottery = strongSelf.lotteryModel;
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }else if([titles[index] isEqualToString:@"玩法介绍"]){
            HowToPlayVC *vc = [[HowToPlayVC alloc]init];
            vc.type = [self.lotteryModel.lottery_id integerValue];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }else if([titles[index] isEqualToString:@"我的投注"]){
            BettingHistoryVC *vc = [[BettingHistoryVC alloc]init];
            vc.currentLottery = strongSelf.lotteryModel;
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }
        return YES;
    }];
}

#pragma mark - 计时器
- (NSTimer *)s1Timer{
    if(!_s1Timer){
        _s1Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshUI) userInfo:nil repeats:YES];
    }
    return _s1Timer;
}
- (NSTimer *)s20Timer{
    if(!_s20Timer){
        _s20Timer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(getLotteryInfo) userInfo:nil repeats:YES];
    }
    return _s20Timer;
}
#pragma mark - 刷新时间
- (void)refreshUI{
    if(!self.lotteryInfoDict)return;
    
    NSInteger stoptime = [self.lotteryInfoDict[@"stoptime"] integerValue];
    NSInteger opentime = [self.lotteryInfoDict[@"opentime"] integerValue];
    
    stoptime --;
    opentime --;
    if(stoptime <= 0){
        self.lotteryHeader.state = @"已封盘";
        if(self.allowBuy == YES){
            self.allowBuy = NO;
            [self reset];
        }
    }else{
        self.lotteryHeader.state = [NSString stringWithFormat:@"%02ld:%02ld",stoptime/60, stoptime % 60];
        if(self.allowBuy == NO){
            self.allowBuy = YES;
            [self.collectionView reloadData];
        }
    }
    if(opentime <= 0){
        self.lotteryHeader.countdown = @"开奖中";
    }else{
        self.lotteryHeader.countdown = [NSString stringWithFormat:@"%02ld:%02ld",opentime/60, opentime % 60];
    }
    [self.lotteryInfoDict setObject:[NSString stringWithFormat:@"%ld",(long)stoptime] forKey:@"stoptime"];
    [self.lotteryInfoDict setObject:[NSString stringWithFormat:@"%ld",(long)opentime] forKey:@"opentime"];
}
#pragma mark - 监听键盘
- (void)addObz{
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    
    CGRect endRect = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, MAX(0, CGRectGetMinY(rect) - CGRectGetMinY(endRect)), 0));
    }];
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
    
}
//- (void)keyboardChangeFrame:(NSNotification *)noti{
//    [UIView animateWithDuration:0.25 animations:^{
////self.bgView.frame = CGRectMake(0, 0, self.view.width, self.view.height)
//    }];
//}
#pragma mark - 获取彩票信息
- (void)getLotteryInfo{
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=home&lottery_id=%@",Path_Player,self.lotteryModel.lottery_id ?:@"1"] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        //余额
        NSString *balance =[Utility countNumAndChangeformat: [NSString stringWithFormat:@"%@", @([data[@"mymoney"] floatValue])]];
        self.userHeader.balance = balance;
        //赢利
        NSString *winmoney = [Utility countNumAndChangeformat:[NSString stringWithFormat:@"%@", @([data[@"winmoney"] floatValue])]];
        self.userHeader.winMoney = winmoney;
        //参与期数
        self.userHeader.phase = data[@"partygame"];
        //第几期
        self.lotteryHeader.phase = data[@"expect"];
        //封盘时间和开奖时间
        self.lotteryInfoDict = [NSMutableDictionary dictionaryWithDictionary:data];
    } failure:^{
        
    }];
}
#pragma mark - 投注
- (void)buy{
    
    if(!self.allowBuy){
        [Utility showError:@"目前无法投注"];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{}];
    NSInteger count = 0;
    NSString *bets =@"";
    for (BettingModel *bettingModel in self.bettingModels) {
        for (BettingRightDataModel *rightData in bettingModel.rightDatas) {
            for (BettingItemModel *item in rightData.items) {
                if(item.isSelected){
                    bets = [NSString stringWithFormat:@"%@;%@",bets, item.betname];
                    count ++;
                    //                    [param setObject:@"10" forKey:item.betname];
                }
            }
        }
    }
    if(bets.length > 1){
        bets = [bets substringFromIndex:1];
    }
    
    
    if(bets.length < 1){
        
        [Utility showError:@"请至少选择一个号"];
        return;
    }
    
    NSInteger number = PK10DefaultPrice;
    if(self.lotteryFooter.moneyTf.text && self.lotteryFooter.moneyTf.text.length > 0){
        number = [self.lotteryFooter.moneyTf.text integerValue];
    }
    ;
    NSInteger balance = [self.lotteryInfoDict[@"mymoney"] integerValue];
    NSInteger buyMoney = number * count;
    
    if(buyMoney > balance){
        [Utility showError:@"余额不足，请先充值"];
        return;
    }
    
    [CPAlertView showWithConfig:^(CPAlertView *alertView) {
        alertView.title = @"确认投注";
        
        //        alertView.infoLabel.textAlignment = NSTextAlignmentLeft;
        alertView.leftTitle = @"取消";
        alertView.rightTitle = @"确认投注";
        alertView.rightBtn.titleLabel.font = CPBoldFont(15);
        alertView.info = [NSString stringWithFormat:@"已选择%lu注，共%lu元。\n是否确认投注？",count,number * count];
        [alertView setRightAction:^BOOL(CPAlertView *alertView) {
            
            [param setObject:[NSString stringWithFormat:@"%ld",number] forKey:@"betmoney"];
            [param setObject:bets forKey:@"betkeys"];
            [self.view startLoadingWithCover];
            [HttpManager postWithPath:[NSString stringWithFormat:@"%@?m=bet&lottery=%@",Path_Player,self.lotteryModel.lottery_id ?:@"1"] param:param  showMsg:YES success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
                [self.view stopLoading];
                [self reset];
                [self getLotteryInfo];
                
            } failure:^{
                [self.view stopLoading];
            }];
            
            return YES;
        }];
        [alertView setLeftAction:^BOOL(CPAlertView *alertView) {
            return YES;
        }];
        
    }];
    
    
    
}

#pragma mark - 获取新数据
- (void)getOdds{
    
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=odds&lottery=%@",Path_Player,self.lotteryModel.lottery_id ?:@"1"] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        NSArray *odds = data[@"odds"];
        [self parseArray:odds];
        [self.collectionView reloadData];
    } failure:^{
        
    }];
}
#pragma mark - 重置
- (void)reset{
    for (BettingModel *bettingModel in self.bettingModels) {
        for (BettingRightDataModel *rightData in bettingModel.rightDatas) {
            for (BettingItemModel *item in rightData.items) {
                if(item.isSelected){
                    item.isSelected = NO;
                }
            }
        }
    }
    [self.collectionView reloadData];
    self.lotteryFooter.moneyTf.text = @"";
    [self checkMoney];
}
#pragma mark - 设置已选注数金额
- (void)checkMoney{
    NSInteger count = 0;
    for (BettingModel *bettingModel in self.bettingModels) {
        for (BettingRightDataModel *rightData in bettingModel.rightDatas) {
            for (BettingItemModel *item in rightData.items) {
                if(item.isSelected){
                    count++;
                }
            }
        }
    }
    NSInteger number = PK10DefaultPrice;
    if(self.lotteryFooter.moneyTf.text && self.lotteryFooter.moneyTf.text.length > 0){
        number = [self.lotteryFooter.moneyTf.text integerValue];
    }
    
    self.lotteryFooter.count = [NSString stringWithFormat:@"%ld",(long)count];
    self.lotteryFooter.total = [NSString stringWithFormat:@"%ld",count * number];
}


#pragma mark - 本地JSON
- (NSArray *)clientData{
//    if (!_clientData) {
        NSString *fileName = @"bjscpk10.json";
        NSArray *files = @[@"bjscpk10.json",
                           @"cqssc.json",
                           @"bjscpk10.json",
                           @"luckyfarm.json",
                           @"bjk8.json",
                           @"gd11x5.json",
                           @"gdk10.json",
                           @"jsk3.json"];
        
        fileName = files[ [self.lotteryModel.lottery_id integerValue]-1];
        NSString *filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSError *error;
        NSDictionary *locDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//        _clientData = locDict[@"odds"];
//    }
    return locDict[@"odds"];
}

#pragma mark - 同步选中状态
/**
 同步旧数据的选中状态并将旧数据赋值给新数据
 @param mds 新数据
 */
- (void)syncSelectedItemWithNewModels:(NSArray <BettingModel *>*)mds{
    //尝试保存选中
    @try{
        if(self.bettingModels && mds){
            for (int i = 0; i < self.bettingModels.count; i++) {
                BettingModel *bettingModel = self.bettingModels[i];
                BettingModel *bettingMd = mds[i];
                for (int j = 0; j < bettingModel.rightDatas.count; j++) {
                    BettingRightDataModel *rightData = bettingModel.rightDatas[j];
                    BettingRightDataModel *rightDt = bettingMd.rightDatas[j];
                    for (int k = 0; k < rightData.items.count; k++) {
                        BettingItemModel *item = rightData.items[k];
                        BettingItemModel *it = rightDt.items[k];
                        
                        item.isSelected = it.isSelected;
                        if(item.subItem && it.subItem){
                            item.subItem.isSelected = it.subItem.isSelected;
                        }
                    }
                }
            }
        }
    }
    @catch(NSException *e){
        
    }
    self.bettingModels = mds;
}
#pragma mark - 解析数据
- (void)parseArray:(NSArray *)arr{
    //        数组a（字典a）
    //
    //        遍历json（json字典）{
    //            如果(属于1-5名){
    //                如果(属于第n名){
    //                    数组a【n】 添加 json字典
    //                }
    //            }
    //        }
    LotteryType type = [self.lotteryModel.lottery_id integerValue] ;
    switch (type) {
        case LotteryTypePK10:
            [self parserPK10:arr];
            break;
        case LotteryTypeCQSSC:
            [self parserSsc:arr];
            break;
        case LotteryTypeXYFT:
            [self parserXyft:arr];
            break;
        case LotteryTypeXYNC:
            [self parserXync:arr];
            break;
        case LotteryTypeBJKL8:
            [self parserK8:arr];
            break;
        case LotteryTypeGD11X5:
            [self parser11x5:arr];
            break;
        case LotteryTypeKl10F:
            [self parserK10:arr];
            break;
        case LotteryTypeJSK3:
            [self parserJsk3:arr];
            break;
        default:
            break;
    }
}

#pragma mark - 解析PK10
- (void)parserPK10:(NSArray *)arr{
    BettingModel *bettingModel15 = [[BettingModel alloc]init];
    bettingModel15.leftTitle = @"第1～5名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels15 = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels15 addObject:rightModel];
    }
    bettingModel15.rightDatas = rightDataModels15;
    
    
    BettingModel *bettingModel610 = [[BettingModel alloc]init];
    bettingModel610.leftTitle = @"第6~10名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels610 = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels610 addObject:rightModel];
    }
    bettingModel610.rightDatas = rightDataModels610;
    
    
    BettingModel *bettingModelSmp = [[BettingModel alloc]init];
    bettingModelSmp.leftTitle = @"双面盘";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSmp = [@[] mutableCopy];
    for (int i = 0 ; i < 10; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSmp addObject:rightModel];
    }
    bettingModelSmp.rightDatas = rightDataModelsSmp;
    
    BettingModel *bettingModelGyj = [[BettingModel alloc]init];
    bettingModelGyj.leftTitle = @"冠亚军";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsGyj = [@[] mutableCopy];
    for (int i = 0 ; i < 1; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsGyj addObject:rightModel];
    }
    bettingModelGyj.rightDatas = rightDataModelsGyj;
    
    
    NSArray <BettingModel *>*mds = @[bettingModel15, bettingModel610, bettingModelSmp, bettingModelGyj];
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-5名
        NSArray *validate15 =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])x([1-9]|10)$"];
        if(validate15 && validate15.count == 3){
            NSString *page =  [validate15 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate15 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel15.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel15.rightDatas[idx-1].items = items;
            bettingModel15.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。6-10名
        NSArray *validate610 =  [Utility getSubstringFromString:betname validate:@"^NOx([6-9]|10)x([1-9]|10)$"];
        if(validate610 && validate610.count == 3){
            NSString *page =  [validate610 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate610 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel610.rightDatas[idx - 6].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel610.rightDatas[idx-6].items = items;
            bettingModel610.rightDatas[idx-6].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。双面盘
        NSArray *validateSmp =  [Utility getSubstringFromString:betname validate:@"^NOx([1-9]|10)x([A-Z][a-z]+)$"];
        if(validateSmp && validateSmp.count == 3){
            NSString *page =  [validateSmp objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validateSmp objectAtIndex:2];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。双面盘龙虎
        NSArray *validateSmpLh =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])V([6-9]|10)x([A-Z][a-z]+)$"];
        if(validateSmpLh && validateSmpLh.count == 4){
            NSString *page =  [validateSmpLh objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *longhu = [validateSmpLh objectAtIndex:3];
            if([longhu isEqualToString:@"Long"]){
                longhu = @"龙";
            }else if([longhu isEqualToString:@"Hu"]){
                longhu = @"虎";
            }
            NSString *title = [NSString stringWithFormat:@"%@V%@%@",[validateSmpLh objectAtIndex:1],[validateSmpLh objectAtIndex:2],longhu];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。冠亚军
        NSArray *validateGyj =  [Utility getSubstringFromString:betname validate:@"^NOxGyx(\\w+)$"];
        if(validateGyj && validateGyj.count == 2){
            NSString *title = [validateGyj objectAtIndex:1];
            NSString *type = @"sum";
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelGyj.rightDatas[0].items];
            if([title isEqualToString:@"Da"]){
                title = @"大";
                type = @"gysmp";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
                type = @"gysmp";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
                type = @"gysmp";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
                type = @"gysmp";
            }
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":type,@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelGyj.rightDatas[0].items = items;
            bettingModelGyj.rightDatas[0].title = @"冠亚军和";
            continue;
        }
        
    }
    
    
    for (BettingRightDataModel *rightData in bettingModelSmp.rightDatas) {
        NSMutableArray *items = [NSMutableArray arrayWithArray:rightData.items];
        [items sortUsingComparator:^NSComparisonResult(BettingItemModel  * _Nonnull obj1, BettingItemModel   * _Nonnull obj2) {
            return obj1.title < obj2.title ? NSOrderedAscending : NSOrderedDescending;
        }];
        rightData.items = items;
    }
    
    NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[0].items];
    
    [items sortUsingComparator:^NSComparisonResult(BettingItemModel  * _Nonnull obj1, BettingItemModel   * _Nonnull obj2) {
        return obj1.title < obj2.title ? NSOrderedAscending : NSOrderedDescending;
    }];
    
    bettingModelGyj.rightDatas[0].items = items;
    
    [self syncSelectedItemWithNewModels:mds];
}
- (void)parserSsc:(NSArray *)arr{
    BettingModel *bettingModel15 = [[BettingModel alloc]init];
    bettingModel15.leftTitle = @"第1～5名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels15 = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels15 addObject:rightModel];
    }
    bettingModel15.rightDatas = rightDataModels15;
    
    
    BettingModel *bettingModelSmp = [[BettingModel alloc]init];
    bettingModelSmp.leftTitle = @"双面盘";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSmp = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSmp addObject:rightModel];
    }
    bettingModelSmp.rightDatas = rightDataModelsSmp;
    
    BettingModel *bettingModelQzh = [[BettingModel alloc]init];
    bettingModelQzh.leftTitle = @"前中后";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsQzh = [@[] mutableCopy];
    for (int i = 0 ; i < 3; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsQzh addObject:rightModel];
    }
    bettingModelQzh.rightDatas = rightDataModelsQzh;
    
    
    NSArray <BettingModel *>*mds  = @[bettingModel15, bettingModelSmp, bettingModelQzh];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-5名
        NSArray *validate15 =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])x([0-9]|10)$"];
        if(validate15 && validate15.count == 3){
            NSString *page =  [validate15 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate15 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel15.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel15.rightDatas[idx-1].items = items;
            bettingModel15.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。双面盘
        NSArray *validateSmp =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])x([A-Z][a-z]+)$"];
        if(validateSmp && validateSmp.count == 3){
            NSString *page =  [validateSmp objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validateSmp objectAtIndex:2];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。前中后
        NSArray *validateQzh =  [Utility getSubstringFromString:betname validate:@"^NOx(\\w+)x(\\w+)$"];
        if(validateQzh && validateQzh.count == 3){
            NSString *title = [validateQzh objectAtIndex:2];
            NSString *type = @"qzh";
            
            
            NSString *sectionTitle = [validateQzh objectAtIndex:1];
            
            if([title isEqualToString:@"Bao"]){
                title = @"豹子";
            }else if([title isEqualToString:@"Shun"]){
                title = @"顺子";
            }else if([title isEqualToString:@"Dui"]){
                title = @"对子";
            }else if([title isEqualToString:@"Ban"]){
                title = @"半顺";
            }else if([title isEqualToString:@"Za"]){
                title = @"杂六";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelQzh.rightDatas[0].items];
            if([sectionTitle isEqualToString:@"QS"]){
                bettingModelQzh.rightDatas[0].title = @"前三";
                items = [NSMutableArray arrayWithArray:bettingModelQzh.rightDatas[0].items];
            }else if([sectionTitle isEqualToString:@"ZS"]){
                bettingModelQzh.rightDatas[1].title = @"中三";
                items = [NSMutableArray arrayWithArray:bettingModelQzh.rightDatas[1].items];
            }else if([sectionTitle isEqualToString:@"HS"]){
                bettingModelQzh.rightDatas[2].title = @"后三";
                items = [NSMutableArray arrayWithArray:bettingModelQzh.rightDatas[2].items];
            }
            
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":type,@"odds":odds,@"title":title,@"betname":betname}]];
            
            if([sectionTitle isEqualToString:@"QS"]){
                bettingModelQzh.rightDatas[0].items = items;
            }else if([sectionTitle isEqualToString:@"ZS"]){
                bettingModelQzh.rightDatas[1].items = items;
            }else if([sectionTitle isEqualToString:@"HS"]){
                bettingModelQzh.rightDatas[2].items = items;
            }
            continue;
        }
        
    }
    [self syncSelectedItemWithNewModels:mds];
}
#pragma mark - 解析幸运飞艇
- (void)parserXyft:(NSArray *)arr{
    [self parserPK10:arr];
}
#pragma mark - 解析幸运农场
- (void)parserXync:(NSArray *)arr{
    BettingModel *bettingModel18 = [[BettingModel alloc]init];
    bettingModel18.leftTitle = @"第1～8名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels18 = [@[] mutableCopy];
    for (int i = 0 ; i < 8; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels18 addObject:rightModel];
    }
    bettingModel18.rightDatas = rightDataModels18;
    
    
    BettingModel *bettingModelSmp = [[BettingModel alloc]init];
    bettingModelSmp.leftTitle = @"双面盘";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSmp = [@[] mutableCopy];
    for (int i = 0 ; i < 8; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSmp addObject:rightModel];
    }
    bettingModelSmp.rightDatas = rightDataModelsSmp;
    
    BettingModel *bettingModelLhd = [[BettingModel alloc]init];
    bettingModelLhd.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhd = [@[] mutableCopy];
    for (int i = 0 ; i < 7; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsLhd addObject:rightModel];
    }
    bettingModelLhd.rightDatas = rightDataModelsLhd;
    
    
    
    BettingModel *bettingModelLhdGrouped = [[BettingModel alloc]init];
    bettingModelLhdGrouped.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhdGrouped = [@[] mutableCopy];
    for (int i = 0 ; i < 7; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        rightModel.title = [NSString stringWithFormat:@"第%d球",i+1];
        [rightDataModelsLhdGrouped addObject:rightModel];
    }
    bettingModelLhdGrouped.rightDatas = rightDataModelsLhdGrouped;
    
    
    
    NSArray <BettingModel *>*mds = @[bettingModel18, bettingModelSmp, bettingModelLhdGrouped];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-5名
        NSArray *validate18 =  [Utility getSubstringFromString:betname validate:@"^NOx([1-8])x([0-9]{1,2})$"];
        if(validate18.count){
            
        }
        if(validate18 && validate18.count == 3){
            NSString *page =  [validate18 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate18 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel18.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel18.rightDatas[idx-1].items = items;
            bettingModel18.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。双面盘
        NSArray *validateSmp =  [Utility getSubstringFromString:betname validate:@"^NOx([1-9]|10)x([A-Z][a-z]+)$"];
        if(validateSmp && validateSmp.count == 3){
            NSString *page =  [validateSmp objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validateSmp objectAtIndex:2];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。龙虎斗
        NSArray *validateLhd =  [Utility getSubstringFromString:betname validate:@"^NOx([1-8])V([1-8])x([A-Z][a-z]+)$"];
        if(validateLhd .count > 0){
            
        }
        if(validateLhd && validateLhd.count == 4){
            NSString *page =  [validateLhd objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *longhu = [validateLhd objectAtIndex:3];
            if([longhu isEqualToString:@"Long"]){
                longhu = @"龙";
            }else if([longhu isEqualToString:@"Hu"]){
                longhu = @"虎";
            }
            NSString *title = [NSString stringWithFormat:@"%@V%@%@",[validateLhd objectAtIndex:1],[validateLhd objectAtIndex:2],longhu];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelLhd.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"lhd",@"odds":odds,@"globalTitle":title,@"title":longhu,@"betname":betname}]];
            bettingModelLhd.rightDatas[idx-1].items = items;
            //            bettingModelLhd.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        
    }
    
    
    
    
    //    12,12,13,13,14,14
    //    1212,1313,1414
    //将正常排序的龙虎斗转化为包含子条目的龙虎斗
    int section = 0;
    for (BettingRightDataModel *rightData in bettingModelLhd.rightDatas) {
        //        NSLog(@"section ========================== %d",section);
        for(int i = 0; i < rightData.items.count-1; i++){
            //            NSLog(@"i =============== %d",i);
            for(int j = i+1; j < rightData.items.count; j++){
                BettingItemModel *item1 = rightData.items[i];
                BettingItemModel *item2 = rightData.items[j];
                //                NSLog(@"j === %d",j);
                //                NSLog(@"%@   %@",item1.title,item2.title);
                //
                if([[item1.globalTitle substringToIndex:item1.globalTitle.length-1] isEqualToString:[item2.globalTitle substringToIndex:item2.globalTitle.length-1]]){
                    
                    item1.subItem = item2;
                    item1.globalTitle = [item1.globalTitle substringToIndex:item1.globalTitle.length-1];
                    NSMutableArray *its = [NSMutableArray arrayWithArray: bettingModelLhdGrouped.rightDatas[section].items];
                    [its addObject:item1];
                    bettingModelLhdGrouped.rightDatas[section].items = its;
                    break;
                }
                
                
                
            }
        }
        section++;
    }
    
    [self syncSelectedItemWithNewModels:mds];
}
#pragma mark - 解析快8
- (void)parserK8:(NSArray *)arr{
    BettingModel *bettingModel180 = [[BettingModel alloc]init];
    bettingModel180.leftTitle = @"任选";
    NSMutableArray <BettingRightDataModel *>*rightDataModels180 = [@[] mutableCopy];
    for (int i = 0 ; i < 1; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels180 addObject:rightModel];
    }
    bettingModel180.rightDatas = rightDataModels180;
    
    
    BettingModel *bettingModelZh = [[BettingModel alloc]init];
    bettingModelZh.leftTitle = @"整和";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsZh = [@[] mutableCopy];
    for (int i = 0 ; i < 4; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsZh addObject:rightModel];
    }
    bettingModelZh.rightDatas = rightDataModelsZh;
    
    
    NSArray <BettingModel *>*mds = @[bettingModel180, bettingModelZh];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-80名
        NSArray *validate180 =  [Utility getSubstringFromString:betname validate:@"^NOxRXx([0-9]{1,2})$"];
        if(validate180 && validate180.count == 2){
            //            NSString *page =  [validate180 objectAtIndex:1];
            //            NSInteger idx = [page integerValue];
            NSString *title = [validate180 objectAtIndex:1];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel180.rightDatas[0].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel180.rightDatas[0].items = items;
            bettingModel180.rightDatas[0].title = [NSString stringWithFormat:@"任选"];
            continue;
        }
        //是否匹配 总和
        NSArray *validateZh =  [Utility getSubstringFromString:betname validate:@"^NOxSUMx(\\w+)$"];
        if(validateZh.count > 0){
            
        }
        if(validateZh && validateZh.count == 2){
            NSString *title = [validateZh objectAtIndex:1];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"810"]){
                title = @"810";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            
            
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelZh.rightDatas[0].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"zh",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelZh.rightDatas[0].items = items;
            bettingModelZh.rightDatas[0].title = [NSString stringWithFormat:@"总和"];
            continue;
        }
        
        
        //是否匹配。五行
        NSArray *validateWx =  [Utility getSubstringFromString:betname validate:@"^NOxWXx([A-Z][a-z]+)$"];
        if(validateWx.count > 0){
            
        }
        if(validateWx && validateWx.count == 2){
            NSString *title = [validateWx objectAtIndex:1];
            if([title isEqualToString:@"Jin"]){
                title = @"金";
            }else if([title isEqualToString:@"Mu"]){
                title = @"木";
            }else if([title isEqualToString:@"Shui"]){
                title = @"水";
            }else if([title isEqualToString:@"Huo"]){
                title = @"火";
            }else if([title isEqualToString:@"Tu"]){
                title = @"土";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelZh.rightDatas[1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"wx",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelZh.rightDatas[1].items = items;
            bettingModelZh.rightDatas[1].title = [NSString stringWithFormat:@"五行"];
            continue;
        }
        //是否匹配。前后
        NSArray *validateQH =  [Utility getSubstringFromString:betname validate:@"^NOxQHx([A-Z][a-z]+)$"];
        if(validateQH.count > 0){
            
        }
        if(validateQH && validateQH.count == 2){
            NSString *title = [validateQH objectAtIndex:1];
            if([title isEqualToString:@"Qian"]){
                title = @"前";
            }else if([title isEqualToString:@"Hou"]){
                title = @"后";
            }else if([title isEqualToString:@"Equal"]){
                title = @"同";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelZh.rightDatas[2].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"qh",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelZh.rightDatas[2].items = items;
            bettingModelZh.rightDatas[2].title = [NSString stringWithFormat:@"前后"];
            continue;
        }
        
        //是否匹配。单双
        NSArray *validateQO =  [Utility getSubstringFromString:betname validate:@"^NOxQOx([A-Z][a-z]+)$"];
        if(validateQO.count > 0){
            
        }
        if(validateQO && validateQO.count == 2){
            NSString *wx = [validateQO objectAtIndex:1];
            if([wx isEqualToString:@"Dan"]){
                wx = @"单";
            }else if([wx isEqualToString:@"Shuang"]){
                wx = @"双";
            }else if([wx isEqualToString:@"Equal"]){
                wx = @"同";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelZh.rightDatas[3].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"qo",@"odds":odds,@"title":wx,@"betname":betname}]];
            bettingModelZh.rightDatas[3].items = items;
            bettingModelZh.rightDatas[3].title = [NSString stringWithFormat:@"单双"];
            continue;
        }
        
        
        
        
    }
    
    
    
    
    
    
    [self syncSelectedItemWithNewModels:mds];
}
#pragma mark - 解析11选5
- (void)parser11x5:(NSArray *)arr{
    BettingModel *bettingModel15 = [[BettingModel alloc]init];
    bettingModel15.leftTitle = @"第1～5名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels15 = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels15 addObject:rightModel];
    }
    bettingModel15.rightDatas = rightDataModels15;
    
    
    
    BettingModel *bettingModelSmp = [[BettingModel alloc]init];
    bettingModelSmp.leftTitle = @"双面盘";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSmp = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSmp addObject:rightModel];
    }
    bettingModelSmp.rightDatas = rightDataModelsSmp;
    
    BettingModel *bettingModelLhd = [[BettingModel alloc]init];
    bettingModelLhd.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhd = [@[] mutableCopy];
    for (int i = 0 ; i < 4; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsLhd addObject:rightModel];
    }
    bettingModelLhd.rightDatas = rightDataModelsLhd;
    
    
    
    
    BettingModel *bettingModelLhdGrouped = [[BettingModel alloc]init];
    bettingModelLhdGrouped.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhdGrouped = [@[] mutableCopy];
    for (int i = 0 ; i < 4; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        rightModel.title = [NSString stringWithFormat:@"第%d球",i+1];
        [rightDataModelsLhdGrouped addObject:rightModel];
    }
    bettingModelLhdGrouped.rightDatas = rightDataModelsLhdGrouped;
    
    
    
    NSArray <BettingModel *>*mds = @[bettingModel15, bettingModelSmp, bettingModelLhdGrouped];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-5名
        NSArray *validate15 =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])x([0-9]{1,2})$"];
        if(validate15 && validate15.count == 3){
            NSString *page =  [validate15 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate15 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel15.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel15.rightDatas[idx-1].items = items;
            bettingModel15.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。双面盘
        NSArray *validateSmp =  [Utility getSubstringFromString:betname validate:@"^NOx([0-9]{1,2})x([A-Z][a-z]+)$"];
        if(validateSmp && validateSmp.count == 3){
            NSString *page =  [validateSmp objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validateSmp objectAtIndex:2];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。双面盘龙虎
        NSArray *validateSmpLh =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])V([6-9]|10)x([A-Z][a-z]+)$"];
        if(validateSmpLh && validateSmpLh.count == 4){
            NSString *page =  [validateSmpLh objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *longhu = [validateSmpLh objectAtIndex:3];
            if([longhu isEqualToString:@"Long"]){
                longhu = @"龙";
            }else if([longhu isEqualToString:@"Hu"]){
                longhu = @"虎";
            }
            NSString *title = [NSString stringWithFormat:@"%@V%@%@",[validateSmpLh objectAtIndex:1],[validateSmpLh objectAtIndex:2],longhu];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。龙虎斗
        NSArray *validateLhd =  [Utility getSubstringFromString:betname validate:@"^NOx([1-5])V([1-5])x([A-Z][a-z]+)$"];
        if(validateLhd .count > 0){
            
        }
        if(validateLhd && validateLhd.count == 4){
            NSString *page =  [validateLhd objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *longhu = [validateLhd objectAtIndex:3];
            if([longhu isEqualToString:@"Long"]){
                longhu = @"龙";
            }else if([longhu isEqualToString:@"Hu"]){
                longhu = @"虎";
            }
            NSString *title = [NSString stringWithFormat:@"%@V%@%@",[validateLhd objectAtIndex:1],[validateLhd objectAtIndex:2],longhu];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelLhd.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"lhd",@"odds":odds,@"globalTitle":title,@"title":longhu,@"betname":betname}]];
            bettingModelLhd.rightDatas[idx-1].items = items;
            //            bettingModelLhd.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        
        
    }
    
    //    12,12,13,13,14,14
    //    1212,1313,1414
    //将正常排序的龙虎斗转化为包含子条目的龙虎斗
    int section = 0;
    for (BettingRightDataModel *rightData in bettingModelLhd.rightDatas) {
        //        NSLog(@"section ========================== %d",section);
        for(int i = 0; i < rightData.items.count-1; i++){
            //            NSLog(@"i =============== %d",i);
            for(int j = i+1; j < rightData.items.count; j++){
                BettingItemModel *item1 = rightData.items[i];
                BettingItemModel *item2 = rightData.items[j];
                //                NSLog(@"j === %d",j);
                //                NSLog(@"%@   %@",item1.title,item2.title);
                //
                if([[item1.globalTitle substringToIndex:item1.globalTitle.length-1] isEqualToString:[item2.globalTitle substringToIndex:item2.globalTitle.length-1]]){
                    
                    item1.subItem = item2;
                    item1.globalTitle = [item1.globalTitle substringToIndex:item1.globalTitle.length-1];
                    NSMutableArray *its = [NSMutableArray arrayWithArray: bettingModelLhdGrouped.rightDatas[section].items];
                    [its addObject:item1];
                    bettingModelLhdGrouped.rightDatas[section].items = its;
                    break;
                }
                
                
                
            }
        }
        section++;
    }
    
    
    
    
    [self syncSelectedItemWithNewModels:mds];
}
#pragma mark - 解析快10
- (void)parserK10:(NSArray *)arr{
    BettingModel *bettingModel18 = [[BettingModel alloc]init];
    bettingModel18.leftTitle = @"第1～8名";
    NSMutableArray <BettingRightDataModel *>*rightDataModels18 = [@[] mutableCopy];
    for (int i = 0 ; i < 8; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModels18 addObject:rightModel];
    }
    bettingModel18.rightDatas = rightDataModels18;
    
    
    BettingModel *bettingModelSmp = [[BettingModel alloc]init];
    bettingModelSmp.leftTitle = @"双面盘";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSmp = [@[] mutableCopy];
    for (int i = 0 ; i < 8; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSmp addObject:rightModel];
    }
    bettingModelSmp.rightDatas = rightDataModelsSmp;
    
    BettingModel *bettingModelLhd = [[BettingModel alloc]init];
    bettingModelLhd.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhd = [@[] mutableCopy];
    for (int i = 0 ; i < 7; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsLhd addObject:rightModel];
    }
    bettingModelLhd.rightDatas = rightDataModelsLhd;
    
    
    
    BettingModel *bettingModelLhdGrouped = [[BettingModel alloc]init];
    bettingModelLhdGrouped.leftTitle = @"龙虎斗";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsLhdGrouped = [@[] mutableCopy];
    for (int i = 0 ; i < 7; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        rightModel.title = [NSString stringWithFormat:@"第%d球",i+1];
        [rightDataModelsLhdGrouped addObject:rightModel];
    }
    bettingModelLhdGrouped.rightDatas = rightDataModelsLhdGrouped;
    
    
    
    NSArray <BettingModel *>*mds = @[bettingModel18, bettingModelSmp, bettingModelLhdGrouped];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。1-5名
        NSArray *validate18 =  [Utility getSubstringFromString:betname validate:@"^NOx([1-8])x([0-9]{1,2})$"];
        if(validate18.count){
            
        }
        if(validate18 && validate18.count == 3){
            NSString *page =  [validate18 objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validate18 objectAtIndex:2];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModel18.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"ball",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModel18.rightDatas[idx-1].items = items;
            bettingModel18.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        //是否匹配。双面盘
        NSArray *validateSmp =  [Utility getSubstringFromString:betname validate:@"^NOx([1-9]|10)x([A-Z][a-z]+)$"];
        if(validateSmp && validateSmp.count == 3){
            NSString *page =  [validateSmp objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *title = [validateSmp objectAtIndex:2];
            if([title isEqualToString:@"Da"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao"]){
                title = @"小";
            }else if([title isEqualToString:@"Dan"]){
                title = @"单";
            }else if([title isEqualToString:@"Shuang"]){
                title = @"双";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelSmp.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelSmp.rightDatas[idx-1].items = items;
            bettingModelSmp.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        //是否匹配。龙虎斗
        NSArray *validateLhd =  [Utility getSubstringFromString:betname validate:@"^NOx([1-8])V([1-8])x([A-Z][a-z]+)$"];
        if(validateLhd .count > 0){
            
        }
        if(validateLhd && validateLhd.count == 4){
            NSString *page =  [validateLhd objectAtIndex:1];
            NSInteger idx = [page integerValue];
            NSString *longhu = [validateLhd objectAtIndex:3];
            if([longhu isEqualToString:@"Long"]){
                longhu = @"龙";
            }else if([longhu isEqualToString:@"Hu"]){
                longhu = @"虎";
            }
            NSString *title = [NSString stringWithFormat:@"%@V%@%@",[validateLhd objectAtIndex:1],[validateLhd objectAtIndex:2],longhu];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelLhd.rightDatas[idx - 1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"lhd",@"odds":odds,@"globalTitle":title,@"title":longhu,@"betname":betname}]];
            bettingModelLhd.rightDatas[idx-1].items = items;
            //            bettingModelLhd.rightDatas[idx-1].title = [NSString stringWithFormat:@"第%@名",page];
            continue;
        }
        
        
    }

    
    //    12,12,13,13,14,14
    //    1212,1313,1414
    //将正常排序的龙虎斗转化为包含子条目的龙虎斗
    int section = 0;
    for (BettingRightDataModel *rightData in bettingModelLhd.rightDatas) {
        //        NSLog(@"section ========================== %d",section);
        for(int i = 0; i < rightData.items.count-1; i++){
            //            NSLog(@"i =============== %d",i);
            for(int j = i+1; j < rightData.items.count; j++){
                BettingItemModel *item1 = rightData.items[i];
                BettingItemModel *item2 = rightData.items[j];
                //                NSLog(@"j === %d",j);
                //                NSLog(@"%@   %@",item1.title,item2.title);
                //
                if([[item1.globalTitle substringToIndex:item1.globalTitle.length-1] isEqualToString:[item2.globalTitle substringToIndex:item2.globalTitle.length-1]]){
                    
                    item1.subItem = item2;
                    item1.globalTitle = [item1.globalTitle substringToIndex:item1.globalTitle.length-1];
                    NSMutableArray *its = [NSMutableArray arrayWithArray: bettingModelLhdGrouped.rightDatas[section].items];
                    [its addObject:item1];
                    bettingModelLhdGrouped.rightDatas[section].items = its;
                    break;
                }
                
                
                
            }
        }
        section++;
    }
    
    [self syncSelectedItemWithNewModels:mds];
}
#pragma mark - 解析快3
- (void)parserJsk3:(NSArray *)arr{
    
    BettingModel *bettingModelDxsb = [[BettingModel alloc]init];
    bettingModelDxsb.leftTitle = @"大小骰宝";
    NSMutableArray <BettingRightDataModel *>*rightDataModelsSxsb = [@[] mutableCopy];
    for (int i = 0 ; i < 5; i++) {
        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
        rightModel.items = [@[] mutableCopy];
        [rightDataModelsSxsb addObject:rightModel];
    }
    bettingModelDxsb.rightDatas = rightDataModelsSxsb;
    
    
    //    BettingModel *bettingModelYxxsb = [[BettingModel alloc]init];
    //    bettingModelYxxsb.leftTitle = @"鱼虾蟹骰宝";
    //    NSMutableArray <BettingRightDataModel *>*rightDataModels610 = [@[] mutableCopy];
    //    for (int i = 0 ; i < 1; i++) {
    //        BettingRightDataModel *rightModel = [[BettingRightDataModel alloc]init];
    //        rightModel.items = [@[] mutableCopy];
    //        [rightDataModels610 addObject:rightModel];
    //    }
    //    bettingModelYxxsb.rightDatas = rightDataModels610;
    
    
    
    
    
     NSArray <BettingModel *>*mds = @[bettingModelDxsb];
    
    
    
    
    for (NSDictionary *dic in arr) {
        /*dic:{"betname": "NOx1x1",
         "odds": "9.900",
         "petname": "第1名(1)"},*/
        NSString *betname = dic[@"betname"];
        NSString *odds = dic[@"odds"];
//        NSString *petname = dic[@"petname"];
        
        //是否匹配。三军
        NSArray *validateSJ =  [Utility getSubstringFromString:betname validate:@"^NOxSJx([1-9]|10)$"];
        if(validateSJ && validateSJ.count == 2){
            NSString *title = [validateSJ objectAtIndex:1];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelDxsb.rightDatas[0].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelDxsb.rightDatas[0].items = items;
            bettingModelDxsb.rightDatas[0].title = [NSString stringWithFormat:@"三军"];
            continue;
        }
        
        
        //是否匹配。围骰
        NSArray *validateWT =  [Utility getSubstringFromString:betname validate:@"^NOxWTx(\\w+)$"];
        if(validateWT && validateWT.count == 2){
            NSString *title = [NSString stringWithFormat:@"%@, %@, %@",[validateWT objectAtIndex:1],[validateWT objectAtIndex:1],[validateWT objectAtIndex:1]];
            if([title isEqualToString:@"Quan, Quan, Quan"]){
                title = @"全";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelDxsb.rightDatas[1].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelDxsb.rightDatas[1].items = items;
            bettingModelDxsb.rightDatas[1].title = [NSString stringWithFormat:@"围骰"];
            continue;
        }
        
        //是否匹配。点数
        NSArray *validateSUM =  [Utility getSubstringFromString:betname validate:@"^NOxSUMx(\\w+)$"];
        if(validateSUM && validateSUM.count == 2){
            NSString *title = [NSString stringWithFormat:@"%@点",[validateSUM objectAtIndex:1]];
            if([title isEqualToString:@"Da点"]){
                title = @"大";
            }else if([title isEqualToString:@"Xiao点"]){
                title = @"小";
            }
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelDxsb.rightDatas[2].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelDxsb.rightDatas[2].items = items;
            bettingModelDxsb.rightDatas[2].title = [NSString stringWithFormat:@"点数"];
            continue;
        }
        
        //是否匹配。长牌
        NSArray *validateLG =  [Utility getSubstringFromString:betname validate:@"^NOxLGx([0-9])u([0-9])$"];
        if(validateLG.count > 0){
            
        }
        if(validateLG && validateLG.count == 3){
            NSString *title = [NSString stringWithFormat:@"%@ & %@",[validateLG objectAtIndex:1],[validateLG objectAtIndex:2]] ;
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelDxsb.rightDatas[3].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelDxsb.rightDatas[3].items = items;
            bettingModelDxsb.rightDatas[3].title = [NSString stringWithFormat:@"长牌"];
            continue;
        }
        //是否匹配。短牌
        NSArray *validateSG =  [Utility getSubstringFromString:betname validate:@"^NOxSGx([0-9])u([0-9])$"];
        if(validateSG && validateSG.count == 3){
            NSString *title = [NSString stringWithFormat:@"%@ & %@",[validateSG objectAtIndex:1],[validateSG objectAtIndex:2]];
            NSMutableArray *items = [NSMutableArray arrayWithArray:bettingModelDxsb.rightDatas[4].items];
            [items addObject:[BettingItemModel mj_objectWithKeyValues:@{@"type":@"smp",@"odds":odds,@"title":title,@"betname":betname}]];
            bettingModelDxsb.rightDatas[4].items = items;
            bettingModelDxsb.rightDatas[4].title = [NSString stringWithFormat:@"短牌"];
            continue;
        }
    }
    
    [self syncSelectedItemWithNewModels:mds];
}




#pragma mark - 控件
- (UIView *)bgView{
    if(!_bgView){
        UIView *bg = [[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:bg];
        _bgView = bg;
    }
    return _bgView;
}
- (BettingLeftView *)leftView{
    if (!_leftView) {
        BettingLeftView *left = [[BettingLeftView alloc]init];
        //        left.titles = @[@"1~5号", @"6~10号",@"双面盘",@"冠亚军"];
        __weak __typeof(self)weakSelf = self;
        [left setNumbersOfRow:^NSInteger(BettingLeftView *view) {
            return weakSelf.bettingModels.count;
        }];
        [left setTitlesAtIndex:^NSString *(BettingLeftView *view, NSInteger index) {
            return weakSelf.bettingModels[index].leftTitle;
        }];
        [left setDidSelect:^(BettingLeftView *view, NSInteger index) {
            [weakSelf.collectionView reloadData];
        }];
        
        [self.bgView addSubview:left];
        _leftView = left;
    }
    return _leftView;
}
- (BettingLotteryInfoHeader *)lotteryHeader{
    if (!_lotteryHeader) {
        BettingLotteryInfoHeader *header = [[BettingLotteryInfoHeader alloc]init];
        [self.bgView addSubview:header];
        _lotteryHeader = header;
    }
    return _lotteryHeader;
}
- (BettingUserInfoHeader *)userHeader{
    if (!_userHeader) {
        
        BettingUserInfoHeader *header = [[BettingUserInfoHeader alloc]init];
        [self.bgView addSubview:header];
        _userHeader = header;
    }
    return _userHeader;
}
- (BettingFooter *)lotteryFooter{
    if (!_lotteryFooter) {
        BettingFooter *footer = [[BettingFooter alloc]init];
        __weak __typeof(self)weakSelf = self;
        [footer.buyBtn bk_addEventHandler:^(id sender) {
            [weakSelf buy];
        } forControlEvents:UIControlEventTouchUpInside];
        [footer.resetBtn bk_addEventHandler:^(id sender) {
            [weakSelf reset];
        } forControlEvents:UIControlEventTouchUpInside];
        [footer.moneyTf bk_addEventHandler:^(UITextField *textField) {
            if(textField.text.length > 0){
                if([textField.text integerValue] > 100000){
                    textField.text = @"100000";
                }
            }
            [weakSelf checkMoney];
        } forControlEvents:UIControlEventEditingChanged];
        
        [self.bgView addSubview:footer];
        _lotteryFooter = footer;
    }
    return _lotteryFooter;
}




- (TitleButtonView *)titleView{
    if(!_titleView){
        TitleButtonView *titleView = [[TitleButtonView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)];
        //        titleView.backgroundColor = [UIColor redColor];
        titleView.alignment = TitleButtonViewAlignmentTitleCenter;
        titleView.titleLabel.text = @"全部彩种";
        
        titleView.intrinsicContentSize = CGSizeMake(140, 40);
        __weak __typeof(self)weakSelf = self;
        __weak __typeof(titleView)weakView = titleView;
        
        [titleView bk_addEventHandler:^(id sender) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            
            
            
            if(!strongSelf.switchView.isShow){
                [strongSelf.switchView show];
                weakView.selected = YES;
            }else{
                [strongSelf.switchView hide];
            }
            
        } forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = titleView;
        _titleView = titleView;
        
    }
    return _titleView;
}

- (SwitchLotteryView *)switchView{
    if(!_switchView){
        SwitchLotteryView *sw = [[SwitchLotteryView alloc]init];
        
        sw.lotteryModels = [AppHelper helper].lotteryModels;
        
        __weak __typeof(self)weakSelf = self;
#pragma mark - 切换彩种
        [sw setDidSel:^(SwitchLotteryView *switchView, NSInteger index) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.lotteryModel = [AppHelper helper].lotteryModels[index];
            strongSelf.titleView.titleLabel.text = strongSelf.lotteryModel.title;
            strongSelf.needAsyncSel = NO;
            [strongSelf parseArray:strongSelf.clientData];
            [strongSelf.leftView reloadData];
            [strongSelf.collectionView reloadData];
//            [strongSelf getOdds];
//            [strongSelf.betList removeAllObjects];
//            [strongSelf.tableView reloadData];
//            [strongSelf getHistoryWithID:strongSelf.lotteryModels[strongSelf.switchView.selectedIndex].lottery_id isShowHUD:YES];
        }];
        [sw setDidHide:^{
            weakSelf.titleView.selected = NO;
        }];
        
        int index = 0;
        if(self.lotteryModel){
            for (LotteryModel *model in [AppHelper helper].lotteryModels) {
                if([model.lottery_id isEqualToString:self.lotteryModel.lottery_id]){
                    break;
                }
                index++;
            }
            sw.selectedIndex = index;
        }
        [self.view addSubview:sw];
        _switchView = sw;
    }
    return _switchView;
}



static NSString *BettingBallColCellID = @"BettingBallColCell";
static NSString *BettingHalfRectCellID = @"BettingHalfRectCell";
static NSString *BettingOneThirdRectCellID = @"BettingOneThirdRectCell";
static NSString *BettingDragonTigerBallColCellID = @"BettingDragonTigerBallColCell";
static NSString *BettingColSectionHeaderID = @"BettingColSectionHeader";
static NSString *BettingColSectionFooterID = @"BettingColSectionFooter";
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.contentInset = UIEdgeInsetsMake(NormalMargin/2, NormalMargin/2, NormalMargin/2, NormalMargin/2);
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.alwaysBounceVertical = YES;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[BettingBallColCell class] forCellWithReuseIdentifier:BettingBallColCellID];
        [collectionView registerClass:[BettingHalfRectCell class] forCellWithReuseIdentifier:BettingHalfRectCellID];
        [collectionView registerClass:[BettingOneThirdRectCell class] forCellWithReuseIdentifier:BettingOneThirdRectCellID];
        [collectionView registerClass:[BettingDragonTigerBallColCell class] forCellWithReuseIdentifier:BettingDragonTigerBallColCellID];
        
        [collectionView registerClass:[BettingColSectionFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:BettingColSectionFooterID];
        [collectionView registerClass:[BettingColSectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:BettingColSectionHeaderID];
        [self.bgView addSubview:collectionView];
        
        _collectionView = collectionView;
    }
    return _collectionView;
}
#pragma mark - CollectionView 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.bettingModels[self.leftView.selectedIndex].rightDatas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bettingModels[self.leftView.selectedIndex].rightDatas[section].items.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(collectionView.width, PtOn47(50));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(collectionView.width, 0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        BettingColSectionHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:BettingColSectionHeaderID forIndexPath:indexPath];
        header.titleLabel.text =  self.bettingModels[self.leftView.selectedIndex].rightDatas[indexPath.section].title;
        return header;
    }else{
        BettingColSectionFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:BettingColSectionFooterID forIndexPath:indexPath];
        footer.backgroundColor = MainBgGray;
        
        return footer;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    BettingItemModel *bettingItem = self.bettingModels[self.leftView.selectedIndex].rightDatas[indexPath.section].items[indexPath.row];
    
    CGFloat padding = 0;
    if([bettingItem.type isEqualToString:@"ball"]){
        CGFloat w = (collectionView.width - NormalMargin - padding * 5 - 1) / 4;
        return CGSizeMake(w, w * 1);
    }else if([bettingItem.type isEqualToString:@"smp"]){
        CGFloat w = (collectionView.width - NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w * 0.5);
    }else if([bettingItem.type isEqualToString:@"gysmp"]){
        CGFloat w = (collectionView.width -NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w * 0.5);
    }else if([bettingItem.type isEqualToString:@"sum"]){
        CGFloat w = (collectionView.width -NormalMargin - padding * 4 - 1) / 3;
        return CGSizeMake(w, w * 0.6);
    }else if([bettingItem.type isEqualToString:@"qzh"]){
        CGFloat w = (collectionView.width -NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w * 0.5);
    }else if([bettingItem.type isEqualToString:@"lhd"]){
        CGFloat w = (collectionView.width - NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w );
    }else if([bettingItem.type isEqualToString:@"zh"]){
        CGFloat w = (collectionView.width - NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w * 0.5);
    }else if([bettingItem.type isEqualToString:@"wx"]){
        CGFloat w = (collectionView.width - NormalMargin - padding * 3 - 1) / 2;
        return CGSizeMake(w, w * 0.5);
    }else if([bettingItem.type isEqualToString:@"qh"]){
        CGFloat w = (collectionView.width -NormalMargin - padding * 4 - 1) / 3;
        return CGSizeMake(w, w * 0.6);
    }else if([bettingItem.type isEqualToString:@"qo"]){
        CGFloat w = (collectionView.width -NormalMargin - padding * 4 - 1) / 3;
        return CGSizeMake(w, w * 0.6);
    }
    return CGSizeMake(100, 100);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BettingItemModel *bettingItem = self.bettingModels[self.leftView.selectedIndex].rightDatas[indexPath.section].items[indexPath.row];
    
    BettingBaseColCell *cell = nil;
    
    
    if([bettingItem.type isEqualToString:@"ball"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingBallColCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"smp"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingHalfRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"gysmp"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingHalfRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"sum"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingOneThirdRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"qzh"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingHalfRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"zh"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingHalfRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"wx"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingHalfRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"qh"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingOneThirdRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"qo"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingOneThirdRectCellID forIndexPath:indexPath];
    }else if([bettingItem.type isEqualToString:@"lhd"]){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:BettingDragonTigerBallColCellID forIndexPath:indexPath];
        
        BettingDragonTigerBallColCell *dtCell = (BettingDragonTigerBallColCell *)cell;
        
        dtCell.verLine2.hidden = indexPath.row % 2;
        dtCell.verLine1.hidden = YES;
        dtCell.horLine1.hidden = indexPath.row > 1;
        
        //虎在subItem中
        dtCell.titleLabel.text = bettingItem.globalTitle;
        dtCell.dragonLabel.text = bettingItem.title;
        dtCell.tigerLabel.text = bettingItem.subItem.title;
        dtCell.dragonOddsLabel.text = [NSString stringWithFormat:@"%@",@([bettingItem.odds floatValue])];
        dtCell.tigerOddsLabel.text = [NSString stringWithFormat:@"%@",@([bettingItem.subItem.odds floatValue])];
        dtCell.isDragonSel  = bettingItem.isSelected;
        dtCell.isTigerSel  = bettingItem.subItem.isSelected;
        __weak __typeof(self)weakSelf = self;
        [dtCell setTigerTap:^(BettingDragonTigerBallColCell *aCell) {
            if(!self.allowBuy)return;
            aCell.isTigerSel = !aCell.isTigerSel;
            bettingItem.subItem.isSelected = !bettingItem.subItem.isSelected;
            [weakSelf checkMoney];
        }];
        [dtCell setDragonTap:^(BettingDragonTigerBallColCell *aCell) {
            if(!self.allowBuy)return;
            aCell.isDragonSel = !aCell.isDragonSel;
            bettingItem.isSelected = !bettingItem.isSelected;
            [weakSelf checkMoney];
        }];
        
        return cell;
    }
    
    
    cell.titleLabel.text = bettingItem.title;
    cell.oddsLabel.text = self.allowBuy ? [NSString stringWithFormat:@"%@",@([bettingItem.odds floatValue])] : @"--";
    cell.isSel = bettingItem.isSelected;
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.allowBuy)return;
    
    
    BettingItemModel *bettingItem = self.bettingModels[self.leftView.selectedIndex].rightDatas[indexPath.section].items[indexPath.row];
    
    if([bettingItem.type isEqualToString:@"lhd"]){
        return ;
    }
    
    
    bettingItem.isSelected = !bettingItem.isSelected;
    
    BettingBaseColCell *cell = (BettingBaseColCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.isSel = !cell.isSel;
    
    
    
    
    [self checkMoney];
    
    
    //    [collectionView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
    //    [collectionView reloadData];
    
}


@end

