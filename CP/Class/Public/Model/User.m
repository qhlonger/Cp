//
//  User.m
//  CP
//
//  Created by Apple on 2018/1/16.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "User.h"

@implementation User


- (void)setWinmoney:(NSString *)winmoney{
    _winmoney = winmoney;
    _winmoneyString = [Utility countNumAndChangeformat: [NSString stringWithFormat:@"%.2f",winmoney.floatValue]];
}
- (void)setBalance:(NSString *)balance{
    _balance = balance;
    _balanceString = [Utility countNumAndChangeformat: [NSString stringWithFormat:@"%.2f",balance.floatValue]];
}
- (void)setMobile:(NSString *)mobile{
    _mobile = mobile;
    if(mobile.length > 4){
        _mobileString = [mobile stringByReplacingCharactersInRange:NSMakeRange(mobile.length/4, mobile.length/3) withString:[self getStar:mobile.length/3 - mobile.length/4]];
    }else{
        _mobileString = @"";
    }
}

- (NSString *)getStar:(NSInteger)count{
    if(count > 0){
        NSString *star = @"*";
        while (count-- >0) {
            star = [star stringByAppendingString:@"*"];
        }
        return star;
    }
    return @"*";
}
@end
