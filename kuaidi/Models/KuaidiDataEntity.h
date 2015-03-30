//
//  KuaidiDataModel.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KuaidiDataEntity : NSObject

@property(nonatomic, strong) NSString *time;
@property(nonatomic, strong) NSString *context;

- (instancetype)initWithNSDictionary:(NSDictionary *)dict;
- (NSString *)context;

@end
