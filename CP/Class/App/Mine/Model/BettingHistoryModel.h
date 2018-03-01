//
//  BettingHistoryModel.h
//  CP
//
//  Created by Apple on 2018/1/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BettingHistoryModel : NSObject
//{"data":[{"lottery_id":"1","betname":"NOx2x3","odds":"9.900","betmoney":"1","create_at":"2018-01-25 21:53:00","petname":"第2名(3)"},{"lottery_id":"1","betname":"NOx1x9","odds":"9.900","betmoney":"2","create_at":"2018-01-25 21:53:09","petname":"第1名(9)"},]}

@property(nonatomic, copy) NSString *lottery_id;
@property(nonatomic, copy) NSString *betname;
@property(nonatomic, copy) NSString *odds;
@property(nonatomic, copy) NSString *betmoney;
@property(nonatomic, copy) NSString *create_at;
@property(nonatomic, copy) NSString *petname;


@end
