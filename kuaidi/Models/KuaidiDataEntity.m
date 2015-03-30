//
//  KuaidiDataModel.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "KuaidiDataEntity.h"

@implementation KuaidiDataEntity

- (instancetype)initWithNSDictionary:(NSDictionary *)dict {
    self = [super init];
    if (dict) {
        self.time = [dict objectForKey:@"time"];
        self.context = [dict objectForKey:@"context"];
    }
    return self;
}

- (NSString *)context {
    if (_context) {
        return _context;
    } else {
        return nil;
    }
}

@end
