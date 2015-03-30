//
//  QueryViewController.m
//  kuaidi
//
//  Created by yuanguozheng on 15-3-17.
//  Copyright (c) 2015年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompleteKuaidiInfoEntity.h"
#import "KuaidiCompanyRequest.h"
#import "KuaidiDataEntity.h"
#import "KuaidiInfoRequest.h"
#import "KuaidiTypeRequest.h"
#import "MBProgressHUD.h"
#import "PointView.h"
#import "QueryViewController.h"
#import "StatusDetailViewController.h"

#define kCompanyLabelHeight 30
#define kCompanyLabelY _companyLabel.frame.origin.y + kCompanyLabelHeight
#define kMarginLast 10
#define kMarginLeftRight 10
#define kNavY self.navigationController.navigationBar.frame.size.height
#define kNumFieldHeight 30
#define kNumFieldY _numField.frame.origin.y + kNumFieldHeight
#define kScreenHeight [UIScreen mainScreen].applicationFrame.size.height
#define kScreenWidth [UIScreen mainScreen].applicationFrame.size.width

@interface QueryViewController ()

@end

@implementation QueryViewController

- (void)initUI {
    UIBarButtonItem *queryButton = [[UIBarButtonItem alloc] initWithTitle:@"查询"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(selectRightAction:)];

    UIBarButtonItem *clearButton = [[UIBarButtonItem alloc] initWithTitle:@"清空"
                                                                    style:UIBarButtonItemStyleDone
                                                                   target:self
                                                                   action:@selector(selectLeftAction:)];

    [self.navigationItem setTitle:@"快递查询"];
    [self.navigationItem setRightBarButtonItem:queryButton];
    [self.navigationItem setLeftBarButtonItem:clearButton];
    _numField = [[UITextField alloc]
        initWithFrame:CGRectMake(kMarginLeftRight, kNavY + 30, kScreenWidth - 2 * kMarginLeftRight, kNumFieldHeight)];
    [_numField setBorderStyle:UITextBorderStyleRoundedRect];
    _numField.placeholder = @"输入快递单号";
    _numField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _numField.delegate = self;
    [self.view addSubview:_numField];

    self.companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kNumFieldY + kMarginLast, kScreenWidth, 30)];
    [self.companyLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_companyLabel];

    self.infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, kCompanyLabelY + kMarginLast, kScreenWidth,
                                                                   kScreenHeight - kCompanyLabelY - kMarginLast * 5)];
    if ([self.infoTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.infoTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.infoTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.infoTable setLayoutMargins:UIEdgeInsetsZero];
    }
    self.infoTable.tableFooterView = [[UIView alloc] init];
    _infoTable.dataSource = self;
    _infoTable.delegate = self;
    [self.view addSubview:_infoTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.isLoaded = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestCompanyName:(NSString *)companyId {
    KuaidiCompanyRequest *companyReq = [[KuaidiCompanyRequest alloc] init];
    __weak typeof(self) wSelf = self;
    [companyReq requestCompanyName:companyId
                       withHandler:^(NSString *companyName) {
                           [wSelf.companyLabel setText:[NSString stringWithFormat:@"快递公司：%@", companyName]];
                       }];
}

- (void)requestInfo:(NSString *)mdata postId:(NSString *)postId {
    KuaidiInfoRequest *infoReq = [[KuaidiInfoRequest alloc] init];
    [infoReq requestKuaidiInfo:mdata
                        postId:postId
             withFinishHandler:^(NSDictionary *responseDict) {
                 NSString *status = [responseDict objectForKey:@"status"];
                 NSString *message = [responseDict objectForKey:@"message"];
                 if (![status isEqualToString:@"200"]) {
                     [self alterMessage:message];
                 } else {
                     self.allInfo = [[CompleteKuaidiInfoEntity alloc] initWithNSDictionary:responseDict];
                     [_infoTable reloadData];
                     [self requestCompanyName:_allInfo.company];
                 }
                 [_mbHUD hide:YES];
             }];
}

- (void)selectRightAction:(id)sender {
    NSString *postId = [_numField text];
    if (postId == nil || [postId isEqualToString:@""]) {
        [self alterMessage:@"单号不正确"];
        return;
    }
    _mbHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _mbHUD.delegate = self;
    _mbHUD.color = [UIColor blackColor];
    _mbHUD.labelText = @"查询中";
    _mbHUD.dimBackground = NO;
    //__weak typeof(self) weakSelf = self;

    KuaidiTypeRequest *typeReq = [[KuaidiTypeRequest alloc] init];
    [typeReq requestType:postId
        withCompletitionHandler:^(NSString *mdata) {
            if (mdata != nil) {
                [self requestInfo:mdata postId:postId];
            } else {
                [self alterMessage:@"无法确定快递公司"];
                [_mbHUD hide:YES];
                return;
            }
        }];
}

- (void)selectLeftAction:(id)sender {
    [_numField setText:nil];
    self.allInfo = nil;
    [self.companyLabel setText:nil];
    [_infoTable reloadData];
}

- (void)alterMessage:(NSString *)msg {
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alter show];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_numField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_numField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allInfo.info.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Indertifier = @"Hi";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indertifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectMake(kMarginLeftRight, 0, kScreenWidth, 30.0)];
    }
    NSInteger index = [indexPath row];
    KuaidiDataEntity *rowObj = [_allInfo.info objectAtIndex:index];
    NSString *showText = [rowObj context];
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kScreenWidth - 60, cell.frame.size.height)];
    [msgLabel setText:showText];
    [cell addSubview:msgLabel];
    PointView *pv = [[PointView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height)];
    pv.backgroundColor = [UIColor clearColor];
    [pv setRadius:7.5];
    if (index == 0) {
        [pv setType:NOW];
    } else if (index == _allInfo.info.count - 1) {
        [pv setType:START];
    } else {
        [pv setType:PASS];
    }
    [cell addSubview:pv];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = [indexPath row];
    StatusDetailViewController *statusDetail = [[StatusDetailViewController alloc] init];
    statusDetail.transferData = [[NSMutableDictionary alloc] init];
    [statusDetail.transferData setObject:[_allInfo.info objectAtIndex:index] forKey:@"StatusData"];
    [self.navigationController pushViewController:statusDetail animated:YES];
}

- (void)tableView:(UITableView *)tableView
      willDisplayCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath

{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
