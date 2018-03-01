//
//  BettingModel.h
//  CP
//
//  Created by Apple on 2018/1/20.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BettingItemModel : NSObject <NSMutableCopying>
@property(nonatomic, copy) NSString *type;


@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *odds;
@property(nonatomic, copy) NSString *betname;
@property(nonatomic, assign) BOOL isSelected;



//for 龙虎斗 only
@property(nonatomic, copy) NSString *globalTitle;
@property(nonatomic, strong) BettingItemModel *subItem;


@end

@interface BettingRightDataModel : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSArray <BettingItemModel *>*items;
@end


@interface BettingModel : NSObject
@property(nonatomic, copy) NSString *leftTitle;
@property(nonatomic, copy) NSArray <BettingRightDataModel *>*rightDatas;
@end
