//
//  BillListModel.h
//  CP
//
//  Created by Apple on 2018/1/26.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillListModel : NSObject

//{"data":[{"id":"3","types":"提现","money":"503.00","create_at":"2018-01-26 13:43:32"},{"id":"1","types":"充值","money":"568.00","create_at":"2018-01-26 12:50:50"}]}

@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *types;
@property(nonatomic, copy) NSString *money;
@property(nonatomic, copy) NSString *create_at;

@end
