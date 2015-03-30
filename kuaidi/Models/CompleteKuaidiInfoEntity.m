//
//  CompleteKuaidiInfoModel.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "CompleteKuaidiInfoEntity.h"
#import "KuaidiDataEntity.h"

@implementation CompleteKuaidiInfoEntity

- (instancetype)initWithNSDictionary:(NSDictionary *)dict {
    self = [super init];
    if (dict == nil) {
        return self;
    }
    self.company = [dict objectForKey:@"com"];
    NSArray *data = [dict objectForKey:@"data"];
    self.info = [NSMutableArray arrayWithCapacity:[data count]];
    for (NSInteger i = 0; i < [data count]; i++) {
        KuaidiDataEntity *item = [[KuaidiDataEntity alloc] initWithNSDictionary:[data objectAtIndex:i]];
        [self.info addObject:item];
    }
    return self;
}

@end
