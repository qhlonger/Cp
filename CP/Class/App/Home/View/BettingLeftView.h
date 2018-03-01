//
//  BettingLeftView.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingLeftViewCell : UITableViewCell
@property(nonatomic, weak) UILabel *titleLabel;
@property(nonatomic, weak) UIView *topSep;
@end

@interface BettingLeftView : UIView
@property(nonatomic, weak) UITableView *tableView;


//@property(nonatomic, strong) NSArray *titles;
- (void)reloadData;
@property(nonatomic, copy) NSString *(^titlesAtIndex) (BettingLeftView *view, NSInteger index);
@property(nonatomic, copy) NSInteger(^numbersOfRow) (BettingLeftView *view);
@property(nonatomic, copy) void(^didSelect) (BettingLeftView *view, NSInteger index);
@property(nonatomic, assign) NSInteger selectedIndex;
@end
