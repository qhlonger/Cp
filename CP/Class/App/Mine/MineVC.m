//
//  MineVC.m
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "MineVC.h"

#import "BillsListVC.h"
#import "RechargeVC.h"
#import "NoticeVC.h"
#import "BettingHistoryVC.h"
#import "WithdrawVC.h"
#import "AccountManagerVC.h"
#import "LoginVC.h"

#import "ModifyPayPasswordVC.h"
#import "MineNormalCell.h"
#import "MineHeaderCell.h"
#import "CustomerServiceVC.h"


@interface MineVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;


@property(nonatomic, strong) NSArray <NSArray <NSDictionary *>*>*items;
@end

@implementation MineVC


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
    
    
    self.title = @"用户中心";
    [[UserManager sharedManager]getUserInfo:^(User *currentuser) {
        [self.tableView reloadData];
    } refresh:YES];
    
    
    
}
- (void)addSubview{
    [self tableView];
    
    [self nav];
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)nav{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_kefu"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    UIEdgeInsets edgeInsets;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        edgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    }else{
        edgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
    }
    self.navigationItem.rightBarButtonItem.imageInsets = edgeInsets;
}
- (void)rightItemClick{
    CustomerServiceVC *vc = [[CustomerServiceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSArray<NSArray<NSDictionary *> *> *)items{
    if (!_items) {
        _items =@[
                  @[
                      @{@"img":@"",@"title":@"账户余额"}
                      ],
                  @[
                      @{@"img":@"mine_list_kscz",@"title":@"快速充值"},
                      @{@"img":@"mine_list_grtx",@"title":@"个人提现"}
                      ],
                  @[
                      @{@"img":@"mine_list_zntz",@"title":@"站内通知"}
                      ],
                  @[
                      @{@"img":@"mine_list_tzcx",@"title":@"投注查询"},
                      @{@"img":@"mine_list_zjmx",@"title":@"资金明细"}
                      ],
                  @[
                      @{@"img":@"mine_list_zhgl",@"title":@"账户管理"}
                      ]
                  ];
    }
    return _items;
}




static NSString *MineNormalCellID = @"MineNormalCell";
static NSString *MineHeaderCellID = @"MineHeaderCell";

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        tableView.separatorColor = SepColor;
        tableView.sectionHeaderHeight = 10;
        tableView.sectionFooterHeight = 0;
        tableView.backgroundColor = MainBgGray;
        [tableView registerClass:[MineNormalCell class] forCellReuseIdentifier:MineNormalCellID];
        [tableView registerClass:[MineHeaderCell class] forCellReuseIdentifier:MineHeaderCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0)return PtOn47(100);
    return RowH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 20;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
        MineHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:MineHeaderCellID forIndexPath:indexPath];
        cell.titleLabel.text = @"账户余额（元）";
        cell.moneyLabel.text = [UserManager sharedManager].currentUser.balanceString ? : @"--,---.--";
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:MineNormalCellID forIndexPath:indexPath];
        cell.textLabel.text = self.items[indexPath.section][indexPath.row][@"title"];
        cell.imageView.image = [UIImage imageNamed:self.items[indexPath.section][indexPath.row][@"img"]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    
    NSString *title = self.items[indexPath.section][indexPath.row][@"title"];
    UIViewController *vc = nil;
    
//    if([title isEqualToString:@"账户余额"] ||
//       [title isEqualToString:@"个人提现"] ||
//       [title isEqualToString:@"投注查询"] ||
//       [title isEqualToString:@"资金明细"]){
//        if(![UserManager sharedManager].isLogined){
//            [Utility showToLoginAlertWith:self callback:^(BOOL success) {
//                
//            }];
//        }
//        return;
//    }
    
    
    
    if([title isEqualToString:@"账户余额"]){
        [Utility toLoginVC];
    }else  if([title isEqualToString:@"快速充值"]){
        vc = [[RechargeVC alloc]init];
    }else if([title isEqualToString:@"个人提现"]){
        vc = [[WithdrawVC alloc]init];
    }else if([title isEqualToString:@"站内通知"]){
        vc = [[NoticeVC alloc]init];
    }else if([title isEqualToString:@"投注查询"]){
        vc = [[BettingHistoryVC alloc]init];
    }else if([title isEqualToString:@"资金明细"]){
        vc = [[BillsListVC alloc]init];
    }else if([title isEqualToString:@"账户管理"]){
        vc = [[AccountManagerVC alloc]init];
    }
    
    if(vc)
        [self.navigationController pushViewController:vc animated:YES];
}

@end
