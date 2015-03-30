//
//  KuaidiInfoRequest.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kQueryUrlFormat @"http://m.kuaidi100.com/query?type=%@&postid=%@"

typedef void (^RequestFinishHandler)(NSDictionary *);

@interface KuaidiInfoRequest : NSObject

@property(nonatomic, strong) NSMutableData *responseData;
@property(nonatomic, strong) RequestFinishHandler handler;

- (void)requestKuaidiInfo:(NSString *)type postId:(NSString *)postId withFinishHandler:(RequestFinishHandler)handler;

@end
