//
//  ScrollNoticeView.m
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "ScrollNoticeView.h"

@interface ScrollNoticeView()<TXScrollLabelViewDelegate, UIScrollViewDelegate>

@end

@implementation ScrollNoticeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = MainBgGray;
//        [self layout];
    }
    return self;
}

//- (void)layout{
//    [self.noticeIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(NormalMargin);
//        make.top.bottom.equalTo(self);
//        make.width.mas_equalTo(30);
//
//    }];
//    [self.scrollLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-NormalMargin);
//        make.left.equalTo(self.noticeIconView.mas_right).offset(NormalMargin);
//        make.top.bottom.equalTo(self);
//    }];
//}

- (void)layoutSubviews{
    self.noticeIconView.frame = CGRectMake(PtOn47(10), 0, PtOn47(30), self.height);
    self.scrollLabel.frame = CGRectMake(self.noticeIconView.maxX + PtOn47(10), 0, self.width - self.noticeIconView.maxX - PtOn47(20), self.height);
}

- (TXScrollLabelView *)scrollLabel{
    if (!_scrollLabel) {
        TXScrollLabelView *scrollLabel = [TXScrollLabelView scrollWithTitle:@"" type:TXScrollLabelViewTypeLeftRight velocity:2 options:UIViewAnimationOptionCurveEaseInOut];
        scrollLabel.scrollLabelViewDelegate = self;
        scrollLabel.delegate = self;
        scrollLabel.backgroundColor = [UIColor clearColor];
        scrollLabel.scrollTitleColor = TextDarkGrayColor;
        
        
        [self addSubview:scrollLabel];
        _scrollLabel = scrollLabel;
    }
    return _scrollLabel;
}
- (UIImageView *)noticeIconView{
    if (!_noticeIconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.contentMode = UIViewContentModeCenter;
        icon.image = [UIImage imageNamed:@"notice"];
        [self addSubview:icon];
        _noticeIconView = icon;
    }
    return _noticeIconView;
}



- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    if(self.didClick)self.didClick(scrollLabelView, text, index);
}
@end
