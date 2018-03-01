//
//  UIView+Extension.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UIView+Extension.h"

#import <objc/runtime.h>

@implementation UIView (Extension)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)height{
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size{
    return self.frame.size;
}


- (CGFloat)top{
    return self.frame.origin.y;
}
- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}
- (CGFloat)left{
    return self.frame.origin.x;
}
- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}
- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)midX{
    return CGRectGetMidX(self.frame);
}
- (CGFloat)midY{
    return CGRectGetMidY(self.frame);
}
- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}




















static NSString *actIndicatorKey = @"actIndicatorKey";
static NSString *indicatorBgViewKey = @"indicatorBgViewKey";
static NSString *indicatorCoverKey = @"indicatorCoverKey";
static NSString *isHudShowKey = @"isHudShowKey";

//- (void)setActIndicator:(UIActivityIndicatorView *)actIndicator{
////    [self addSubview:actIndicator];
//    objc_setAssociatedObject(self, &actIndicatorKey, actIndicator, OBJC_ASSOCIATION_RETAIN);
//}

- (void)setIsHudShow:(BOOL)isHudShow{
    objc_setAssociatedObject(self, &isHudShowKey, [NSNumber numberWithInteger:isHudShow ? 1 : 0] , OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isHudShow{
    NSNumber *a =  objc_getAssociatedObject(self, &isHudShowKey);
    if(a)
        return [a boolValue];
    return NO;
}

- (UIActivityIndicatorView *)actIndicator{
    UIActivityIndicatorView *actView = objc_getAssociatedObject(self, &actIndicatorKey);
    if(actView)return actView;
    
    
    actView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    actView.hidesWhenStopped = YES;
    [self.indicatorBgView addSubview:actView];
    objc_setAssociatedObject(self, &actIndicatorKey, actView, OBJC_ASSOCIATION_RETAIN);
    return actView;
}

- (UIView *)indicatorBgView{
    UIView *indicatorBgView = objc_getAssociatedObject(self, &indicatorBgViewKey);
    if(indicatorBgView)return indicatorBgView;
    
    indicatorBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    indicatorBgView.layer.cornerRadius = 25;
    indicatorBgView.layer.masksToBounds = YES;
    
    
    [self addSubview:indicatorBgView];
    objc_setAssociatedObject(self, &indicatorBgViewKey, indicatorBgView, OBJC_ASSOCIATION_RETAIN);
    return indicatorBgView;
}


- (UIView *)indicatorCoverView{
    UIView *indicatorCoverView = objc_getAssociatedObject(self, &indicatorCoverKey);
    if(indicatorCoverView)return indicatorCoverView;
    
    
    
    indicatorCoverView = [[UIView alloc]initWithFrame:self.bounds];
    indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    [self addSubview:indicatorCoverView];
    objc_setAssociatedObject(self, &indicatorCoverKey, indicatorCoverView, OBJC_ASSOCIATION_RETAIN);
    return indicatorCoverView;
}










- (void)startLoadingWithCover{
    [self bringSubviewToFront:self.indicatorCoverView];
    [self bringSubviewToFront:self.indicatorBgView];
    [self bringSubviewToFront:self.actIndicator];
    
    
    self.indicatorCoverView.userInteractionEnabled = YES;
    
    self.indicatorCoverView.frame = self.bounds;
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.bounds;
    
    [self.actIndicator startAnimating];
    
    
    self.isHudShow = NO;
    self.actIndicator.color = [UIColor whiteColor];
    self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorBgView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.actIndicator.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
        self.indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.indicatorBgView.transform = CGAffineTransformMakeScale(1, 1);
            self.actIndicator.transform = CGAffineTransformMakeScale(1, 1);
            
            self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
            self.indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        }completion:^(BOOL finished) {
            self.isHudShow = YES;
        }];
    }];
    
    
}
- (void)startLoadingWithBg{
    [self bringSubviewToFront:self.indicatorBgView];
    [self bringSubviewToFront:self.actIndicator];
    
    
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.bounds;
    
    
    [self.actIndicator startAnimating];
    self.isHudShow = NO;
    self.actIndicator.color = [UIColor whiteColor];
    self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorBgView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.indicatorBgView.transform = CGAffineTransformMakeScale(1, 1);
            self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        }completion:^(BOOL finished) {
            self.isHudShow = YES;
        }];
    }];

}
- (void)startLoading{
    [self bringSubviewToFront:self.actIndicator];
    
    
    self.indicatorBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, CGRectGetHeight(self.frame)/2);
    self.actIndicator.frame = self.indicatorBgView.bounds;
    
    [self.actIndicator startAnimating];
    
    
    
    self.isHudShow = NO;
    self.actIndicator.color = [UIColor darkGrayColor];
    self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:0.1 animations:^{
        self.indicatorBgView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.indicatorBgView.transform = CGAffineTransformMakeScale(1, 1);
        }completion:^(BOOL finished) {
            self.isHudShow = YES;
        }];
    }];
}



- (void)stopLoading{
    self.indicatorCoverView.userInteractionEnabled = NO;
    
    
    void(^doHideAction)(void) = ^{    [UIView animateWithDuration:0.2 animations:^{
        self.indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.actIndicator.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        
        
        self.indicatorBgView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    }completion:^(BOOL finished) {
        self.indicatorCoverView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.indicatorBgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.actIndicator.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
        
        
        [self.actIndicator stopAnimating];
    }];
    };
    if(self.isHudShow){
        doHideAction();
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            doHideAction();
        });
    }
    
}








@end
