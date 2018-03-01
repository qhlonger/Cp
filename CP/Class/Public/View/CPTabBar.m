//
//  CPTabBar.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CPTabBar.h"

@interface CPTabBar()

@property(nonatomic, strong) NSArray *items;

@end

@implementation CPTabBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addItems];
        self.backgroundColor = TabBarBgColor;
        
        [self layoutFrame];
    }
    return self;
}

- (void)addItems{
    NSMutableArray *its = [@[] mutableCopy];
    for (int i = 0; i < TabBarItemSelImages.count; i ++) {
        
        CPTabBarItem *item = [CPTabBarItem buttonWithType:UIButtonTypeCustom];
        item.selected = i == 0;
        item.tintColor = TabBarTintColor;
        item.titleLabel.textAlignment = NSTextAlignmentCenter;
        item.titleLabel.font = CPFont(10);
        item.imageView.contentMode = UIViewContentModeCenter;
        
        [item setTitle:TabBarItemTitles[i] forState:UIControlStateNormal];
        
        [item setTitleColor:TabBarSelTintColor forState:UIControlStateSelected];
        [item setTitleColor:TabBarTintColor forState:UIControlStateNormal];
        
        if(TabBarItemImages.count > 0){
            [item setImage:[UIImage imageNamed:TabBarItemImages[i]] forState:UIControlStateNormal];
            [item setImage:[UIImage imageNamed:TabBarItemSelImages[i]] forState:UIControlStateSelected];
        }else{
            [item setImage:[UIImage imageNamed:TabBarItemSelImages[i]] forState:UIControlStateSelected];
            [item setImage:[[UIImage imageNamed:TabBarItemSelImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        }
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:item];
        [its addObject:item];
    }
    self.items = its;
}
- (void)layoutFrame{
    
    int i = 0;
    CGFloat itemW = self.width / TabBarItemSelImages.count;
    for (CPTabBarItem *item in self.items) {
        item.frame = CGRectMake(i*itemW, 0, itemW, self.height);
        i ++;
    }
}
- (void)layoutSubviews{
    [self layoutFrame];
}
- (void)itemClick:(CPTabBarItem *)item{
    
    NSInteger index = [self.items indexOfObject:item];
    [self setSelectIndex:index];
    
    if(self.ItemClick)self.ItemClick(item, index);
}

- (void)setSelectIndex:(NSInteger)index{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.1;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.96];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
    
    
    
    int i = 0;
    for (CPTabBarItem *item in self.items) {
        item.selected = index == i;
        if(i == index){
            [[item.imageView layer]
             addAnimation:animation forKey:nil];
        }
        
        i ++;
    }
}



@end

@interface CPTabBarItem ()

@end


@implementation CPTabBarItem



- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat h = CGRectGetHeight(contentRect) * 0.3;
    
    return CGRectMake(0, CGRectGetHeight(contentRect) - h, CGRectGetWidth(contentRect), h);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat h = CGRectGetHeight(contentRect) * 0.7;
    return CGRectMake(0, 0, CGRectGetWidth(contentRect), h);
}

@end
