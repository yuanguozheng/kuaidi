//
//  KuaidiInfoRequest.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-19.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "KuaidiInfoRequest.h"

@implementation KuaidiInfoRequest

- (void)requestKuaidiInfo:(NSString *)type postId:(NSString *)postId withFinishHandler:(RequestFinishHandler)handler {
    self.handler = handler;
    NSURL *url = [[NSURL alloc] initWithString:[NSString stringWithFormat:kQueryUrlFormat, type, postId]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.responseData = [[NSMutableData alloc] init];
    [conn start];
    NSLog(@"InfoReq: Start Request.");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"InfoReq: Get Response.");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if (data) {
        [self.responseData appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"InfoReq: Finish Load.");
    NSError *error;
    NSDictionary *responseDict =
        [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    if (_handler) {
        _handler(responseDict);
    }
    self.handler = nil;
}

@end
