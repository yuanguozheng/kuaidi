//
//  StatusDetailViewController.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-25.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import "StatusDetailViewController.h"

@interface StatusDetailViewController ()

@end

@implementation StatusDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(backButtonClick:)];
    self.navigationItem.leftBarButtonItem = backButton;
    self.title = @"状态详情";
    NSLog(@"%@", [_transferData objectForKey:@"StatusData"]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)backButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
