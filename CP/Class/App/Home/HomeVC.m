//
//  HomeVC.m
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HomeVC.h"
#import "BettingVC.h"


#import "BuyLotteryListCell.h"

#import "ScrollNoticeView.h"
#import "LotteryModel.h"
#import "CPAlertView.h"

@interface HomeVC ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic, strong) ScrollNoticeView *scrollLabel;
@property(nonatomic, weak) UITableView *tableView;

@property(nonatomic, assign) BOOL hasStatus;
@end

@implementation HomeVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.hidesBottomBarWhenPushed = NO;
    self.hasStatus = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
////tableview背景图片
//    UIImageView *bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 250, 250)];
//    bgImgView.contentMode = UIViewContentModeCenter;
//    bgImgView.image = [UIImage imageNamed:@"lottery_table_bg"];
//    [self.view addSubview:bgImgView];
//
//    [bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(250);
//        make.centerX.equalTo(self.view).multipliedBy(1.3);
////        make.right.equalTo(self.view).offset(-100);
//        make.centerY.equalTo(self.view).multipliedBy(1);
//
//    }];



    [self layout];
    self.title = @"购彩大厅";

    self.scrollLabel.scrollLabel.scrollTitle = @"郑重提示：彩票有风险，投注需谨慎！ ";
    [self.scrollLabel.scrollLabel beginScrolling];

    
    [self getStatesShowHUD:YES];
    [self customRefreshControl];
    
    
}
- (void)addSubview{
    [self scrollLabel];
    [self tableView];
}
- (void)layout{
    [self.scrollLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(PtOn47(30));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollLabel.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-0);
        //        make.edges.equalTo(self.view);
    }];
}

/*
 下拉刷新和上拉加载
 */
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [weakSelf getStatesShowHUD:NO];
    }];
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}


- (void)setHasStatus:(BOOL)hasStatus{
    _hasStatus = hasStatus;
//    self.tableView.allowsSelection = hasStatus;
}

- (void)getStatesShowHUD:(BOOL)show{
    if(show)[self.view startLoading];
    [HttpManager getWithPath:Path_Category param:@{@"m":@"list"}  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        self.scrollLabel.scrollLabel.scrollTitle = data[@"marquee"];
        
        NSMutableArray <LotteryModel *>*all = [LotteryModel mj_objectArrayWithKeyValuesArray:data[@"category"]];
        for (LotteryModel *lottery in [AppHelper helper].lotteryModels) {
             for (LotteryModel *ltty in all) {
                 if([lottery.lottery_id isEqualToString:ltty.lottery_id]){
                     lottery.pstatus = ltty.pstatus;
                 }
             }
        }
        self.hasStatus = YES;
        [self.tableView reloadData];
        
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    } failure:^{
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    }];
}




- (ScrollNoticeView *)scrollLabel{
    if (!_scrollLabel) {
        ScrollNoticeView *scroll = [[ScrollNoticeView alloc]init];
        [scroll setDidClick:^(TXScrollLabelView *scrollLabel, NSString *text, NSInteger index) {

        }];
        [self.view addSubview:scroll];
        _scrollLabel = scroll;
    }
    return _scrollLabel;
}

static NSString *BuyLotteryListCellID = @"BuyLotteryListCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        //        tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        //        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;;

        tableView.separatorColor = SepColor;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[BuyLotteryListCell class] forCellReuseIdentifier:BuyLotteryListCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(IsIp40){
        return PtOn47(70);
    }
    
    return (CGRectGetHeight([UIScreen mainScreen].bounds) - NavHeight - TabBarHeight - TopPadding - BottomPadding - 30) / 8;
    
//    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BuyLotteryListCell *cell = [tableView dequeueReusableCellWithIdentifier:BuyLotteryListCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    LotteryModel *lottery = [AppHelper helper].lotteryModels[indexPath.row];
    cell.titleLabel.text = lottery.title;
    cell.detailLabel.attributedText = lottery.detailAttr;
    cell.iconView.image = [UIImage imageNamed:lottery.img];
    cell.allowbuy = [lottery.pstatus isEqualToString:@"1"];
    cell.selectionStyle = cell.allowbuy ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    cell.accessoryType = cell.allowbuy ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    
    if (indexPath.row == [AppHelper helper].lotteryModels.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc = nil;
    
    
    LotteryModel *lottery = [AppHelper helper].lotteryModels[indexPath.row];
    if([lottery.pstatus isEqualToString: @"0"]){
        [Utility showError:[NSString stringWithFormat:@"%@暂时停售了",lottery.title]];
        return;
    }
    
    
    
    vc = [[BettingVC alloc]init];
    ((BettingVC *)vc).lotteryModel = lottery;
    
    
    
    
    if(![lottery.pstatus isEqualToString:@"1"]){
        LotteryModel *lottery = [AppHelper helper].lotteryModels[indexPath.row];
        [CPAlertView showWithTitle:lottery.title info:[NSString stringWithFormat:@"%@暂时停售了",lottery.title] leftTitle:@"确认" rightTitle:nil config:^(CPAlertView *alertView) {
            //            alertView.showTextField = YES;
        } leftAction:^BOOL(CPAlertView *alertView) {
            return YES;
        } rightAction:^BOOL(CPAlertView *alertView) {
            return YES;
        }];
        return;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
    return;
    
    
}


@end
