//
//  BettingHistoryVC.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingHistoryVC.h"
#import "BettingHistoryCell.h"
#import "SwitchLotteryView.h"
#import "TitleButtonView.h"
#import "BettingHistoryModel.h"


@interface BettingHistoryVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;

/**
 切换彩种view
 */
@property(nonatomic, weak) SwitchLotteryView *switchView;

/**
 导航栏titleView
 */
@property(nonatomic, weak) TitleButtonView *titleView;

@property(nonatomic, strong) NSArray<LotteryModel *> *lotteryModels;

@property(nonatomic, strong) NSMutableArray <BettingHistoryModel *>*betList;
@end

@implementation BettingHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.currentLottery){
        self.titleView.titleLabel.text = self.currentLottery.title;
    }
    
    
    [self getHistoryWithID:self.lotteryModels[self.switchView.selectedIndex].lottery_id isShowHUD:YES];
    [self customRefreshControl];
}
- (void)addSubview{
    [self tableView];
    [self switchView];
    [self titleView];
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)getHistoryWithID:(NSString *)aID isShowHUD:(BOOL)show{
    if(show)[self.view startLoading];
    NSString *path = [NSString stringWithFormat:@"%@?m=player",Path_User];
    if(aID && [aID integerValue] != 0)path = [NSString stringWithFormat:@"%@&lottery_id=%@",path,aID];
    

    [HttpManager getWithPath:path param:nil  showMsg:YES success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        
        self.betList = [BettingHistoryModel mj_objectArrayWithKeyValuesArray:data[@"data"]];
        [self.tableView reloadData];
        
        
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    } failure:^{
       if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    }];
}
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf getHistoryWithID:strongSelf.lotteryModels[strongSelf.switchView.selectedIndex].lottery_id isShowHUD:NO];
    }];
        [self.tableView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
//            int64_t delayInSeconds = 1;
//            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//    
//                [weakSelf.tableView beginUpdates];
//    
//                weakSelf.numberOfRows += 15;
//                NSMutableArray* newIndexPaths = [NSMutableArray new];
//    
//                for(NSInteger i = weakSelf.numberOfRows - 15; i < weakSelf.numberOfRows; i++) {
//                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//                    [newIndexPaths addObject:indexPath];
//                }
//    
//                [weakSelf.tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    
//    
//                [weakSelf.tableView endUpdates];
//    
//                [scrollView ins_endInfinityScrollWithStoppingContentOffset:YES];
//    
//                if (weakSelf.numberOfRows > 30) {
//                    // Disable infinite scroll after 45 rows
//                    scrollView.ins_infiniteScrollBackgroundView.enabled = NO;
//                }
//            });
        }];
    
    
    //    UIView <INSAnimatable> *infinityIndicator = [Utility defultFooter];;
    //    [self.tableView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
    //    [infinityIndicator startAnimating];
    //    self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
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
- (NSArray<LotteryModel *> *)lotteryModels{
    if (!_lotteryModels) {
        NSArray *a = @[
                       @{@"lottery_id":@0,
                         @"title":@"全部彩种",
                         },
                       @{@"lottery_id":@1,
                         @"title":@"北京赛车PK拾",
                         },
                       @{@"lottery_id":@2,
                         @"title":@"重庆时时彩",
                         },
                       @{@"lottery_id":@3,
                         @"title":@"幸运飞艇",
                         },
                       @{@"lottery_id":@4,
                         @"title":@"重庆幸运农场",
                         },
                       @{@"lottery_id":@5,
                         @"title":@"北京快乐8",
                         },
                       @{@"lottery_id":@6,
                         @"title":@"广东11选5",
                         },
                       @{@"lottery_id":@7,
                         @"title":@"广东快乐10分",
                         },
                       @{@"lottery_id":@8,
                         @"title":@"江苏快3",
                         },
                       ];
        _lotteryModels = [LotteryModel mj_objectArrayWithKeyValuesArray:a];
    }
    return _lotteryModels;
}


- (SwitchLotteryView *)switchView{
    if(!_switchView){
        SwitchLotteryView *sw = [[SwitchLotteryView alloc]init];
        
        sw.lotteryModels = self.lotteryModels;
        
        __weak __typeof(self)weakSelf = self;
        #pragma mark - 切换彩种
        [sw setDidSel:^(SwitchLotteryView *switchView, NSInteger index) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.titleView.titleLabel.text = strongSelf.lotteryModels[index].title;
            [strongSelf.betList removeAllObjects];
            [strongSelf.tableView reloadData];
            [strongSelf getHistoryWithID:strongSelf.lotteryModels[strongSelf.switchView.selectedIndex].lottery_id isShowHUD:YES];
        }];
        [sw setDidHide:^{
            weakSelf.titleView.selected = NO;
        }];
        
        int index = 0;
        if(self.currentLottery){
            for (LotteryModel *model in self.lotteryModels) {
                if([model.lottery_id isEqualToString:self.currentLottery.lottery_id]){
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
static NSString *BettingHistoryCellID = @"BettingHistoryCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.contentInset = UIEdgeInsetsMake(NormalMargin/2, 0, NormalMargin/2, 0);
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.allowsSelection = NO;
        [tableView registerClass:[BettingHistoryCell class] forCellReuseIdentifier:BettingHistoryCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.betList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtOn47(160);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BettingHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:BettingHistoryCellID forIndexPath:indexPath];
    
    BettingHistoryModel *record = self.betList[indexPath.row];
    NSInteger ltID = [record.lottery_id integerValue];
    LotteryModel *lottery = nil;
    if(ltID > 0 && ltID < 9){
        lottery = [AppHelper helper].lotteryModels[ltID-1];
    }
     

    
    cell.iconView.image = [UIImage imageNamed:lottery ? lottery.img : @""];
    cell.titleLabel.text = lottery ? lottery.title : @"未知彩种";
    cell.betNumberLabel.text = [NSString stringWithFormat:@"投注号码: %@",record.petname];
    cell.betTimeContentLabel.text = record.create_at;
    cell.betOddsContentLabel.text = [NSString stringWithFormat:@"%@",@([record.odds integerValue])];
    cell.betMoneyContentLabel.text = record.betmoney;
    cell.phaseLabel.text = @"不知道";
    cell.moneyLabel.text = @"不知道";
    
//    
//    cell.moneyLabel.text = @"123,123.12";
//    cell.phaseLabel.text = @"第12214期";
//    cell.betMoneyContentLabel.text = @"12,123.00元";
//    cell.betOddsContentLabel.text = @"40倍";
//    cell.betTimeContentLabel.text = @"2018--1-20 12:23:23";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    
}

@end
