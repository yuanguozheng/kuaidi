//
//  KuaidiTypeRequest.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-18.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "KuaidiTypeRequest.h"

@implementation KuaidiTypeRequest

- (void)requestType:(NSString *)postid withCompletitionHandler:(CompletitionHandler)handler {
    self.myHandler = handler;
    NSString *requestURL = [NSString stringWithFormat:@"%@%@", kDetectUrl, postid];
    requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:requestURL];
    self.responseData = [[NSMutableData alloc] init];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    [conn start];
    NSLog(@"Start Request");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_myHandler) {
        _myHandler(nil);
    }
    self.myHandler = nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Get Response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finish Loading");
    NSError *error;
    NSString *resStr = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", resStr);
    NSArray *json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSString *type;
    if (json == nil) {
        NSLog(@"JSON Parsed Failed.");
        type = nil;
    } else if (json.count == 0) {
        NSLog(@"Empty.");
        type = nil;
    } else {
        NSDictionary *companyInfo = [json objectAtIndex:0];
        if (companyInfo == nil) {
            type = nil;
        } else {
            type = [companyInfo objectForKey:@"comCode"];
        }
    }
    if (_myHandler) {
        _myHandler(type);
    }
    self.myHandler = nil;
}

@end
