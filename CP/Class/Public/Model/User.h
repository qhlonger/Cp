//
//  User.h
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic, copy) NSString *id;
@property(nonatomic, copy) NSString *account;
@property(nonatomic, copy) NSString *winmoney;



@property(nonatomic, copy) NSString *balance;
@property(nonatomic, copy) NSString *mobile;
@property(nonatomic, copy) NSString *create_at;








//
@property(nonatomic, copy) NSString *mobileString;
@property(nonatomic, strong) NSString *winmoneyString;
@property(nonatomic, strong) NSString *balanceString;
@end
