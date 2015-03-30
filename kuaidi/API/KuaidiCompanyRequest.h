//
//  KuaidiCompanyRequest.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-20.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCompanyNameUrlFormat @"http://www.kuaidi100.com/js/page/frame/baidu/company.js?com=%@"

typedef void (^FinishRequestHandler)(NSString *);

@interface KuaidiCompanyRequest : NSObject

@property(nonatomic, strong) NSMutableData *responseData;
@property(nonatomic, strong) FinishRequestHandler handler;

- (void)requestCompanyName:(NSString *)typeId withHandler:(FinishRequestHandler)handler;

@end
