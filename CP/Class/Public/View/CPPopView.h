//
//  CPPopView.h
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CPPopViewArrowDirection) {
    CPPopViewArrowDirectionTop,
    CPPopViewArrowDirectionRight,
    CPPopViewArrowDirectionLeft,
    CPPopViewArrowDirectionBottom
};

@interface CPPopViewCell : UITableViewCell
@property(nonatomic, weak) UIImageView *iconView;
@property(nonatomic, weak) UILabel *titleLabel;
@end



@interface CPPopMainView : UIView

@property(nonatomic, weak) UITableView *tableView;
@property(nonatomic, strong) NSArray <NSString *>*titles;
@property(nonatomic, strong) NSArray <NSString *>*images;
//0-1
@property(nonatomic, assign) CGFloat ArrowXPercent;
@property(nonatomic, assign) CPPopViewArrowDirection arrowDirection;
@property(nonatomic, copy) BOOL(^selectAtIndex) (NSInteger index);

@end



@interface CPPopView : UIView
@property(nonatomic, assign) CPPopMainView *mainView;

@property(nonatomic, assign) CGPoint clickPosition;
@property(nonatomic, assign) CGRect onViewRect;
@property(nonatomic, weak) UIView *bgView;

@property(nonatomic, strong) NSArray <NSString *>*titles;
@property(nonatomic, strong) NSArray <NSString *>*images;
@property(nonatomic, copy) BOOL(^selectAtIndex) (NSInteger index);

- (void)show;



+ (void)showWithPosition:(CGPoint)pt images:(NSArray <NSString *>*)images titles:(NSArray <NSString *>*)titles clickAtIndex:(BOOL(^)(NSInteger index))selectAtIndex;
@end

