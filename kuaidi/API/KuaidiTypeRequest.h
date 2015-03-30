//
//  KuaidiTypeRequest.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-18.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDetectUrl @"http://m.kuaidi100.com/autonumber/auto?num="

typedef void (^CompletitionHandler)(NSString *mdata);

@interface KuaidiTypeRequest : NSObject

@property(nonatomic, strong) NSMutableData *responseData;

@property(nonatomic, strong) CompletitionHandler myHandler;

- (void)requestType:(NSString *)postid withCompletitionHandler:(CompletitionHandler)handler;

@end