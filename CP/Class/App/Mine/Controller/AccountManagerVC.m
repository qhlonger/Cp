//
//  AccountManagerVC.m
//  CP
//
//  Created by Apple on 2018/1/19.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "AccountManagerVC.h"
#import "ModifyPayPasswordVC.h"
#import "ModifyLoginPasswordVC.h"
#import "BindPhoneVC.h"
#import "MineNormalCell.h"
@interface AccountManagerVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSArray <NSArray <NSString *>*>*titles;
@end

@implementation AccountManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"账户管理";
    if([UserManager sharedManager].isLogined){
        [[UserManager sharedManager]getUserInfo:^(User *currentuser) {
            [self.tableView reloadData];
        } refresh:YES];
    }
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (void)addSubview{
    [self tableView];
}

- (NSArray *)titles{
    if (!_titles) {
        _titles = @[@[@"账号",@"手机号码"],
//                    @[@"银行卡"],
                    @[@"修改登录密码",@"修改支付密码"],
                    @[@"退出登录"]];
    }
    return _titles;
}

static NSString *CellID = @"CellID";
static NSString *MineNormalCellID = @"MineNormalCellID";
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
//        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
//        [tableView registerClass:[MineNormalCell class] forCellReuseIdentifier:MineNormalCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
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
    return PtOn47(10);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowH;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *identifier = @"cell";
    
//    MineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:MineNormalCellID forIndexPath:indexPath];
    
//    return cell;
    
    MineNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[MineNormalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellID];
    }
    for (UIView *v in cell.contentView.subviews) {
        if(v.tag == 1001)
            [v removeFromSuperview];
    }
    
    
    NSString *title = self.titles[indexPath.section][indexPath.row];
    cell.textLabel.textColor = TextBlackColor;
    cell.detailTextLabel.textColor = TextGrayColor;
    cell.textLabel.font = CPFont(14);
    cell.detailTextLabel.font = CPFont(14);
    cell.textLabel.text = @"";
    cell.detailTextLabel.text = @"";
    cell.accessoryType = ([title isEqualToString:@"账号"] || [title isEqualToString:@"退出登录"]) ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if([title isEqualToString:@"退出登录"]){
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width, RowH)];
        label.tag = 1001;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = CPFont(14);
        label.text = title;
        label.textColor = [UserManager sharedManager].isLogined  ? TextBlackColor : TextLightGrayColor;
        [cell.contentView addSubview:label];
        
        
    }else{
        if([title isEqualToString:@"手机号码"]){
            cell.detailTextLabel.text = [UserManager sharedManager].currentUser.mobileString.length > 1 ? [UserManager sharedManager].currentUser.mobileString :@"未绑定";
            //    }else if([title isEqualToString:@"银行卡"]){{
        }else if([title isEqualToString:@"账号"]){
            cell.detailTextLabel.text = [UserManager sharedManager].currentUser.account;
            
        }
            
        cell.textLabel.text = title;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
#warning ---
//    if(![UserManager sharedManager].isLogined){
//        [Utility showError:@"您还未登录"];
//        return;
//    }
    UIViewController *vc = nil;
    NSString *title = self.titles[indexPath.section][indexPath.row];
    if([title isEqualToString:@"手机号码"]){
        
        vc = [[BindPhoneVC alloc]init];
    }else if([title isEqualToString:@"银行卡"]){
        
    }else if([title isEqualToString:@"修改登录密码"]){
        vc = [[ModifyLoginPasswordVC alloc]init];
    }else if([title isEqualToString:@"修改支付密码"]){
        vc = [[ModifyPayPasswordVC alloc]init];
    }else if([title isEqualToString:@"退出登录"]){
        if([UserManager sharedManager].isLogined){
            [CPAlertView showWithTitle:@"退出登录" info:@"确定要退出登录吗？" leftTitle:@"取消" rightTitle:@"确定" config:^(CPAlertView *alertView) {
                
            } leftAction:^BOOL(CPAlertView *alertView) {
                return YES;
            } rightAction:^BOOL(CPAlertView *alertView) {
                
                [Utility showError:@"退出登录"];
                return YES;
            }];
        }else{
            [Utility showError:@"您还未登录"];
        }
        return ;
    }
    
    if(vc)
       [self.navigationController pushViewController:vc animated:YES];
}

@end
