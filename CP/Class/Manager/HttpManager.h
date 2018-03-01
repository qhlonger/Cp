//
//  HttpManager.h
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>











#define Path_Category    @"category.php"
#define Path_OpenCode    @"gamecode.php"
#define Path_Order       @"order.php"
#define Path_Player       @"player.php"
#define Path_User       @"user.php"





@class AFHTTPSessionManager;
@interface HttpManager : NSObject

@property (nonatomic, strong)  AFHTTPSessionManager * _Nonnull sessionManager;

+ (instancetype _Nonnull)sharedManager;



+ (void)postWithPath:(nullable NSString *)path
               param:(nullable NSDictionary *)param
             showMsg:(BOOL)show
             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
             failure:(nullable void (^)(void))failure;


+ (void)postOriginDataWithPath:(nullable NSString *)path
                         param:(nullable NSDictionary *)param
                       showMsg:(BOOL)showMsg
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
                       failure:(nullable void (^)(void))failure;
+ (void)getWithPath:(nullable NSString *)path
              param:(nullable NSDictionary *)param
            showMsg:(BOOL)isShowMsg
            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
            failure:(nullable void (^)(void))failure;


+ (void)getOriginDataWithPath:(nullable NSString *)path
                        param:(nullable NSDictionary *)param
                      showMsg:(BOOL)isShowMsg
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
                      failure:(nullable void (^)(void))failure;

@end
