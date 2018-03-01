//
//  LotteryVC.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LotteryVC.h"
#import "LotteryHistoryVC.h"

#import "LotteryListCell.h"

#import "LotteryModel.h"

@interface LotteryVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;


@end

@implementation LotteryVC

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
    self.view.backgroundColor = MainBgGray;
    
    

    self.title = @"开奖信息";
    
    
    

    [self getOpenCodeShowHUD:YES];
    [self customRefreshControl];
}
- (void)addSubview{
    [self tableView];
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [weakSelf getOpenCodeShowHUD:NO];
    }];
//    [self.tableView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
//        int64_t delayInSeconds = 1;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//
//            [weakSelf.tableView beginUpdates];
//
//            weakSelf.numberOfRows += 15;
//            NSMutableArray* newIndexPaths = [NSMutableArray new];
//
//            for(NSInteger i = weakSelf.numberOfRows - 15; i < weakSelf.numberOfRows; i++) {
//                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//                [newIndexPaths addObject:indexPath];
//            }
//
//            [weakSelf.tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//
//
//            [weakSelf.tableView endUpdates];
//
//            [scrollView ins_endInfinityScrollWithStoppingContentOffset:YES];
//
//            if (weakSelf.numberOfRows > 30) {
//                // Disable infinite scroll after 45 rows
//                scrollView.ins_infiniteScrollBackgroundView.enabled = NO;
//            }
//        });
//    }];
    
    
//    UIView <INSAnimatable> *infinityIndicator = [Utility defultFooter];;
//    [self.tableView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
//    [infinityIndicator startAnimating];
//    self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}

- (void)getOpenCodeShowHUD:(BOOL)show{
//    if(!self.tableView.refre)
    if(show)[self.view startLoading];
    [HttpManager getWithPath:Path_OpenCode param:@{@"m":@"newlist"}  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        
        
        NSMutableArray <LotteryModel *>*all = [LotteryModel mj_objectArrayWithKeyValuesArray:data[@"newlist"]];
        for (LotteryModel *lottery in [AppHelper helper].lotteryModels) {
            for (LotteryModel *ltty in all) {
                if([lottery.lottery_id isEqualToString:ltty.lottery_id]){
//                    lottery.pstatus = ltty.pstatus;
                    lottery.expect = ltty.expect;
                    lottery.opencode = ltty.opencode;
                    lottery.openname = ltty.openname;
                    lottery.id = ltty.id;
                    lottery.update_at = ltty.update_at;
                    
                }
            }
        }
        [self.tableView reloadData];
        
        
        [self.tableView ins_endPullToRefresh];
        if(show)[self.view stopLoading];
    } failure:^{
        [self.tableView ins_endPullToRefresh];
        if(show)[self.view stopLoading];
    }];
}



static NSString *LotteryListCellID = @"LotteryListCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.contentInset = UIEdgeInsetsMake(NormalMargin/2, 0, NormalMargin/2, 0);
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.backgroundColor = [UIColor clearColor];
        [tableView registerClass:[LotteryListCell class] forCellReuseIdentifier:LotteryListCellID];
        
        
        
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
    return PtOn47(105);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LotteryListCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryListCellID forIndexPath:indexPath];
    LotteryModel *lottery = [AppHelper helper].lotteryModels[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:lottery.img];
    cell.phaseLabel.text = [NSString stringWithFormat:@"期数 : %@",lottery.expect?:@""];
    cell.dateLabel.text = lottery.update_at?:@"";
    
//    cell.numbersView.line1Models = self.line1;
//    cell.numbersView.line2Models = self.line2;


        cell.numbersView.lotteryType = [lottery.lottery_id integerValue];
//        cell.numbersView.originCode = lottery.opencode;
    cell.numbersView.line1Codes = [lottery.opencode componentsSeparatedByString:@","];
    cell.numbersView.line2Codes = [lottery.openname componentsSeparatedByString:@","];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LotteryModel *lottery = [AppHelper helper].lotteryModels[indexPath.row];
    
    LotteryHistoryVC *vc = [[LotteryHistoryVC alloc]init];
    vc.currentLottery = lottery;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
