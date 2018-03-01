//
//  BoardVC.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//
//购彩大厅页面
#import "BoardVC.h"
#import "BoardListCell.h"

@interface BoardVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSArray <User *>*users;
@end

@implementation BoardVC

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
    
    
    self.title = @"榜上有名";
    
    NSMutableArray <User *>*users = [@[] mutableCopy];
    for (int i = 0; i < 20; i++) {
        [users addObject:[[User alloc]init]];
    }
    self.users = users;
    [self.tableView reloadData];
    
    [self getBoardListShowHUD:YES];
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
/*
 下拉刷新和上拉加载
 */
- (void)customRefreshControl{
    __weak typeof(self) weakSelf = self;
    
    self.tableView.ins_pullToRefreshBackgroundView.dragToTriggerOffset = 60.0;
    [self.tableView ins_addPullToRefreshWithHeight:60.0 handler:^(UIScrollView *scrollView) {
        [weakSelf getBoardListShowHUD:NO];
    }];
    UIView <INSPullToRefreshBackgroundViewDelegate> *pullToRefresh = [Utility defultHeader];
    self.tableView.ins_pullToRefreshBackgroundView.delegate = pullToRefresh;
    [self.tableView.ins_pullToRefreshBackgroundView addSubview:pullToRefresh];
}

- (void)getBoardListShowHUD:(BOOL)show{
    if(show)[self.view startLoading];
    [HttpManager getWithPath:Path_Order param:@{@"m":@"list"}  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
        
        NSMutableArray *all = [User mj_objectArrayWithKeyValuesArray:data[@"order"]];;
        if(all && all.count){
            self.users = all;
            [self.tableView reloadData];
        }
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    } failure:^{
        if(show)[self.view stopLoading];
        [self.tableView ins_endPullToRefresh];
    }];
}

static NSString *BoardListCellID = @"BoardListCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.allowsSelection = UITableViewCellSelectionStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.contentInset = UIEdgeInsetsMake(NormalMargin/2, 0, NormalMargin/2, 0);
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorColor = SepColor;
        [tableView registerClass:[BoardListCell class] forCellReuseIdentifier:BoardListCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtOn47(70);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BoardListCell *cell = [tableView dequeueReusableCellWithIdentifier:BoardListCellID forIndexPath:indexPath];
    
    User *user = self.users[indexPath.row];
    
    if(!user.account){
        cell.usernameContentLabel.text = @"----";
    }else{
        cell.usernameContentLabel.text = user.account;
    }
    if(!user.winmoney){
        cell.profitContentLabel.text = @"---,---.--";
    }else{
        cell.profitContentLabel.text = user.winmoneyString;
    }
    
    
    
    if (indexPath.row == self.users.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
    }else{
        cell.separatorInset = UIEdgeInsetsMake(0, PtOn47(10), 0, PtOn47(10));
    }
    
    if(indexPath.row == 0){
        cell.rankImgView.image = [UIImage imageNamed:@"board_1"];
        cell.rankLabel.text = @"";
    }else if(indexPath.row == 1){
        cell.rankImgView.image = [UIImage imageNamed:@"board_2"];
        cell.rankLabel.text = @"";
    }else if(indexPath.row == 2){
        cell.rankImgView.image = [UIImage imageNamed:@"board_3"];
        cell.rankLabel.text = @"";
    }else{
        cell.rankImgView.image = [UIImage imageNamed:@"board_4_"];
        cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

@end
