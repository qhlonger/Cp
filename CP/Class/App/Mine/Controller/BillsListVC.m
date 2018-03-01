//
//  BillsListVC.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BillsListVC.h"
#import "BillsListCell.h"
#import "BillListModel.h"

@interface BillsListVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, weak) UIView *line;
@property(nonatomic, strong) NSMutableArray<BillListModel*>*billList;
@end

@implementation BillsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资金明细";
    [self getListShowHUD:YES];
    [self customRefreshControl];
}
- (void)getListShowHUD:(BOOL)show{
    if(show)[self.view startLoading];
    [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=catipal",Path_User] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        NSArray *dt = data[@"data"];
        if(dt && dt.count > 0){
            self.billList = [BillListModel mj_objectArrayWithKeyValuesArray:dt];
            [self.tableView reloadData];
        }
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    } failure:^{
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    }];
}

- (void)addSubview{
    [self line];
    [self tableView];
    
}
- (void)layout{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(PtOn47(30));
        make.width.mas_equalTo(2);
        make.top.bottom.equalTo(self.view);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
}
/*
 下拉刷新和上拉加载
 */
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [weakSelf getListShowHUD:NO];
    }];
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}
- (UIView *)line{
    if (!_line) {
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = [MainColor colorWithAlphaComponent:0.1];
        [self.view addSubview:line];
        _line = line;
    }
    return _line;
}
static NSString *BillsListCellID = @"BillsListCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        
        tableView.backgroundColor = [UIColor clearColor];
        tableView.allowsSelection = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [tableView registerClass:[BillsListCell class] forCellReuseIdentifier:BillsListCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.billList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtOn47(65);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BillsListCell *cell = [tableView dequeueReusableCellWithIdentifier:BillsListCellID forIndexPath:indexPath];
    BillListModel *bill = self.billList[indexPath.row];
    
    cell.titleLabel.text = bill.types;
    cell.dateLabel.text = bill.create_at;
    cell.balanceLabel.text = [NSString stringWithFormat:@"账户余额 : %@元",@"不知道"];
    
    
    if([bill.types isEqualToString:@"提现"]){
        cell.moneyLabel.text = [NSString stringWithFormat:@"-%@元",bill.money];
        cell.moneyLabel.textColor = GreenColor;
        
    }else if([bill.types isEqualToString:@"充值"]){
        cell.moneyLabel.text = [NSString stringWithFormat:@"+%@元",bill.money];
        cell.moneyLabel.textColor = MainColor;
        
    }
    
    
    
    cell.backgroundColor = indexPath.row % 2 ? BgLightGray : [UIColor whiteColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
