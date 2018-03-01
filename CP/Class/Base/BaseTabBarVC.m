//
//  BaseTabBarVC.m
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTabBarVC.h"


#import "CPTabBar.h"


#import "HomeVC.h"
#import "MineVC.h"
#import "LotteryVC.h"
#import "BoardVC.h"

@interface BaseTabBarVC ()
@property(nonatomic, strong) CPTabBar *customTabBar;
@end

@implementation BaseTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    [self addVCs];
    [self customTabBar];
//    self.delegate = self;
//    [self.tabBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
//    [self.tabBar addObserver:self forKeyPath:@"hidden" options:NSKeyValueObservingOptionNew context:nil];
//}
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"frame"]) {
//        self.customTabBar.frame = self.tabBar.bounds;
//    }
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    [self.customTabBar setSelectIndex:[self.tabBar.items indexOfObject:item]];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
}
- (CPTabBar *)customTabBar{
    if (!_customTabBar) {
        _customTabBar = [[CPTabBar alloc]init];
//        _customTabBar.image = [UIImage imageNamed:@"nav_bg"];
        _customTabBar.contentMode = UIViewContentModeScaleAspectFill;
        _customTabBar.clipsToBounds = YES;
//        _customTabBar.backgroundColor = [UIColor redColor];
        __weak __typeof(self)weakSelf = self;
        [_customTabBar setItemClick:^(CPTabBarItem *item, NSInteger index) {
            weakSelf.selectedIndex = index;
        }];
//        self.tabBar.hidden = YES;
        [self.tabBar addSubview:_customTabBar];
        
//        UIView *r = [[UIView alloc]init];

        
        _customTabBar.frame = self.tabBar.bounds;
    }
    return _customTabBar;
}
- (void)config{
    self.tabBar.translucent = NO;
    self.tabBar.barTintColor = MainColor;
}
- (void)addVCs{
    HomeVC *homeVC = [[HomeVC alloc]init];
    BaseNavVC *homeNC = [[BaseNavVC alloc]initWithRootViewController:homeVC];
    
    MineVC *mineVC = [[MineVC alloc]init];
    BaseNavVC *mineNC = [[BaseNavVC alloc]initWithRootViewController:mineVC];
    
    LotteryVC *lotteryVC = [[LotteryVC alloc]init];
    BaseNavVC *lotteryNC = [[BaseNavVC alloc]initWithRootViewController:lotteryVC];
    
    BoardVC *boardVC = [[BoardVC alloc]init];
    BaseNavVC *boardNC = [[BaseNavVC alloc]initWithRootViewController:boardVC];
    
    
    
    self.viewControllers = @[homeNC, lotteryNC, boardNC, mineNC];
    
    
    
    
//    NSArray *tabBarItemImages = @[@"tabbar_home",
//                                  @"tabbar_notice",
//                                  @"tabbar_bbs",
//                                  @"tabbar_mine"];
//    NSArray *tabBarItemSelImages = @[@"tabbar_home",
//                                     @"tabbar_notice",
//                                     @"tabbar_bbs",
//                                  @"tabbar_mine"];
//    NSArray *tabBarItemTitles = @[@"购彩大厅",
//                                  @"开奖信息",
//                                  @"榜上有名",
//                                  @"用户中心"
//                                  ];
//    int i = 0;
//    self.tabBar.tintColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor clearColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
//    for (UITabBarItem *item in self.tabBar.items) {
//        item.title = tabBarItemTitles[i];
//        item.image = [UIImage imageNamed:tabBarItemImages[i]];
//        item.selectedImage = [[UIImage imageNamed:tabBarItemSelImages[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        i++;
//    }
    
    
}

@end
