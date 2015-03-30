//
//  KuaidiCompanyRequest.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-20.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "KuaidiCompanyRequest.h"

@implementation KuaidiCompanyRequest

- (void)requestCompanyName:(NSString *)typeId withHandler:(FinishRequestHandler)handler {
    self.handler = handler;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:kCompanyNameUrlFormat, typeId]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.responseData = [[NSMutableData alloc] init];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"Company Req: Get Response.");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Company Req: Finish Load.");
    NSMutableString *resString = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSRange jsonpRange = [resString rangeOfString:@"var jsoncom ="];
    [resString deleteCharactersInRange:jsonpRange];
    NSRange lastChar = [resString rangeOfComposedCharacterSequenceAtIndex:resString.length - 1];
    [resString deleteCharactersInRange:lastChar];
    NSData *finalStringData = [resString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:finalStringData options:kNilOptions error:&error];
    NSArray *company = [data objectForKey:@"company"];
    if (data && _handler) {
        _handler([[company objectAtIndex:0] objectForKey:@"companyname"]);
    }
}
@end
