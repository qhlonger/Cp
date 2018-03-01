//
//  UserManager.h
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject
//可能为空
@property(nonatomic, strong) User *currentUser;

+ (instancetype)sharedManager;



- (void)getUserInfo:(void(^)(User *currentuser))callback refresh:(BOOL)needRefresh;



@property(nonatomic, assign) BOOL isLogined;

@end
