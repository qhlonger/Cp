//
//  BettingModel.m
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BettingModel.h"
@implementation BettingItemModel




- (id)mutableCopyWithZone:(NSZone *)zone{
    BettingItemModel *item = [[BettingItemModel allocWithZone:zone]init];
    item.title = self.title;
    item.type = self.type;
    item.odds = self.odds;
    item.isSelected = self.isSelected;
    item.globalTitle = self.globalTitle;
    item.subItem = [self.subItem mutableCopy];
    return item;
}

@end

@implementation BettingRightDataModel
@end

@implementation BettingModel

@end
