//
//  UserManager.m
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "UserManager.h"


@interface UserManager()

@end

@implementation UserManager

+ (instancetype)sharedManager{
    static UserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[UserManager alloc]init];
    });
    return manager;
}


- (void)getUserInfo:(void(^)(User *currentuser))callback refresh:(BOOL)needRefresh{
    
    if(self.currentUser.account.length > 0 && !needRefresh){
        if(callback)callback(self.currentUser);
    }else{
        [HttpManager getWithPath:[NSString stringWithFormat:@"%@?m=info",Path_User] param:nil  showMsg:NO success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable data) {
            self.currentUser = [User mj_objectWithKeyValues:data[@"user"]];
            if(callback)callback(self.currentUser);
        } failure:^{
            if(callback)callback(nil);
        }];
        
        
    }
}

@end
