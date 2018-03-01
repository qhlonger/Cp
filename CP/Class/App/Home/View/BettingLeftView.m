//
//  BettingLeftView.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingLeftView.h"

@interface BettingLeftViewCell()

@end
@implementation BettingLeftViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview];
        [self layout];
        
    }
    return self;
}
- (void)addSubview{
    [self titleLabel];
}
- (void)layout{
    CGFloat margin = NormalMargin;
    [self.topSep mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(margin);
        make.right.equalTo(self.contentView).offset(-margin);
        make.top.bottom.equalTo(self.contentView);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(15);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textAlignment = NSTextAlignmentCenter;
        title.textColor = TextGrayColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

- (UIView *)topSep{
    if (!_topSep) {
        UIView *v = [[UIView alloc]init];
        v.backgroundColor = SepColor;
        [self.contentView addSubview:v];
        _topSep = v;
    }
    return _topSep;
}

@end



@interface BettingLeftView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BettingLeftView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectedIndex = 0;
        [self addSubview];
        [self layout];
    }
    return self;
}
- (void)addSubview{
    [self tableView];
}
- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)reloadData{
    self.selectedIndex = 0;
    [self.tableView reloadData];
}

//- (void)setTitles:(NSArray *)titles{
//    _titles = titles;
//
//    [self.tableView reloadData];
//}



static NSString *BettingLeftViewCellID = @"BettingLeftViewCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorColor = SepColor;
        tableView.tableFooterView = [UIView new];
        tableView.backgroundColor = MainBgGray;
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [tableView registerClass:[BettingLeftViewCell class] forCellReuseIdentifier:BettingLeftViewCellID];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numbersOfRow ? self.numbersOfRow(self) : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return RowH*1.4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BettingLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BettingLeftViewCellID forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = _selectedIndex == indexPath.row ? [UIColor whiteColor] : MainBgGray;
    cell.topSep.hidden = indexPath.row != 0;
    
//    NSString *title = self.titles[indexPath.row];
    cell.titleLabel.text = self.titlesAtIndex?self.titlesAtIndex(self,indexPath.row):@"";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath.row;
    [tableView reloadData];
    if(self.didSelect)self.didSelect(self, indexPath.row);
}

@end
