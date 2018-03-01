//
//  HttpManager.m
//  CP
//
//  Created by Apple on 2018/1/15.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

+ (instancetype)sharedManager{
    static HttpManager *sharedManager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedManager = [[HttpManager alloc]init];
        
        sharedManager.sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@""]];
        sharedManager.sessionManager.requestSerializer.timeoutInterval = 10;
        sharedManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        sharedManager.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sharedManager.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
        
        [sharedManager.sessionManager.requestSerializer setValue:[NSString stringWithFormat:@"ios%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"User-Agent"];
    });
    return sharedManager;
}


+ (void)postWithPath:(nullable NSString *)path
               param:(nullable NSDictionary *)param
             showMsg:(BOOL)showMsg
             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
             failure:(nullable void (^)(void))failure{

    
    path = [self getFinalPath:path];
    
    
    NSLog(@" =====================\n%@%@\n%@\n===================",[HttpManager sharedManager].sessionManager.baseURL.absoluteString,path,param);
    [[HttpManager sharedManager].sessionManager POST:path parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSInteger statusCode = [rootDict[@"statusCode"] integerValue];
        
        if(statusCode == -1){
            
            NSString *respMsg = rootDict[@"respMsg"];
            if(respMsg && showMsg){
                [Utility showError:respMsg];
                if(failure)
                    failure();
                return;
                
            }
        }else if(statusCode == 1){
            NSString *respMsg = rootDict[@"respMsg"];
            if(respMsg && showMsg){
                [Utility showSuccess:respMsg];
            }
        }
        if(success)
            success(task, rootDict[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
        failure();
    }];
}

+ (void)postOriginDataWithPath:(nullable NSString *)path
               param:(nullable NSDictionary *)param
             showMsg:(BOOL)showMsg
             success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
             failure:(nullable void (^)(void))failure{

    
    path = [self getFinalPath:path];
    
    
    NSLog(@" =====================\n%@%@\n%@\n===================",[HttpManager sharedManager].sessionManager.baseURL.absoluteString,path,param);
    [[HttpManager sharedManager].sessionManager POST:path parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        NSInteger statusCode = [rootDict[@"statusCode"] integerValue];
        
        if(statusCode == -1){
        
            NSString *respMsg = rootDict[@"respMsg"];
            if(respMsg && showMsg){
                [Utility showError:respMsg];
            }
        }
        if(success)
            success(task, rootDict[@"data"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if(failure)
        failure();
    }];
}




+ (void)getWithPath:(nullable NSString *)path
              param:(nullable NSDictionary *)param
            showMsg:(BOOL)isShowMsg
            success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
            failure:(nullable void (^)(void))failure{
    path = [self getFinalPath:path];
    NSLog(@" =====================\n%@%@\n%@\n===================",[HttpManager sharedManager].sessionManager.baseURL.absoluteString,path,param);
    [[HttpManager sharedManager].sessionManager GET:path parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        NSInteger statusCode = [rootDict[@"statusCode"] integerValue];
        NSString *respMsg = rootDict[@"respMsg"];
        if(respMsg && isShowMsg){
            [Utility showError:respMsg];
        }
        if(success)
        success(task, rootDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
        failure();
    }];
}

+ (void)getOriginDataWithPath:(nullable NSString *)path
                        param:(nullable NSDictionary *)param
                      showMsg:(BOOL)isShowMsg
                      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable data))success
                      failure:(nullable void (^)(void))failure{
    path = [self getFinalPath:path];
    NSLog(@" =====================\n%@%@\n%@\n===================",[HttpManager sharedManager].sessionManager.baseURL.absoluteString,path,param);
    [[HttpManager sharedManager].sessionManager GET:path parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:(NSData*)responseObject options:NSJSONReadingMutableContainers error:nil];
        if(success)
            success(task, rootDict);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure)
            failure();
    }];
}


+ (NSString *)getFinalPath:(NSString *)apiPath{
    return [NSString stringWithFormat:@"%@/%@",RootPath, apiPath];
}


@end
