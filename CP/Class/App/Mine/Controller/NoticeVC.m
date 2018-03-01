//
//  NoticeVC.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeCell.h"

@interface NoticeVC ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, weak) UITableView *tableView;
@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通知";
    
}
- (void)addSubview{
    [self tableView];
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

static NSString *NoticeCellID = @"NoticeCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.contentInset = UIEdgeInsetsMake(NormalMargin/2, 0, NormalMargin/2, 0);
        tableView.backgroundColor = [UIColor clearColor];
        tableView.allowsSelection = NO;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [tableView registerClass:[NoticeCell class] forCellReuseIdentifier:NoticeCellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:NoticeCellID configuration:^(NoticeCell *cell) {
        cell.iconView.image = [UIImage imageNamed:@"tongzhi_geren"];
        cell.categoryLabel.text = @"个人私信";
        cell.dateLabel.text = @"2018-01-20";
        cell.titleLabel.text = @"关于买家自助退款方式的相关说明";
        cell.detailLabel.text = @"关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明关于买家自助退款方式的相关说明关于买家自助退款方式的相关说明";
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:NoticeCellID forIndexPath:indexPath];
    cell.iconView.image = [UIImage imageNamed:@"tongzhi_geren"];
    cell.categoryLabel.text = @"个人私信";
    cell.dateLabel.text = @"2018-01-20";
    cell.titleLabel.text = @"关于买家自助退款方式的相关说明";
    cell.detailLabel.text = @"关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明,关于买家自助退款方式的相关说明关于买家自助退款方式的相关说明关于买家自助退款方式的相关说明";
    return cell;
}

@end
