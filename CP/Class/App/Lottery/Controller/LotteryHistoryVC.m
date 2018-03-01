//
//  LotteryHistoryVC.m
//  CP
//
//  Created by Apple on 2018/1/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "LotteryHistoryVC.h"
#import "LotteryHistoryListCell.h"
#import "LotteryHistoryHeaderCell.h"

@interface LotteryHistoryVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray <LotteryModel *>*lotteryModels;
@property(nonatomic, assign) NSInteger page;
@end

@implementation LotteryHistoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"往期结果";
    [self customRefreshControl];
    self.page = 1;
    [self getCodeShowHUD:YES];
    
}
- (void)addSubview{
    [self tableView];
}

- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)getCodeShowHUD:(BOOL)show{
    if(show)[self.view startLoading];
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=list&lottery_id=%@&page_number=%d",Path_OpenCode,self.currentLottery.lottery_id,1]
                       param:nil
                
                     showMsg:NO
                     success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        
                         [self.lotteryModels removeAllObjects];
                         self.lotteryModels = [LotteryModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
                         
                         [self.tableView reloadData];
                         if(show)[self.view stopLoading];
                         [self.tableView ins_endPullToRefresh];
                         self.page = 1;
                         
                         
    } failure:^{
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    }];
}
- (void)appendCode{
    self.page ++;
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=list&lottery_id=%@&page_number=%ld",Path_OpenCode,self.currentLottery.lottery_id,(long)self.page]
                       param:nil
                
                     showMsg:NO
                     success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
                         NSMutableArray *arr = [LotteryModel mj_objectArrayWithKeyValuesArray:data[@"list"]];
                         if(arr && arr.count >= 20){
                             
                         }else{
                             [self.tableView ins_removeInfinityScroll];
                         }
                         [self.lotteryModels addObjectsFromArray: arr];
                         
                         [self.tableView reloadData];
//                         [self.tableView ins_endInfinityScroll];
                         [self.tableView ins_endInfinityScrollWithStoppingContentOffset:YES];
                     } failure:^{
                         self.page--;
                         self.tableView.ins_infiniteScrollBackgroundView.enabled = NO;
//                         [self.tableView ins_endInfinityScroll];
                     }];
}
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [weakSelf getCodeShowHUD:NO];
    }];
    
    
    //    UIView <INSAnimatable> *infinityIndicator = [Utility defultFooter];;
    //    [self.tableView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
    //    [infinityIndicator startAnimating];
    //    self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
    
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
    
    
    [self.tableView ins_addInfinityScrollWithHeight:60 handler:^(UIScrollView *scrollView) {
        [weakSelf appendCode];
    }];
        UIView <INSAnimatable> *infinityIndicator = [Utility defultFooter];;
        [self.tableView.ins_infiniteScrollBackgroundView addSubview:infinityIndicator];
        [infinityIndicator startAnimating];
        self.tableView.ins_infiniteScrollBackgroundView.preserveContentInset = NO;
    
}


static NSString *LotteryHistoryHeaderCellID = @"LotteryHistoryHeaderCell";
static NSString *LotteryHistoryListCellID = @"LotteryHistoryListCell";
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
        
        [tableView registerClass:[LotteryHistoryHeaderCell class] forCellReuseIdentifier:LotteryHistoryHeaderCellID];
        [tableView registerClass:[LotteryHistoryListCell class] forCellReuseIdentifier:LotteryHistoryListCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lotteryModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
    return PtOn47(135);
    return PtOn47(95);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LotteryModel *lotteryModel = self.lotteryModels[indexPath.row];
    if(indexPath.row == 0){
        LotteryHistoryHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryHistoryHeaderCellID forIndexPath:indexPath];
        LotteryModel *lt = [Utility getLotteryByID:lotteryModel.lottery_id];
        
        cell.iconView.image = [UIImage imageNamed:lt.img];
        cell.iconView.image = [UIImage imageNamed:lt.img];
        cell.phaseLabel.text = [NSString stringWithFormat:@"期数 : %@",lotteryModel.expect?:@"----"];
        cell.dateLabel.text = lotteryModel.update_at?:@"";
        
        //    cell.numbersView.line1Models = self.line1;
        //    cell.numbersView.line2Models = self.line2;
        
        
        cell.numbersView.lotteryType = [lotteryModel.lottery_id integerValue];
        cell.numbersView.line1Codes = [lotteryModel.opencode componentsSeparatedByString:@","];
        cell.numbersView.line2Codes = [lotteryModel.openname componentsSeparatedByString:@","];
        
        return cell;
        
    }else{
        
        LotteryHistoryListCell *cell = [tableView dequeueReusableCellWithIdentifier:LotteryHistoryListCellID forIndexPath:indexPath];
        
        
        cell.phaseLabel.text = [NSString stringWithFormat:@"期数 : %@",lotteryModel.expect?:@"----"];
        cell.dateLabel.text = lotteryModel.update_at?:@"";
        
        
        
        cell.numbersView.lotteryType = [lotteryModel.lottery_id integerValue];
        cell.numbersView.originCode = lotteryModel.opencode;
        
        return cell;
    }
}
@end

