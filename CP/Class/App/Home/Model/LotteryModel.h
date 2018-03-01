//
//  LotteryModel.h
//  CP
//
//  Created by Apple on 2018/1/17.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryModel : NSObject

@property(nonatomic, assign) NSNumber *id;
@property(nonatomic, copy) NSString *lottery_id;
@property(nonatomic, copy) NSString *pstatus;
@property(nonatomic, assign) NSNumber *expect;
@property(nonatomic, strong) NSString *opencode;
@property(nonatomic, strong) NSString *openname;
@property(nonatomic, strong) NSString *update_at;



@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *img;
@property(nonatomic, copy) NSString *detail;
@property(nonatomic, copy) NSMutableAttributedString *detailAttr;
@property(nonatomic, assign) NSNumber *range_start;
@property(nonatomic, assign) NSNumber *range_length;
@end
