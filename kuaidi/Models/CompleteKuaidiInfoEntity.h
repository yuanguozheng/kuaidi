//
//  CompleteKuaidiInfoModel.h
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompleteKuaidiInfoEntity : NSObject

@property(nonatomic, strong) NSString *company;
@property(nonatomic, strong) NSMutableArray *info;

- (instancetype)initWithNSDictionary:(NSDictionary *)dict;

@end
